package com.snut_tdms.controller;

import com.snut_tdms.service.SuperAdminService;
import com.snut_tdms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 超级管理员controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/superAdmin")
public class SuperAdminController {

    private UserService userService;
    private SuperAdminService superAdminService;

    @Autowired
    public SuperAdminController(UserService userService, SuperAdminService superAdminService) {
        this.userService = userService;
        this.superAdminService = superAdminService;
    }
}
