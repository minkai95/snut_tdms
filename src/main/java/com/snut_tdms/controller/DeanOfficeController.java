package com.snut_tdms.controller;

import com.snut_tdms.model.po.SystemNotice;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.service.DeanOfficeService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("userInfo",userInfo);
        return "deanOffice/deanOfficeIndex";
    }

    @RequestMapping(value = "/deanOfficeCurrent", method = RequestMethod.GET)
    public String deanOfficeCurrent(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Integer teacherPublicDataCount = deanOfficeService.selectDataCountByParams(1,null,"005");
        Integer deanOfficePublicDataCount = deanOfficeService.selectDataCountByParams(1,null,"004");
        Integer personDataCount = deanOfficeService.selectDataCountByParams(2,userInfo.getUser().getUsername(),null);
        Integer dataClassCount = userService.selectDepartmentDataClassCount(userInfo.getDepartment().getCode(),userRole.getRole().getId());
        Integer noticeCount = userService.selectAllNoticeCount(userInfo.getDepartment().getCode());
        model.addAttribute("publicDataCount",teacherPublicDataCount+deanOfficePublicDataCount);
        model.addAttribute("personDataCount",personDataCount);
        model.addAttribute("dataClassCount",dataClassCount);
        model.addAttribute("noticeCount",noticeCount);
        return "deanOffice/deanOfficeCurrent";
    }

    @RequestMapping(value = "/deanApplyDataClass", method = RequestMethod.GET)
    public String deanApplyDataClass(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("haveDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(1)",null));
        model.addAttribute("applyingDataClassList",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),userRole.getRole().getId(),"(0)",null));
        return "deanOffice/deanApplyDataClass";
    }

    @RequestMapping(value = "/deanOfficeNews", method = RequestMethod.GET)
    public String deanOfficeNews(HttpSession httpSession, Model model,
                                 @RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        model.addAttribute("noticeHelpList",userService.selectSystemNotice(userInfo.getDepartment().getCode(),null,null,page));
        model.addAttribute("page", page);
        return "deanOffice/deanOfficeNews";
    }

}
