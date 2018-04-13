package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.FileDownloadUtil;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

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
                case "teacherOffice":
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
        if (userInfo.getPhone().equals(phone) && userInfo.getEmail().equals(email) && (userInfo.getUser().getPassword().equals(newPassword) || "".equals(newPassword) || newPassword==null) ){
            json.put("message",StatusCode.UPDATE_NOT.getnCode());
        } else {
            userInfo.setPhone(phone);
            userInfo.setEmail(email);
            if("".equals(newPassword) || newPassword==null){
                userInfo.getUser().setPassword(newPassword);
            }
            json.put("message",userService.updateUserInfo(userInfo,userInfo.getUser()).getnCode());
        }
        return json;
    }

    @RequestMapping(value = "/getDepartmentDataClass",method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getDepartmentDataClass(HttpSession httpSession) {
        JSONObject json = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        json.put("dataClass",userService.selectDataClass(userInfo.getDepartment().getCode(),null,"(1)",null));
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

    @RequestMapping(value = "/deleteFile",method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteFile(@RequestParam("dataId") String dataId,@RequestParam("description") String description, HttpSession httpSession) {
        JSONObject jsonObject = new JSONObject();
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Data data = userService.selectDataById(dataId);
        if(data != null){
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

    // 格式化UserRole
     static UserRole updateUserRole(UserRole userRole){
        switch (userRole.getRole().getName()){
            case "superAdmin":
                userRole.getRole().setName("超级管理员");
                break;
            case "admin":
                userRole.getRole().setName("管理员");
                break;
            case "teacherOffice":
                userRole.getRole().setName("学办教师");
                break;
            case "deanOffice":
                userRole.getRole().setName("教务处教师");
                break;
            case "teacher":
                userRole.getRole().setName("教师");
                break;
        }
        return userRole;
    }

}
