package com.snut_tdms.controller;

import com.snut_tdms.service.DeanOfficeService;
import com.snut_tdms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 教务处controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/deanOffice")
public class DeanOfficeController {

    private UserService userService;
    private DeanOfficeService deanOfficeService;

    @Autowired
    public DeanOfficeController(UserService userService, DeanOfficeService deanOfficeService) {
        this.userService = userService;
        this.deanOfficeService = deanOfficeService;
    }
}
