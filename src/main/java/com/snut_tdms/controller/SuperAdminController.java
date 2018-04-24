package com.snut_tdms.controller;

import com.alibaba.fastjson.JSONObject;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.service.SuperAdminService;
import com.snut_tdms.service.UserService;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
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
    public String superAdminLog(HttpSession httpSession, Model model,
                                @RequestParam(value = "currentPage", required = false) String currentPage,
                                @RequestParam(value = "departmentCode", required = false) String departmentCode,
                                @RequestParam(value = "action", required = false) String action,
                                @RequestParam(value = "operatedType", required = false) String operatedType) {
        Page page = SystemUtils.getPage(currentPage);
        String[] params = new String[3];
        params[0]=departmentCode;
        params[1]=action;
        params[2]=operatedType;
        List<LogHelpClass> logHelpClassList = superAdminService.selectAllLogs(departmentCode,action,operatedType,page);
        page.setSelectParam(params);
        model.addAttribute("departmentList",userService.selectAllDepartment(null));
        model.addAttribute("logHelpClassList",logHelpClassList);
        model.addAttribute("page", page);
        return "superadmin/log";
    }
    @RequestMapping(value = "/departmentManage", method = RequestMethod.GET)
    public String departmentManage(Model model, @RequestParam(value = "currentPage", required = false) String currentPage) {
        Page page = SystemUtils.getPage(currentPage);
        List<Department> departmentList = userService.selectAllDepartment(page);
        model.addAttribute("departmentList",departmentList);
        model.addAttribute("page",page);
        return "superadmin/departmentManage";
    }
    @RequestMapping(value = "/departmentAdminManage", method = RequestMethod.GET)
    public String departmentAdminManage(HttpSession httpSession, Model model,
                                        @RequestParam(value = "currentPage", required = false) String currentPage) {
        Page page = SystemUtils.getPage(currentPage);
        model.addAttribute("adminUserInfoList",superAdminService.selectAllAdmin(page));
        model.addAttribute("page",page);
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
    public JSONObject deleteDepartment(HttpSession httpSession,@RequestParam("code") String code,
                                       @RequestParam(value = "description",required = false)String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        String[] strArr = code.split(",");
        List<String> departmentCodeList = Arrays.asList(strArr);
        if (userService.selectDepartmentByCode(strArr[0])==null){
            jsonObject.put("message", StatusCode.DELETE_NOT_CODE.getnCode());
        }else {
            jsonObject.put("message",superAdminService.deleteDepartmentListByCodes(departmentCodeList,userInfo.getUser(),description));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/deleteAdmin", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONObject deleteAdmin(HttpSession httpSession,@RequestParam("username") String username,@RequestParam("description") String description){
        UserInfo userInfo = (UserInfo) httpSession.getAttribute("userInfo");
        JSONObject jsonObject = new JSONObject();
        String[] strArr = username.split(",");
        List<String> usernameList = Arrays.asList(strArr);
        if (userService.selectUserInfoByUsername(strArr[0])==null){
            jsonObject.put("message", StatusCode.DELETE_USERNAME_ERROR.getnCode());
        }else {
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
    public JSONObject getAllDepartment(@RequestParam(value = "currentPage", required = false) String currentPage){
        JSONObject jsonObject = new JSONObject();
        Page page = SystemUtils.getPage(currentPage);
        jsonObject.put("departmentList",userService.selectAllDepartment(page));
        return jsonObject;
    }



}
