package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.*;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.FileDownloadUtil;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * 用户Controller层
 * Created by huankai on 2018/3/23.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session){
        JSONObject json = new JSONObject();
        Map<String,Object> result = userService.userLogin(username,password);
        StatusCode code = (StatusCode)result.get("StatusCode");
        UserRole userRole = (UserRole)result.get("userRole");
        if(StatusCode.LOGIN_SUCCESS.getnCode().equals(code.getnCode()) && (userRole.getUser().getFirstLogin()==1)){
            UserInfo userInfo = userService.selectUserInfoByUsername(username);
            session.setAttribute("userRole",userRole);
            session.setAttribute("userInfo",userInfo);
            switch (userRole.getRole().getName()){
                case "superAdmin":
                    session.setAttribute("role","superAdmin");
                    json.put("urlStr", "/superAdmin/index");
                    break;
                case "admin":
                    session.setAttribute("role","admin");
                    json.put("urlStr", "/admin/index");
                    break;
                case "studentOffice":
                    session.setAttribute("role","studentOffice");
                    json.put("urlStr", "/studentOffice/index");
                    break;
                case "deanOffice":
                    session.setAttribute("role","deanOffice");
                    json.put("urlStr", "/deanOffice/index");
                    break;
                case "teacher":
                    session.setAttribute("role","teacher");
                    json.put("urlStr", "/teacher/index");
                    break;
                default:
                    break;
            }
        }
        return json;
    }

    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
        httpSession.removeAttribute("userRole");
        httpSession.removeAttribute("userInfo");
        httpSession.removeAttribute("role");
        httpSession.invalidate();
        try {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/updatePerson",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updatePerson(@RequestParam("username") String username, @RequestParam("phone") String phone,@RequestParam("email") String email,@RequestParam("newPassword") String newPassword, HttpSession session){
        JSONObject json = new JSONObject();
        UserInfo userInfo = userService.selectUserInfoByUsername(username);
        if ((((userInfo.getPhone()==null||"".equals(userInfo.getPhone()))&&(phone==null||"".equals(phone)))||(userInfo.getPhone()!=null?userInfo.getPhone().equals(phone):phone.equals(userInfo.getPhone())))
                && (((userInfo.getEmail()==null||"".equals(userInfo.getEmail()))&&((email==null||"".equals(email))))||(userInfo.getEmail()!=null?userInfo.getEmail().equals(email):email.equals(userInfo.getEmail())))
                && ((userInfo.getUser().getPassword().equals(newPassword)) || ("".equals(newPassword) || newPassword==null)) ){
            json.put("message",StatusCode.UPDATE_NOT.getnCode());
        } else {
            userInfo.setPhone(phone);
            userInfo.setEmail(email);
            String upPsw = null;
            if(!"".equals(newPassword) && newPassword!=null){
                userInfo.getUser().setPassword(newPassword);
                User user = new User();
                user.setUsername(username);
                user.setPassword(newPassword);
                user.setIdCard(userInfo.getUser().getIdCard());
                upPsw = userService.updatePassword(user,userInfo.getUser()).getnCode();
            }
            String usIf = userService.updateUserInfo(userInfo,userService.selectUserRoleByUsername(userInfo.getUser().getUsername()),userInfo.getUser()).getnCode();
            if ((upPsw==null || upPsw.equals(StatusCode.NEW_PASSWORD_EQUALS_OLD.getnCode())) && (usIf.equals(StatusCode.UPDATE_NOT.getnCode()))){
                json.put("message",StatusCode.UPDATE_NOT.getnCode());
            }else {
                if (upPsw==null || !upPsw.equals(StatusCode.UPDATE_SUCCESS.getnCode())){
                    json.put("message",usIf);
                }else {
                    json.put("message",upPsw);
                }
            }
        }
        return json;
    }

    @RequestMapping(value = "/getDepartmentDataClass",method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getDepartmentDataClass(HttpSession httpSession) {
        JSONObject json = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        List<DataClass> dataClassList=userService.selectDataClass(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null);
        List<DataClassHelpClass> result = new ArrayList<>();
        for (DataClass dataClass: dataClassList) {
            List<ClassType> classTypeList = userService.selectClassTypesByDataClassId(dataClass.getId());
            List<ClassTypeHelpClass> classTypeHelpClassList = new ArrayList<>();
            for (ClassType classType:classTypeList){
                classTypeHelpClassList.add(new ClassTypeHelpClass(classType,userService.selectTypeContentByParam(null,classType.getId())));
            }
            DataClassHelpClass dataClassHelpClass = new DataClassHelpClass(dataClass,classTypeHelpClassList,userService.selectUserInfoByUsername(dataClass.getUser().getUsername()),userService.selectUserRoleByUsername(dataClass.getUser().getUsername()));
            result.add(dataClassHelpClass);
        }
        json.put("dataClassHelp",result);
        return json;
    }

    @RequestMapping(value = "/uploadFile",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject uploadFile(HttpServletRequest request,HttpSession httpSession) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        String a = request.getParameter("fileType");
        String b = request.getParameter("description");
        List<DataClass> list = userService.selectDataClass(userInfo.getDepartment().getCode(),null,"(2)",null);
        if (request.getParameter("fileType")==null){
            request.setAttribute("fileType",list.get(0).getId());
        }else {
            request.setAttribute("fileType",request.getParameter("fileType"));
        }
        jsonObject.put("message",userService.uploadFile(request).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
    public void downloadFile(HttpSession httpSession,HttpServletRequest request, HttpServletResponse response,@RequestParam("saveFilename") String saveFilename) throws IOException {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        request.setAttribute("filename",saveFilename);
        request.setAttribute("departmentCode",userInfo.getDepartment().getCode());
        StatusCode code = FileDownloadUtil.download(request,response);
        System.out.println(code.getnCode());
    }

    @RequestMapping(value = "/selectFile",method = RequestMethod.GET)
    @ResponseBody
    public JSONObject downloadFile(HttpSession httpSession,HttpServletRequest request,@RequestParam("saveFilename") String saveFilename){
        JSONObject jsonObject = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        request.setAttribute("filename",saveFilename);
        request.setAttribute("departmentCode",userInfo.getDepartment().getCode());
        jsonObject.put("message",FileDownloadUtil.selectFile(request).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/deleteFile",method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteFile(@RequestParam("dataId") String dataId,@RequestParam("description") String description, HttpSession httpSession) {
        JSONObject jsonObject = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Data data = userService.selectDataById(dataId);
        if(data != null && data.getFlag() != 2){
            jsonObject.put("message",userService.deleteFile(data,description,userInfo.getUser()).getnCode());
        } else {
            jsonObject.put("message", StatusCode.DELETE_ERROR_NOT_FILE.getnCode());
        }
        return jsonObject;
    }

    @RequestMapping(value = "/logicalDeleteDataById", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject logicalDeleteDataById(@RequestParam("id") String id ,@RequestParam("description") String description , HttpSession httpSession) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        List<String> list = new ArrayList<>();
        list.add(id);
        if (userService.logicalDeleteDataByIds(list,userInfo.getUser(),description)>0) {
            jsonObject.put("message", StatusCode.DELETE_SUCCESS.getnCode());
        }else {
            jsonObject.put("message",StatusCode.DELETE_ERROR.getnCode());
        }
        return jsonObject;
    }

    @RequestMapping(value = "/personCenter", method = RequestMethod.GET)
    public String personCenter(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("userInfo",userService.selectUserInfoByUsername(userInfo.getUser().getUsername()));
        return "include/personCenter";
    }

    @RequestMapping(value = "/dataTrace", method = RequestMethod.GET)
    public String dataTrace(HttpSession httpSession, Model model,
                            @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Page page = SystemUtils.getPage(currentPage);
        String action = "('新增','删除','逻辑删除','恢复')";
        List<Log> logs = userService.selectPersonLogs(userInfo.getUser().getUsername(),action,page);
        List<LogHelpClass> result = new ArrayList<>();
        for (Log log:logs) {
            if (log.getDescription()==null || "".equals(log.getDescription())){
                log.setDescription("暂无");
            }
            LogHelpClass logHelpClass = new LogHelpClass();
            logHelpClass.setLog(log);
            logHelpClass.setOperationUserInfo(userService.selectUserInfoByUsername(log.getOperationUser().getUsername()));
            UserRole userRole1 = UserController.updateUserRole(userService.selectUserRoleByUsername(log.getOperationUser().getUsername()));
            logHelpClass.setOperationUserRole(userRole1);
            Data data = userService.selectDataById(log.getOperatedId());
            logHelpClass.setOperatedType(log.getOperatedType());
            if (data != null){
                data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
                if(data.getContent()==null||"".equals(data.getContent())){
                    data.setContent("暂无");
                }
                logHelpClass.setOperatedData(data);
                logHelpClass.setOperatedDataClass(data.getDataClass());
            }
            result.add(logHelpClass);
        }
        model.addAttribute("page", page);
        model.addAttribute("logHelpList",result);
        switch (userRole.getRole().getName()){
            case "teacher":
                return "teacher/dataTrace";
            case "studentOffice":
                return "studentOffice/dataTrace";
            case "deanOffice":
                return "deanOffice/dataTrace";
            default:
                return "";
        }
    }

    @RequestMapping(value = "/personData", method = RequestMethod.GET)
    public String studentOfficePersonData(HttpSession httpSession, Model model,
                                          @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Page page = SystemUtils.getPage(currentPage);
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,2,null,page);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            if(data.getContent()==null||"".equals(data.getContent())){
                data.setContent("暂无");
            }
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataList",result);
        model.addAttribute("page", page);
        switch (userRole.getRole().getName()){
            case "teacher":
                return "teacher/teacherPersonData";
            case "studentOffice":
                return "studentOffice/studentOfficePersonData";
            case "deanOffice":
                return "deanOffice/deanOfficePersonData";
            default:
                return "";
        }
    }

    @RequestMapping(value = "/rolePublicData", method = RequestMethod.GET)
    public String rolePublicData(HttpSession httpSession, Model model,@RequestParam("roleId") String roleId,
                                 @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        List<DataHelpClass> dataHelpClassList = new ArrayList<>();
        List<Data> list = userService.selectRoleAllPublicData(userInfo.getDepartment().getCode(),roleId,page);
        for (Data data: list) {
            DataHelpClass dataHelpClass = new DataHelpClass();
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            if(data.getContent()==null||"".equals(data.getContent())){
                data.setContent("暂无");
            }
            dataHelpClass.setData(data);
            dataHelpClass.setUserInfo(userService.selectUserInfoByUsername(data.getUser().getUsername()));
            dataHelpClassList.add(dataHelpClass);
        }
        model.addAttribute("dataHelpClassList",dataHelpClassList);
        model.addAttribute("page", page);
        switch (roleId){
            case "003":
                return "studentOffice/studentOfficePublicData";
            case "004":
                return "deanOffice/deanOfficePublicData";
            case "005":
                return "deanOffice/teachersPublicData";
            default:
                return "";
        }
    }

    @RequestMapping(value = "/selectClassType", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject selectClassType(HttpSession httpSession){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("classTypeList",userService.selectClassTypeByDepartmentCode(userInfo.getDepartment().getCode(),null));
        return jsonObject;
    }

    @RequestMapping(value = "/addDataClass", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addDataClass(HttpSession httpSession,
                                   @RequestParam("name") String name,
                                   @RequestParam(value="roleId", required =false) String roleId,
                                   @RequestParam(value="property1Id" ,required =false ) String property1Id,
                                   @RequestParam(value="property2Id" ,required =false ) String property2Id,
                                   @RequestParam(value="property3Id" ,required =false ) String property3Id){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        if (roleId==null){
            roleId = userRole.getRole().getId();
        }
        int flag = 0;
        if ("admin".equals(userRole.getRole().getName())){
            flag = 1;
        }
        JSONObject jsonObject = new JSONObject();
        StringBuilder sb = new StringBuilder();
        if (!"undefined".equals(property1Id) && !"null".equals(property1Id)){
            sb.append(property1Id);
        }
        if (!"undefined".equals(property2Id) && !"null".equals(property2Id)){
            sb.append("/");
            sb.append(property2Id);
        }
        if (!"undefined".equals(property3Id) && !"null".equals(property3Id)){
            sb.append("/");
            sb.append(property3Id);
        }
        DataClass dataClass = new DataClass(SystemUtils.getUUID(),name,userService.selectRoleById(roleId),userInfo.getUser(),userInfo.getDepartment(),sb.toString(),flag);
        jsonObject.put("message",userService.insertDataClass(dataClass,userInfo.getDepartment().getCode(),userInfo.getUser()).getnCode());
        return jsonObject;
    }

    // 格式化UserRole
    public static UserRole updateUserRole(UserRole userRole){
        if (userRole != null) {
            switch (userRole.getRole().getName()) {
                case "superAdmin":
                    userRole.getRole().setName("超级管理员");
                    break;
                case "admin":
                    userRole.getRole().setName("管理员");
                    break;
                case "studentOffice":
                    userRole.getRole().setName("学办教师");
                    break;
                case "deanOffice":
                    userRole.getRole().setName("教务处教师");
                    break;
                case "teacher":
                    userRole.getRole().setName("教师");
                    break;
            }
        }
        return userRole;
    }

}
