package com.snut_tdms.controller;

import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.service.TeacherService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.OperatedType;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String teacherPublicData(HttpSession httpSession, Model model,
                                    @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Page page = SystemUtils.getPage(currentPage);
        List<Data> dataList = userService.selectDataByParams(userInfo.getUser().getUsername(),null,0,1,null,page);
        List<DataHelpClass> result = new ArrayList<>();
        for (Data data:dataList) {
            if(data.getContent()==null||"".equals(data.getContent())){
                data.setContent("暂无");
            }
            data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_")+1));
            result.add(new DataHelpClass(data,userService.selectUserInfoByUsername(data.getUser().getUsername())));
        }
        model.addAttribute("dataClassList",userService.selectDataClass(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
        model.addAttribute("dataList",result);
        model.addAttribute("page", page);
        return "teacher/teacherPublicData";
    }
    @RequestMapping(value = "/applyAddDataClass", method = RequestMethod.GET)
    public String applyAddDataClass(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("haveDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
        model.addAttribute("applyingDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(0)",null));
        return "teacher/applyAddDataClass";
    }
    @RequestMapping(value = "/teacherNews", method = RequestMethod.GET)
    public String teacherNews(HttpSession httpSession, Model model,
                              @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        model.addAttribute("noticeHelpList",userService.selectSystemNotice(userInfo.getDepartment().getCode(),null,page));
        model.addAttribute("page", page);
        return "teacher/teacherNews";
    }

}
