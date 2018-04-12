package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.Data;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.service.AdminService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 管理员controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    private UserService userService;
    private AdminService adminService;

    @Autowired
    public AdminController(UserService userService, AdminService adminService) {
        this.userService = userService;
        this.adminService = adminService;
    }

}
