package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.UserRole;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping(value = "/login")
    @ResponseBody
    public String login(@RequestParam("username") String username,@RequestParam("password") String password, HttpSession session){
        Map<String,Object> jsonMap = new HashMap<>();
        Map<String,Object> result = userService.userLogin(username,password);
        StatusCode code = (StatusCode)result.get("StatusCode");
        UserRole userRole = (UserRole)result.get("userRole");
        jsonMap.put("code",code.getnCode());
        if(code.getnCode().equals(StatusCode.LOGIN_SUCCESS.getnCode())){
            session.setAttribute("userRole",userRole);
            switch (userRole.getRole().getName()){
                case "超级管理员":
                    session.setAttribute("userRole","superadmin");
                    jsonMap.put("urlStr", "/superadmin/index");
                    break;
                case "管理员":
                    session.setAttribute("userRole","admin");
                    jsonMap.put("urlStr", "/admin/index");
                    break;
                case "学办":
                    session.setAttribute("userRole","studentOffice");
                    jsonMap.put("urlStr", "/studentOffice/index");
                    break;
                case "教务处":
                    session.setAttribute("userRole","deanOffice");
                    jsonMap.put("urlStr", "/deanOffice/index");
                    break;
                default:
                    break;
            }
        }
        return JSONObject.toJSONString(jsonMap);
    }
}
