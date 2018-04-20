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
        Integer userCount = adminService.selectUserByParams(userInfo.getDepartment().getCode(),"(003,004,005)",null).size();
        Integer logCount = adminService.selectDepartmentLogs(userInfo.getDepartment().getCode(),null).size();
        Integer dataClassCount = userService.selectDataClass(userInfo.getDepartment().getCode(),null,"(1)",null).size();
        Integer newsCount = userService.selectSystemNotice(userInfo.getDepartment().getCode(),null,null).size();
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
        model.addAttribute("dataClassHelpClass",adminService.selectDataClassByRole(userInfo.getDepartment().getCode(),"004"));
        return "admin/typeManageDeanOffice";
    }

    @RequestMapping(value = "/typeManageTeacher", method = RequestMethod.GET)
    public String typeManageTeacher(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpClass",adminService.selectDataClassByRole(userInfo.getDepartment().getCode(),"005"));
        return "admin/typeManageTeacher";
    }

    @RequestMapping(value = "/typeManageStudentOffice", method = RequestMethod.GET)
    public String typeManageStudentOffice(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        model.addAttribute("dataClassHelpClass",adminService.selectDataClassByRole(userInfo.getDepartment().getCode(),"003"));
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

    @RequestMapping(value = "/selectClassType", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject selectClassType(HttpSession httpSession){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("classTypeList",userService.selectClassTypeByDepartmentCode(userInfo.getDepartment().getCode()));
        return jsonObject;
    }

    @RequestMapping(value = "/addDataClass", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addDataClass(HttpSession httpSession,
                                   @RequestParam("name") String name,
                                   @RequestParam("roleId") String roleId,
                                   @RequestParam(value="property1Id" ,required =false ) String property1Id,
                                   @RequestParam(value="property2Id" ,required =false ) String property2Id,
                                   @RequestParam(value="property3Id" ,required =false ) String property3Id){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        StringBuilder sb = new StringBuilder();
        if (!"undefined".equals(property1Id) && !"null".equals(property1Id)){
            sb.append(property1Id);
        }
        if (!"undefined".equals(property2Id) && !"null".equals(property2Id)){
            sb.append("/");
            sb.append(property2Id);
        }
        if (!"undefined".equals(property3Id) && !"null".equals(property3Id)){
            sb.append("/");
            sb.append(property3Id);
        }
        DataClass dataClass = new DataClass(SystemUtils.getUUID(),name,userService.selectRoleById(roleId),userInfo.getUser(),userInfo.getDepartment(),sb.toString(),1);
        jsonObject.put("message",userService.insertDataClass(dataClass,userInfo.getDepartment().getCode(),userInfo.getUser()).getnCode());
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
}
