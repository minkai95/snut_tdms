package com.snut_tdms.controller;

import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.service.StudentOfficeService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.jws.Oneway;
import javax.servlet.http.HttpSession;
import java.util.*;

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

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("userInfo",userInfo);
        return "studentOffice/studentOfficeIndex";
    }

    @RequestMapping(value = "/studentOfficeCurrent", method = RequestMethod.GET)
    public String studentOfficeCurrent(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Map<String,Object> map = new HashMap<>();
        map.put("department",userInfo.getDepartment().getCode());
        map.put("roleId",userRole.getRole().getId());
        model.addAttribute("publicDataCount",studentOfficeService.selectStudentOfficeDataCount(map));
        map.remove("roleId");
        map.put("username",userInfo.getUser().getUsername());
        model.addAttribute("personDataCount",studentOfficeService.selectStudentOfficeDataCount(map));
        model.addAttribute("dataClassCount",userService.selectDepartmentDataClassCount(userInfo.getDepartment().getCode(),userRole.getRole().getId()));
        model.addAttribute("noticeCount",studentOfficeService.selectAdminNoticeCount(userInfo.getDepartment().getCode()));
        return "studentOffice/studentOfficeCurrent";
    }
    @RequestMapping(value = "/applyAddDataClass", method = RequestMethod.GET)
    public String applyAddDataClass(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("haveDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
        model.addAttribute("applyingDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(0)",null));
        return "studentOffice/applyAddDataClass";
    }
    @RequestMapping(value = "/studentOfficeNews", method = RequestMethod.GET)
    public String studentOfficeNews(HttpSession httpSession, Model model,
                                    @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        model.addAttribute("noticeHelpList",userService.selectSystemNotice(userInfo.getDepartment().getCode(),"002",page));
        model.addAttribute("page", page);
        return "studentOffice/studentOfficeNews";
    }
}
