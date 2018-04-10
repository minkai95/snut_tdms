package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
                case "superadmin":
                    session.setAttribute("role","superadmin");
                    json.put("urlStr", "/superadmin/index");
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
    public JSONObject uploadFile(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        String a = request.getParameter("fileType");
        String b = request.getParameter("description");
        jsonObject.put("message",userService.uploadFile(request).getnCode());
        return jsonObject;
    }

}
