package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.*;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.FileDownloadUtil;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
    public JSONObject login(@RequestParam("username") String username,
                            @RequestParam("password") String password,
                            @RequestParam("rememberPSW") String rememberPSW,
                            HttpSession session,HttpServletRequest request,HttpServletResponse response){
        JSONObject json = new JSONObject();
        Map<String,Object> result = userService.userLogin(username,password);
        StatusCode code = (StatusCode)result.get("StatusCode");
        UserRole userRole = (UserRole)result.get("userRole");
        if(StatusCode.LOGIN_SUCCESS.getnCode().equals(code.getnCode()) && (userRole.getUser().getFirstLogin()==1)){
            UserInfo userInfo = userService.selectUserInfoByUsername(username);
            session.setAttribute("userRole",userRole);
            session.setAttribute("userInfo",userInfo);
            session.setAttribute("role",userRole.getRole().getName());
            json.put("urlStr", "/"+userRole.getRole().getName()+"/index");
            if (rememberPSW.equals("1")){
                Cookie usernameCookie = new Cookie("username".trim(),username.trim());
                Cookie passwordCookie = new Cookie("password".trim(),password.trim());
                usernameCookie.setMaxAge(365*24*60*60);// 账号保存一年
                passwordCookie.setMaxAge(7*24*60*60);  // 密码保存7天
                usernameCookie.setPath("/");
                passwordCookie.setPath("/");
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            }else {
                Cookie[] cookies = request.getCookies();
                if (cookies.length>0) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("username")) {
                            cookie.setValue(null);
                            cookie.setMaxAge(0);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                        }
                        if (cookie.getName().equals("password")) {
                            cookie.setValue(null);
                            cookie.setMaxAge(0);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                        }
                    }
                }
            }
        }else if (StatusCode.LOGIN_SUCCESS.getnCode().equals(code.getnCode()) && (userRole.getUser().getFirstLogin()==0)){
            UserInfo userInfo = userService.selectUserInfoByUsername(username);
            session.setAttribute("userRole",userRole);
            session.setAttribute("userInfo",userInfo);
            json.put("urlStr", "/firstLogin.jsp");
        }else {
            json.put("message",code.getnCode());
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

    @RequestMapping(value = "/firstLoginUpdate", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject firstLoginUpdate(HttpSession httpSession, @RequestBody UserInfo userInfo,@RequestParam("roleId") String roleId) {
        JSONObject jsonObject = new JSONObject();
        userInfo.setDepartment(userService.selectDepartmentByCode(userInfo.getDepartment().getCode()));
        UserRole userRole = new UserRole(userInfo.getUser(),userService.selectRoleById(roleId));
        String code = userService.updateUserInfo(userInfo,userRole,userInfo.getUser()).getnCode();
        if (StatusCode.UPDATE_SUCCESS.getnCode().equals(code)){
            httpSession.setAttribute("userRole",userRole);
            httpSession.setAttribute("userInfo",userInfo);
            httpSession.setAttribute("role",userRole.getRole().getName());
            jsonObject.put("urlStr","/"+userRole.getRole().getName()+"/index");
        }else {
            jsonObject.put("urlStr","index.jsp");
        }
        jsonObject.put("message",code);
        return jsonObject;
    }

    @RequestMapping(value = "/sessionError")
    public String sessionError(@RequestParam("errorFlag") String errorFlag) {
        if ("sessionTimeoutError".equals(errorFlag)) {
            return "error/sessionTimeoutError";
        } else if ("roleError".equals(errorFlag)) {
            return "error/roleError";
        }else {
            return "";
        }
    }

    @RequestMapping(value = "/forgetPSW")
    public String forgetPSW(@RequestParam("username") String username,Model model) {
        model.addAttribute("username",username);
        return "../../forgetPassword";
    }

    @RequestMapping(value = "/forgetPSWNext",method = RequestMethod.GET)
    @ResponseBody
    public JSONObject forgetPSWNext(@RequestParam("username") String username,@RequestParam("idCard") String idCard){
        JSONObject json = new JSONObject();
        UserInfo userInfo = userService.selectUserInfoByUsername(username);
        if (userInfo!=null && idCard.equals(userInfo.getUser().getIdCard())){
            json.put("message",StatusCode.VALIDATE_SUCCESS.getnCode());
        }else {
            json.put("message",StatusCode.VALIDATE_ERROR.getnCode());
        }
        return json;
    }

    @RequestMapping(value = "/submitForgetPSW",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject submitForgetPSW(@RequestParam("username") String username,@RequestParam("password") String password){
        JSONObject json = new JSONObject();
        UserInfo userInfo = userService.selectUserInfoByUsername(username);
        userInfo.getUser().setPassword(password);
        json.put("message",userService.updatePassword(userInfo.getUser(),userInfo.getUser()).getnCode());
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
        List<DataClass> dataClassList=userService.selectDataClass(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null);
        List<DataClassHelpClass> result = new ArrayList<>();
        for (DataClass dataClass: dataClassList) {
            List<ClassType> classTypeList = userService.selectClassTypesByDataClassId(dataClass.getId());
            List<ClassTypeHelpClass> classTypeHelpClassList = new ArrayList<>();
            for (ClassType classType:classTypeList){
                if(classType!=null) {
                    classTypeHelpClassList.add(new ClassTypeHelpClass(classType, userService.selectTypeContentByParam(null, classType.getId())));
                }
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
        String c = request.getParameter("typeContentStr");
        if (request.getParameter("fileType")==null){
            List<DataClass> list = userService.selectDataClass(null,null,"(2)",null);
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
        saveFilename = saveFilename.replace("*","+");
        request.setAttribute("filename",saveFilename);
        request.setAttribute("departmentCode",userInfo.getDepartment().getCode());
        StatusCode code = FileDownloadUtil.download(request,response);
        System.out.println(code.getnCode());
    }

    @RequestMapping(value = "/selectFile",method = RequestMethod.GET)
    @ResponseBody
    public JSONObject downloadFile(HttpSession httpSession,HttpServletRequest request,
                                   @RequestParam("saveFilename") String saveFilename,
                                   @RequestParam(value = "realType",required = false) String realType){
        JSONObject jsonObject = new JSONObject();
        saveFilename = saveFilename.replace("*","+");
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        request.setAttribute("filename",saveFilename);
        request.setAttribute("realType",realType);
        request.setAttribute("departmentCode",userInfo.getDepartment().getCode());
        jsonObject.put("message",FileDownloadUtil.selectFile(request));
        return jsonObject;
    }

    @RequestMapping(value = "/deleteTempFile",method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteTempFile(){
        JSONObject jsonObject = new JSONObject();
        String rootPath = UserController.class.getResource("").getPath();
        rootPath = rootPath.substring(1,25).replace("/","\\");
        String path = rootPath+"\\src\\main\\webapp\\resources\\tempFile";
        File file = new File(path);
        int count=0;
        if (file.exists() && file.isDirectory()){
            File[] files = file.listFiles();
            if (files!=null) {
                for (File fi : files) {
                    if (fi.delete()) {
                        count++;
                    }
                }
            }
        }
        jsonObject.put("message",count);
        return jsonObject;
    }

    @RequestMapping(value = "/openPDF/{src}",method = RequestMethod.GET)
    public void displayPDF(HttpServletResponse response, @PathVariable("src") String src) {
        src = src.replace("~+~","\\")+".pdf";
        src = src.replace("*","+");
        try {
            File file = new File(src);
            FileInputStream fileInputStream = new FileInputStream(file);
            response.setHeader("Content-Disposition", "attachment;fileName=test.pdf");
            response.setContentType("multipart/form-data");
            OutputStream outputStream = response.getOutputStream();
            IOUtils.write(IOUtils.toByteArray(fileInputStream), outputStream);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/officeToPDF",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject officeToPDF(@RequestParam("src") String src){
        JSONObject jsonObject = new JSONObject();
        src = src.replace("~~","\\");
        src = src.replace("*","+");
        String wordFile = src;
        String pdfFile = src.substring(0,src.lastIndexOf("."))+".pdf";
        boolean result = SystemUtils.officeToPDF(wordFile,pdfFile);
        if (result){
            jsonObject.put("message",1);
        }else {
            jsonObject.put("message",0);
        }
        return jsonObject;
    }

    @RequestMapping(value = "/openPicture",method = RequestMethod.GET)
    public void openPicture(HttpSession httpSession,HttpServletRequest request,HttpServletResponse response,
                                  @RequestParam("saveFilename") String saveFilename){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        request.setAttribute("filename",saveFilename);
        request.setAttribute("departmentCode",userInfo.getDepartment().getCode());
        String path = FileDownloadUtil.selectFile(request);
        String aa = path.substring(41);
        response.setContentType("text/html; charset=UTF-8");
        response.setContentType("image/jpg");
        FileInputStream fis = null;
        OutputStream os = null;
        try
        {
            fis = new FileInputStream(request.getServletContext().getRealPath(aa+"\\"+saveFilename));
            os = response.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count = fis.read(buffer)) != -1)
                os.write(buffer, 0, count);
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null)
                try {
                    os.close();
                }catch (Exception e){
                    e.printStackTrace();
                }
            if (fis != null)
                try {
                    fis.close();
                }catch (Exception e){
                    e.printStackTrace();
                }
        }
    }

    @RequestMapping(value = "/deleteFile",method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteFile(@RequestParam("dataId") String dataId,@RequestParam("description") String description, HttpSession httpSession) {
        JSONObject jsonObject = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Data> dataList = new ArrayList<>();
        String[] strArr = dataId.split(",");
        for (String s:strArr) {
            dataList.add(userService.selectDataById(s));
        }
        jsonObject.put("message",userService.deleteFile(dataList,description,userInfo.getUser()).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/logicalDeleteDataById", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject logicalDeleteDataById(@RequestParam("id") String id ,@RequestParam("description") String description , HttpSession httpSession) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        String[] strArr = id.split(",");
        List<String>  list = Arrays.asList(strArr);
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
                            @RequestParam(value = "currentPage", required = false) String currentPage,
                            @RequestParam(value = "action", required = false) String action,
                            @RequestParam(value = "dataClassId", required = false) String dataClassId) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        String[] params = new String[2];
        params[0] = dataClassId;
        params[1] = action;
        Page page = SystemUtils.getPage(currentPage);
        if (action==null||"".equals(action)) {
            action = "('新增','删除','逻辑删除','恢复')";
        }else {
            action = "('"+action+"')";
        }
        List<Log> logs = userService.selectPersonLogs(userInfo.getUser().getUsername(),dataClassId,action,page);
        List<LogHelpClass> result = new ArrayList<>();
        for (Log log:logs) {
            if (log.getDescription()==null || "".equals(log.getDescription())){
                log.setDescription("暂无");
            }
            LogHelpClass logHelpClass = new LogHelpClass();
            logHelpClass.setLog(log);
            logHelpClass.setOperatedType(log.getOperatedType());
            logHelpClass.setOperationUserInfo(userService.selectUserInfoByUsername(log.getOperationUser().getUsername()));
            logHelpClass.setOperationUserRole(UserController.updateUserRole(userService.selectUserRoleByUsername(log.getOperationUser().getUsername())));
            if ("文件".equals(log.getOperatedType())) {
                Data data = userService.selectDataById(log.getOperatedId());
                if (data != null) {
                    data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_") + 1));
                    if (data.getContent() == null || "".equals(data.getContent())) {
                        data.setContent("暂无");
                    }
                    logHelpClass.setOperatedData(data);
                    logHelpClass.setOperatedDataClass(data.getDataClass());
                }
            }else if ("文件类型".equals(log.getOperatedType())){
                DataClass dataClass = userService.selectDataClassById(log.getOperatedId());
                if (dataClass != null){
                    dataClass.getRole().setName(UserController.updateUserRole(new UserRole(new User(),dataClass.getRole())).getRole().getName());
                    logHelpClass.setOperatedDataClass(dataClass);
                }
            }
            result.add(logHelpClass);
        }
        page.setSelectParam(params);
        model.addAttribute("dataClassList",userService.selectDataClass(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
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
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,null,0,2,page);
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
                                 @RequestParam(value = "currentPage", required = false) String currentPage,
                                 @RequestParam(value = "dataClassId", required = false) String dataClassId,
                                 @RequestParam(value = "typeContentStr", required = false) String typeContentStr) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        List<DataHelpClass> dataHelpClassList = new ArrayList<>();
        List<Data> list = userService.selectRoleAllPublicData(userInfo.getDepartment().getCode(),roleId,dataClassId,typeContentStr,page);
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
        List<DataClass> dataClassList = userService.selectDataClass(userInfo.getDepartment().getCode(),roleId,"(1)",null);
        List<DataClassHelpClass> dataClassHelpClassList = userService.formatDataClass(dataClassList);
        for (DataClassHelpClass dataClassHelpClass:dataClassHelpClassList) {
            if (dataClassHelpClass.getClassTypeHelpClassList()!=null&&dataClassHelpClass.getClassTypeHelpClassList().size()>0){
                for (ClassTypeHelpClass classTypeHelpClass:dataClassHelpClass.getClassTypeHelpClassList()) {
                    classTypeHelpClass.getClassType().setName(classTypeHelpClass.getClassType().getName().substring(4));
                }
            }
        }
        String[] typeContentArr = null;
        if (typeContentStr!=null && !"".equals(typeContentStr)) {
            typeContentArr = typeContentStr.split("/");
        }
        String[] params = new String[4];
        params[0]=dataClassId;
        if (typeContentArr!=null) {
            for (int i = 0; i < typeContentArr.length; i++) {
                if (typeContentArr[i] != null && !"".equals(typeContentArr[i])) {
                    params[i + 1] = typeContentArr[i];
                }
            }
        }
        page.setSelectParam(params);
        model.addAttribute("nowDataClassId",dataClassId);
        model.addAttribute("dataClassHelpList",dataClassHelpClassList);
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

    @RequestMapping(value = "/selectClassTypeByParam", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject selectClassTypeByParam(@RequestParam(value="dataClassId",required = false) String dataClassId,
                                             @RequestParam(value="typeContentId",required = false) String typeContentId){
        JSONObject jsonObject = new JSONObject();
        List<ClassTypeHelpClass> result = new ArrayList<>();
        List<ClassType> classTypeList = userService.selectClassTypesByDataClassId(dataClassId);
        for (ClassType classType: classTypeList) {
            result.add(new ClassTypeHelpClass(classType,userService.selectTypeContentByParam(typeContentId,classType.getId())));
        }
        jsonObject.put("result",result);
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
