package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.FileDownloadUtil;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.StatusCode;
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
        json.put("dataClass",userService.selectDataClass(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
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
    public String dataTrace(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        List<Log> logs = userService.selectPersonLogs(userInfo.getUser().getUsername());
        List<Log> resultLog = new ArrayList<>();
        String[] strArr = {LogActionType.INSERT.getnCode(),LogActionType.DELETE.getnCode(),LogActionType.LOGICAL_DELETE.getnCode(),LogActionType.RECOVER.getnCode()};
        List<String> list = Arrays.asList(strArr);
        if (logs.size()>0) {
            for (Log log : logs) {
                if (list.contains(log.getAction())) {
                    resultLog.add(log);
                }
            }
        }
        List<LogHelpClass> result = new ArrayList<>();
        for (Log log:resultLog) {
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
    public String studentOfficePersonData(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,2,null);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            if(data.getContent()==null||"".equals(data.getContent())){
                data.setContent("暂无");
            }
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataList",result);
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
    public String rolePublicData(HttpSession httpSession, Model model,@RequestParam("roleId") String roleId) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        List<DataHelpClass> dataHelpClassList = new ArrayList<>();
        List<Data> list = userService.selectRoleAllPublicData(userInfo.getDepartment().getCode(),roleId);
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
