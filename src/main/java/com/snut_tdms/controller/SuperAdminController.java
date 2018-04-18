package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.service.SuperAdminService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;

/**
 * 超级管理员controller层
 * Created by huankai on 2018/3/27.
 */
@Controller
@RequestMapping("/superAdmin")
public class SuperAdminController {

    private UserService userService;
    private SuperAdminService superAdminService;

    @Autowired
    public SuperAdminController(UserService userService, SuperAdminService superAdminService) {
        this.userService = userService;
        this.superAdminService = superAdminService;
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpSession httpSession, Model model) {
        return "superadmin/superAdminIndex";
    }

    @RequestMapping(value = "/superAdminCurrent", method = RequestMethod.GET)
    public String superAdminCurrent(HttpSession httpSession, Model model) {
        return "superadmin/superAdminCurrent";
    }

    @RequestMapping(value = "/superAdminLog", method = RequestMethod.GET)
    public String superAdminLog(HttpSession httpSession, Model model) {
        List<Log> logList = superAdminService.selectAllLogs();
        List<LogHelpClass> logHelpClassList = new ArrayList<>();
        for (Log log: logList) {
            if (log.getDescription()==null || "".equals(log.getDescription())){
                log.setDescription("无");
            }
            LogHelpClass logHelpClass = new LogHelpClass();
            logHelpClass.setOperatedType(log.getOperatedType());
            switch (log.getOperatedType()){
                case "文件":
                    Data data = userService.selectDataById(log.getOperatedId());
                    if (data!=null) {
                        data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_") + 1));
                        logHelpClass.setOperatedData(data);
                        logHelpClass.setOperatedDataUserInfo(userService.selectUserInfoByUsername(data.getUser().getUsername()));
                        logHelpClass.setOperatedDataUserRole(UserController.updateUserRole(userService.selectUserRoleByUsername(data.getUser().getUsername())));
                    }
                    break;
                case "文件类型":
                    logHelpClass.setOperatedDataClass(userService.selectDataClassById(log.getOperatedId()));
                    break;
                case "用户":
                    logHelpClass.setOperatedUserInfo(userService.selectUserInfoByUsername(log.getOperatedId()));
                    logHelpClass.setOperatedUserRole(UserController.updateUserRole(userService.selectUserRoleByUsername(log.getOperatedId())));
                    break;
                case "院系":
                    logHelpClass.setOperatedDepartment(userService.selectDepartmentByCode(log.getOperatedId()));
                    break;
            }
            logHelpClass.setLog(log);
            if (log.getOperationUser()!=null && userService.selectUserInfoByUsername(log.getOperationUser().getUsername())!=null){
                logHelpClass.setOperationUserInfo(userService.selectUserInfoByUsername(log.getOperationUser().getUsername()));
            }else {
                UserInfo userInfo = new UserInfo();
                if (log.getOperationUser()!=null && log.getOperationUser().getUsername() != null){
                    userInfo.setName("该用户已被删除!");
                    userInfo.setEmail("该用户已被删除!");
                    userInfo.setPhone("该用户已被删除!");
                }else {
                    userInfo.setName("无");
                    userInfo.setEmail("无");
                    userInfo.setPhone("无");
                }
                logHelpClass.setOperationUserInfo(userInfo);
            }
            if (log.getOperationUser()!=null && userService.selectUserRoleByUsername(log.getOperationUser().getUsername())!=null){
                logHelpClass.setOperationUserRole(UserController.updateUserRole(userService.selectUserRoleByUsername(log.getOperationUser().getUsername())));
            }else {
                UserRole userRole = new UserRole();
                if (log.getOperationUser()!=null && log.getOperationUser().getUsername() != null){
                    Role role = new Role();
                    role.setName("该用户已被删除!");
                    userRole.setRole(role);
                }else {
                    Role role = new Role();
                    role.setName("无");
                    userRole.setRole(role);
                }
                logHelpClass.setOperationUserRole(userRole);
            }
            logHelpClassList.add(logHelpClass);
        }
        model.addAttribute("logHelpClassList",logHelpClassList);
        return "superadmin/log";
    }
    @RequestMapping(value = "/departmentManage", method = RequestMethod.GET)
    public String departmentManage(HttpSession httpSession, Model model) {
        List<Department> departmentList = userService.selectAllDepartment();
        model.addAttribute("departmentList",departmentList);
        return "superadmin/departmentManage";
    }
    @RequestMapping(value = "/departmentAdminManage", method = RequestMethod.GET)
    public String departmentAdminManage(HttpSession httpSession, Model model) {
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        UserRole userRole = (UserRole) httpSession.getAttribute("userRole");
        model.addAttribute("adminUserInfoList",superAdminService.selectAllAdmin());
        return "superadmin/departmentAdminManage";
    }

    @RequestMapping(value = "/addDepartment", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addDepartment(HttpSession httpSession,@RequestBody Department department){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        List<Department> departmentList = new ArrayList<>();
        departmentList.add(department);
        JSONObject jsonObject = new JSONObject();
        if (userService.selectDepartmentByCode(department.getCode())!=null){
            jsonObject.put("message", StatusCode.INSERT_ERROR_CODE.getnCode());
        }else {
            jsonObject.put("message",superAdminService.insertDepartmentList(departmentList,userInfo.getUser()));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/addAdmin", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addAdmin(HttpSession httpSession,@RequestBody UserInfo userInfo){
        UserInfo superUserInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message",superAdminService.insertAdmin(userInfo.getUser().getUsername(),userInfo.getDepartment().getCode(),superUserInfo.getUser()));
        superAdminService.updateAdminUserInfo(userInfo,superUserInfo.getUser());
        return jsonObject;
    }

    @RequestMapping(value = "/deleteDepartment", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteDepartment(HttpSession httpSession,@RequestParam("code") String code){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectDepartmentByCode(code)==null){
            jsonObject.put("message", StatusCode.DELETE_NOT_CODE.getnCode());
        }else {
            List<String> departmentCodeList = new ArrayList<>();
            departmentCodeList.add(code);
            jsonObject.put("message",superAdminService.deleteDepartmentListByCodes(departmentCodeList,userInfo.getUser()));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/deleteAdmin", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteAdmin(HttpSession httpSession,@RequestParam("username") String username,@RequestParam("description") String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectUserInfoByUsername(username)==null){
            jsonObject.put("message", StatusCode.DELETE_USERNAME_ERROR.getnCode());
        }else {
            List<String> usernameList = new ArrayList<>();
            usernameList.add(username);
            jsonObject.put("message",superAdminService.deleteAdminByUsernameList(usernameList,userInfo.getUser(),description));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/updateDepartment", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updateDepartment(HttpSession httpSession,@RequestBody Department department){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectDepartmentByCode(department.getCode())==null){
            jsonObject.put("message", StatusCode.UPDATE_CODE_ERROR.getnCode());
        }else {
            jsonObject.put("message",superAdminService.updateDepartmentByCode(department,userInfo.getUser()).getnCode());
        }
        return jsonObject;
    }

    @RequestMapping(value = "/updateAdmin", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updateAdmin(@RequestParam("reset") Integer reset,HttpSession httpSession,@RequestBody UserInfo userInfo){
        UserInfo superUserInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        if (userService.selectUserInfoByUsername(userInfo.getUser().getUsername())==null || userService.selectDepartmentByCode(userInfo.getDepartment().getCode())==null){
            jsonObject.put("message",StatusCode.UPDATE_ERROR.getnCode());
        }else {
            userInfo.setUser(userService.selectUserInfoByUsername(userInfo.getUser().getUsername()).getUser());
            userInfo.setDepartment(userService.selectDepartmentByCode(userInfo.getDepartment().getCode()));
            String code = superAdminService.updateAdminUserInfo(userInfo,superUserInfo.getUser()).getnCode();
            if (reset==1){
                jsonObject.put("message",superAdminService.resetAdminPassword(userInfo.getUser().getUsername(),superUserInfo.getUser()).getnCode());
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
        jsonObject.put("message",superAdminService.recoverData(dataId,((UserInfo)httpSession.getAttribute("userInfo")).getUser()).getnCode());
        return jsonObject;
    }

    @RequestMapping(value = "/getAllDepartment", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getAllDepartment(){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("departmentList",userService.selectAllDepartment());
        return jsonObject;
    }



}
