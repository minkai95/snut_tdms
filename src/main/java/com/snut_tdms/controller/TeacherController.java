package com.snut_tdms.controller;

import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.DataHelpClass;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.NoticeHelpClass;
import com.snut_tdms.service.TeacherService;
import com.snut_tdms.service.UserService;
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
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        Integer publicDataCount = teacherService.selectTeacherDataCount(userInfo.getUser().getUsername(),1);
        Integer personDataCount = teacherService.selectTeacherDataCount(userInfo.getUser().getUsername(),2);
        Integer dataClassCount = userService.selectDepartmentDataClassCount(userInfo.getDepartment().getCode(),userRole.getRole().getId());
        Integer noticeCount = userService.selectAllNoticeCount(userInfo.getDepartment().getCode());
        model.addAttribute("publicDataCount",publicDataCount);
        model.addAttribute("personDataCount",personDataCount);
        model.addAttribute("dataClassCount",dataClassCount);
        model.addAttribute("noticeCount",noticeCount);
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
    @RequestMapping(value = "/dataTrace", method = RequestMethod.GET)
    public String dataTrace(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Log> logs = userService.selectPersonLogs(userInfo.getUser().getUsername());
        List<Log> resultLog = new ArrayList<>();
        String[] strArr = {"insert","delete","logicalDelete"};
        List<String> list = Arrays.asList(strArr);
        if (logs.size()>0) {
            for (Log log : logs) {
                if (list.contains(log.getAction())) {
                    switch (log.getAction()){
                        case "insert":
                            log.setAction("新增");
                            break;
                        case "delete":
                            log.setAction("删除");
                            break;
                        case "logicalDelete":
                            log.setAction("逻辑删除");
                            break;
                    }
                    resultLog.add(log);
                }
            }
        }
        List<LogHelpClass> result = new ArrayList<>();
        for (Log log:resultLog) {
            if (log.getDescription()==null || "".equals(log.getDescription())){
                log.setDescription("暂无");
            }
            LogHelpClass logHelpClass = new LogHelpClass();
            logHelpClass.setLog(log);
            logHelpClass.setOperationUserInfo(userService.selectUserInfoByUsername(log.getOperationUser().getUsername()));
            UserRole userRole = UserController.updateUserRole(userService.selectUserRoleByUsername(log.getOperationUser().getUsername()));
            logHelpClass.setOperationUserRole(userRole);
            result.add(logHelpClass);
        }
        model.addAttribute("logHelpList",result);
        return "teacher/dataTrace";
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
