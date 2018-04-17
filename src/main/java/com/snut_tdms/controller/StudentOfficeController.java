package com.snut_tdms.controller;

import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.service.StudentOfficeService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.LogActionType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "/studentOfficePublicData", method = RequestMethod.GET)
    public String studentOfficePublicData(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        List<DataHelpClass> dataHelpClassList = new ArrayList<>();
        List<Data> list = userService.selectRoleAllPublicData(userInfo.getDepartment().getCode(),userRole.getRole().getId());
        for (Data data: list) {
            DataHelpClass dataHelpClass = new DataHelpClass();
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            dataHelpClass.setData(data);
            dataHelpClass.setUserInfo(userService.selectUserInfoByUsername(data.getUser().getUsername()));
            dataHelpClassList.add(dataHelpClass);
        }
        model.addAttribute("dataHelpClassList",dataHelpClassList);
        return "studentOffice/studentOfficePublicData";
    }
    @RequestMapping(value = "/studentOfficePersonData", method = RequestMethod.GET)
    public String studentOfficePersonData(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,2,null);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataList",result);
        return "studentOffice/studentOfficePersonData";
    }
    @RequestMapping(value = "/applyAddDataClass", method = RequestMethod.GET)
    public String applyAddDataClass(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");

        return "studentOffice/applyAddDataClass";
    }
    @RequestMapping(value = "/studentOfficeNews", method = RequestMethod.GET)
    public String studentOfficeNews(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<SystemNotice> list = userService.selectSystemNotice(userInfo.getDepartment().getCode(),"002");
        List<NoticeHelpClass> result = new ArrayList<>();
        for (SystemNotice systemNotice: list) {
            result.add(new NoticeHelpClass(systemNotice,userService.selectUserInfoByUsername(systemNotice.getUser().getUsername())));
        }
        model.addAttribute("noticeHelpList",result);
        return "studentOffice/studentOfficeNews";
    }
}
