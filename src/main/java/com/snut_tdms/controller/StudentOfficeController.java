package com.snut_tdms.controller;

import com.snut_tdms.service.StudentOfficeService;
import com.snut_tdms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 学办controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/studentOffice")
public class StudentOfficeController {

    private UserService userService;
    private StudentOfficeService studentOfficeService;

    @Autowired
    public StudentOfficeController(UserService userService, StudentOfficeService studentOfficeService) {
        this.userService = userService;
        this.studentOfficeService = studentOfficeService;
    }
}
