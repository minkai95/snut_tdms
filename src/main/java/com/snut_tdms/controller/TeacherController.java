package com.snut_tdms.controller;

import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.service.TeacherService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.OperatedType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("userInfo",userInfo);
        return "teacher/teacherIndex";
    }

    @RequestMapping(value = "/teacherCurrent", method = RequestMethod.GET)
    public String teacherCurrent(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Integer publicDataCount = teacherService.selectTeacherDataCount(userInfo.getUser().getUsername(),1);
        Integer personDataCount = teacherService.selectTeacherDataCount(userInfo.getUser().getUsername(),2);
        Integer dataClassCount = userService.selectDepartmentDataClassCount(userInfo.getDepartment().getCode(),userRole.getRole().getId());
        Integer noticeCount = userService.selectAllNoticeCount(userInfo.getDepartment().getCode());
        model.addAttribute("publicDataCount",publicDataCount);
        model.addAttribute("personDataCount",personDataCount);
        model.addAttribute("dataClassCount",dataClassCount);
        model.addAttribute("noticeCount",noticeCount);
        return "teacher/teacherCurrent";
    }

    @RequestMapping(value = "/teacherPublicData", method = RequestMethod.GET)
    public String teacherPublicData(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,1,null);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataList",result);
        return "teacher/teacherPublicData";
    }
    @RequestMapping(value = "/teacherPersonData", method = RequestMethod.GET)
    public String teacherPersonData(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,2,null);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataList",result);
        return "teacher/teacherPersonData";
    }
    @RequestMapping(value = "/applyAddDataClass", method = RequestMethod.GET)
    public String applyAddDataClass(HttpSession httpSession, Model model) {

        return "teacher/applyAddDataClass";
    }
    @RequestMapping(value = "/teacherNews", method = RequestMethod.GET)
    public String teacherNews(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<SystemNotice> list = userService.selectSystemNotice(userInfo.getDepartment().getCode(),null);
        List<NoticeHelpClass> result = new ArrayList<>();
        for (SystemNotice systemNotice: list) {
            result.add(new NoticeHelpClass(systemNotice,userService.selectUserInfoByUsername(systemNotice.getUser().getUsername())));
        }
        model.addAttribute("noticeHelpList",result);
        return "teacher/teacherNews";
    }

}
