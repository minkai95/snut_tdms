package com.snut_tdms.controller;

import com.snut_tdms.service.TeacherService;
import com.snut_tdms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 教师Controller层
 * Created by huankai on 2018/3/25.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {

    private UserService userService;
    private TeacherService teacherService;

    @Autowired
    public TeacherController(UserService userService, TeacherService teacherService) {
        this.userService = userService;
        this.teacherService = teacherService;
    }
}
