package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.model.vo.UserHelpClass;
import com.snut_tdms.service.AdminService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 管理员controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    private UserService userService;
    private AdminService adminService;

    @Autowired
    public AdminController(UserService userService, AdminService adminService) {
        this.userService = userService;
        this.adminService = adminService;
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("userInfo",userInfo);
        return "admin/adminIndex";
    }

    @RequestMapping(value = "/adminCurrent", method = RequestMethod.GET)
    public String adminCurrent(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page1 = SystemUtils.getPage("");
        Page page2 = SystemUtils.getPage("");
        Page page3 = SystemUtils.getPage("");
        adminService.selectDepartmentLogs(userInfo.getDepartment().getCode(),page1);
        adminService.selectUserByParams(userInfo.getDepartment().getCode(),"(003,004,005)",page2);
        userService.selectSystemNotice(userInfo.getDepartment().getCode(),null,page3);
        Integer logCount = page1.getTotalNumber();
        Integer userCount = page2.getTotalNumber();
        Integer newsCount = page3.getTotalNumber();
        Integer dataClassCount = userService.selectDataClass(userInfo.getDepartment().getCode(),null,"(1)",null).size();
        model.addAttribute("userInfo",userInfo);
        model.addAttribute("userCount",userCount);
        model.addAttribute("logCount",logCount);
        model.addAttribute("dataClassCount",dataClassCount);
        model.addAttribute("newsCount",newsCount);
        return "admin/adminCurrent";
    }

    @RequestMapping(value = "/adminUserManage", method = RequestMethod.GET)
    public String adminUserManage(HttpSession httpSession, Model model,@RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        List<UserHelpClass> userHelpClassList = adminService.selectUserByParams(userInfo.getDepartment().getCode(),"(003,004,005)",page);
        for (UserHelpClass userHelpClass:userHelpClassList) {
            userHelpClass.setUserRole(UserController.updateUserRole(userHelpClass.getUserRole()));
        }
        model.addAttribute("page", page);
        model.addAttribute("userHelpClassList",userHelpClassList);
        return "admin/adminUserManage";
    }

    @RequestMapping(value = "/adminLog", method = RequestMethod.GET)
    public String adminLog(HttpSession httpSession, Model model,@RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        List<LogHelpClass> logHelpClassList = adminService.selectDepartmentLogs(userInfo.getDepartment().getCode(),page);
        model.addAttribute("logHelpClassList",logHelpClassList);
        model.addAttribute("page", page);
        return "admin/adminLog";
    }

    @RequestMapping(value = "/typeManageDeanOffice", method = RequestMethod.GET)
    public String typeManageDeanOffice(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpClass",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),"004","(1)",null));
        return "admin/typeManageDeanOffice";
    }

    @RequestMapping(value = "/typeManageTeacher", method = RequestMethod.GET)
    public String typeManageTeacher(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpClass",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),"005","(1)",null));
        return "admin/typeManageTeacher";
    }

    @RequestMapping(value = "/typeManageStudentOffice", method = RequestMethod.GET)
    public String typeManageStudentOffice(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpClass",userService.selectDataClassRHelp(userInfo.getDepartment().getCode(),"003","(1)",null));
        return "admin/typeManageStudentOffice";
    }

    @RequestMapping(value = "/typeProperty", method = RequestMethod.GET)
    public String typeProperty(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("classTypeList",userService.selectClassTypeByDepartmentCode(userInfo.getDepartment().getCode()));
        return "admin/typeProperty";
    }

    @RequestMapping(value = "/adminNews", method = RequestMethod.GET)
    public String adminNews(HttpSession httpSession, Model model,@RequestParam(value = "currentPage", required = false) String currentPage) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        Page page = SystemUtils.getPage(currentPage);
        model.addAttribute("noticeHelpList",userService.selectSystemNotice(userInfo.getDepartment().getCode(),null,page));
        model.addAttribute("page", page);
        return "admin/adminNews";
    }

    @RequestMapping(value = "/adminDataCopy", method = RequestMethod.GET)
    public String adminDataCopy(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("userInfo",userInfo);
        return "admin/adminDataCopy";
    }

    @RequestMapping(value = "/typeApplyList", method = RequestMethod.GET)
    public String typeApplyList(HttpSession httpSession, Model model,@RequestParam(value = "currentPage", required = false) String currentPage) {
        Page page = SystemUtils.getPage(currentPage);
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpList",userService.selectDataClassRHelpByPage(userInfo.getDepartment().getCode(),null,"(0,1,3)","('teacher','deanOffice','studentOffice')",page));
        model.addAttribute("page",page);
        return "admin/typeApplyList";
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addUser(HttpSession httpSession, @RequestBody UserInfo userInfo,@RequestParam("roleId") String roleId) {
        JSONObject jsonObject = new JSONObject();
        UserInfo adminUserInfo = (UserInfo) httpSession.getAttribute("userInfo");
        userInfo.setDepartment(adminUserInfo.getDepartment());
        jsonObject.put("message",adminService.insertUser(userInfo.getUser().getUsername(),userInfo.getDepartment().getCode(),roleId,userInfo.getUser()).getnCode());
        userInfo.setUser(userService.selectUserInfoByUsername(userInfo.getUser().getUsername()).getUser());
        userService.updateUserInfo(userInfo,userService.selectUserRoleByUsername(userInfo.getUser().getUsername()),adminUserInfo.getUser());
        return jsonObject;
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteUser(HttpSession httpSession,@RequestParam("username") String username,@RequestParam("description") String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectUserInfoByUsername(username)==null){
            jsonObject.put("message", StatusCode.DELETE_USERNAME_ERROR.getnCode());
        }else {
            List<String> usernameList = new ArrayList<>();
            usernameList.add(username);
            jsonObject.put("message",adminService.deleteUserByUsernameList(usernameList,userInfo.getUser(),description));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updateUser(@RequestParam("reset") Integer reset,
                                 @RequestParam("roleId") String roleId,
                                 HttpSession httpSession,@RequestBody UserInfo userInfo){
        UserInfo adminUserInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectUserInfoByUsername(userInfo.getUser().getUsername())==null){
            jsonObject.put("message",StatusCode.UPDATE_ERROR.getnCode());
        }else {
            userInfo.setDepartment(adminUserInfo.getDepartment());
            userInfo.setUser(userService.selectUserInfoByUsername(userInfo.getUser().getUsername()).getUser());
            UserRole userRole = userService.selectUserRoleByUsername(userInfo.getUser().getUsername());
            userRole.setRole(userService.selectRoleById(roleId));
            String code = userService.updateUserInfo(userInfo,userRole,adminUserInfo.getUser()).getnCode();
            if (reset==1){
                jsonObject.put("message",userService.resetAdminPassword(userInfo.getUser().getUsername(),adminUserInfo.getUser()).getnCode());
            }else {
                jsonObject.put("message",code);
            }
        }
        return jsonObject;
    }

    @RequestMapping(value = "/recoverData", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject recoverData(@RequestParam("dataId") String dataId,HttpSession httpSession){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message",adminService.recoverData(dataId,((UserInfo)httpSession.getAttribute("userInfo")).getUser()).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/publishNews", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject publishNews(@RequestParam("title") String title,@RequestParam("content") String content,HttpSession httpSession){
        JSONObject jsonObject = new JSONObject();
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        SystemNotice systemNotice = new SystemNotice(SystemUtils.getUUID(),title,content,new Timestamp(System.currentTimeMillis()),userRole.getUser(),userRole.getRole());
        jsonObject.put("message",adminService.insertSystemNotice(systemNotice,userRole.getUser()).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/addClassType", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addClassType(@RequestParam("name") String name,HttpSession httpSession){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        ClassType classType = new ClassType(SystemUtils.getUUID(),name,userInfo.getDepartment(),userInfo.getUser());
        jsonObject.put("message",adminService.insertClassType(classType,userInfo.getUser()).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/deleteTypeClass", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteTypeClass(@RequestParam("typeClassId") String typeClassId,@RequestParam("description") String description,HttpSession httpSession){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message",adminService.deleteClassTypeById(typeClassId,userInfo.getUser(),description).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/deleteDataClass", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteDataClass(HttpSession httpSession, @RequestParam("dataClassId") String dataClassId, @RequestParam("description") String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message",adminService.deleteDataClassById(dataClassId,userInfo.getUser(),description).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/updateDataClass", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updateDataClass(HttpSession httpSession,
                                      @RequestParam("flag") String flag,
                                      @RequestParam("dataClassId") String dataClassId,
                                      @RequestParam(value="description",required = false) String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        Integer f = Integer.valueOf(flag);
        jsonObject.put("message",adminService.updateDataClass(dataClassId,f,userInfo.getUser(),description).getnCode());
        return jsonObject;
    }

}
