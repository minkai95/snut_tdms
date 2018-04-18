package com.snut_tdms.service;

import com.snut_tdms.dao.SuperAdminDao;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.Page;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.OperatedType;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 超级管理员service层
 * Created by huankai on 2018/3/27.
 */
@Service("superAdminService")
public class SuperAdminService extends UserService {

    private SuperAdminDao superAdminDao;
    private UserDao userDao;

    @Autowired
    public SuperAdminService(UserDao userDao, SuperAdminDao superAdminDao) {
        super(userDao);
        this.superAdminDao = superAdminDao;
        this.userDao = userDao;
    }

    /**
     * 插入院系
     * @param departmentList 院系列表
     * @param user 超级管理员
     * @return Map
     */
    public String insertDepartmentList(List<Department> departmentList, User user){
        String result="";
        List<Department> relDepartmentList = new ArrayList<>();
        List<String> departmentCodeList = new ArrayList<>();
        List<String> departmentNameList = new ArrayList<>();
        Map<String,Object> map = new HashMap<>();
        map.put("page",null);
        for (Department department:userDao.selectAllDepartmentByPage(map)) {
            departmentCodeList.add(department.getCode());
            departmentNameList.add(department.getName());
        }
        for (Department department:departmentList) {
            if(!departmentCodeList.contains(department.getCode()) && !departmentNameList.contains(department.getName())){
                relDepartmentList.add(department);
            }
        }
        int count = 0;
        if(relDepartmentList.size()>0) {
            count = superAdminDao.insertDepartmentList(relDepartmentList);
        }
        if(count==departmentList.size()){
            result = count+"条院系数据成功插入成功!";
        }else if(count<departmentList.size()){
            result = count+"条院系数据插入成功,"+(departmentList.size()-count)+"条插入失败,请检查编码是否重复!";
        }
        if(count>0) {
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员新增一条院系!");
            logParams.put("action", LogActionType.INSERT.getnCode());
            logParams.put("operationUser", user);
            logParams.put("operatedType", OperatedType.DEPARTMENT.getnCode());
            for (Department department:relDepartmentList) {
                logParams.put("operatedId",department.getCode());
                insertLog(logParams);
            }
        }
        return result;
    }

    /**
     * 添加院系管理员
     * @param username 用户名
     * @param departmentCode 院系编码
     * @param operationUser 操作者
     * @return Map
     */
    public String insertAdmin(String username,String departmentCode,User operationUser){
        String result = "";
        Map<String,Object> relParams = new HashMap<>();
        relParams.put("username",username);
        relParams.put("departmentCode",departmentCode);
        if(selectUserInfoByUsername(username)!=null){
            result = "添加失败,该用户名已经存在！";
        }else if(selectDepartmentByCode(departmentCode)==null){
            result = "添加失败,院系编码不存在！";
        }else if(superAdminDao.insertAdmin(relParams)>0){
            result = StatusCode.INSERT_SUCCESS.getnCode();
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员新增了一名院系管理员！");
            logParams.put("action", LogActionType.INSERT.getnCode());
            logParams.put("operationUser", operationUser);
            logParams.put("operatedId", username);
            logParams.put("operatedType", OperatedType.USER.getnCode());
            insertLog(logParams);
        }else{
            result = "添加失败!";
        }
        return  result;
    }

    /**
     * 删除院系信息
     * @param departmentCodeList 院系编码
     * @param user 超级管理员
     * @return map
     */
    public String deleteDepartmentListByCodes(List<String> departmentCodeList,User user){
        List<String> reDepartmentCodeList = new ArrayList<>();
        List<String> codeList = new ArrayList<>();
        for (Department department: selectAllDepartment(null)){
            codeList.add(department.getCode());
        }
        for (String s:departmentCodeList) {
            if(!codeList.contains(s)){
                reDepartmentCodeList.add(s);
            }
        }
        int count = superAdminDao.deleteDepartmentListByCodes(departmentCodeList);
        String result = "";
        if(count>0 && count<departmentCodeList.size()){
            result = count+"条院系数据删除成功!"+(departmentCodeList.size()-count)+"条删除失败!";
        }else if(count==departmentCodeList.size()){
            result = count+"条院系数据删除成功!";
        }else {
            result = departmentCodeList.size()+"条院系数据删除失败!";
        }
        if(count>0){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员删除了一条院系数据!");
            logParams.put("action", LogActionType.DELETE.getnCode());
            logParams.put("operationUser", user);
            logParams.put("operatedType", OperatedType.DEPARTMENT.getnCode());
            for (String s:reDepartmentCodeList) {
                logParams.put("operatedId",s);
                insertLog(logParams);
            }
        }
        return result;
    }

    /**
     * 删除院系管理员
     * @param usernameList 管理员用户名
     * @param operationUser 操作者
     * @param description 描述
     * @return String
     */
    public String deleteAdminByUsernameList(List<String> usernameList,User operationUser,String description){
        List<String> relUsernameList = new ArrayList<>();
        for (String username: usernameList){
            if (selectUserInfoByUsername(username)!=null){
                relUsernameList.add(username);
            }
        }
        int count = superAdminDao.deleteAdminByUsernameList(usernameList);
        String result;
        if(count==usernameList.size()){
            result = count+"条管理员信息删除成功!";
        }else if (count>0){
            result = count+"条管理员信息删除成功,"+(usernameList.size()-count)+"条删除失败!";
        }else{
            result = "删除失败!";
        }
        if(!result.equals("删除失败!")){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", result);
            logParams.put("action", LogActionType.DELETE.getnCode());
            logParams.put("operationUser", operationUser);
            logParams.put("operatedType", OperatedType.USER.getnCode());
            logParams.put("description", description);
            for (String username: relUsernameList){
                logParams.put("operatedType",username);
                insertLog(logParams);
            }
        }
        return result;
    }

    /**
     * 修改院系
     * @param department 院系
     * @param operationUser 超级管理员
     * @return 状态码
     */
    public StatusCode updateDepartmentByCode(Department department,User operationUser){
        if(selectDepartmentByCode(department.getCode()).getName().equals(department.getName())){
            return StatusCode.UPDATE_NOT;
        }
        if(superAdminDao.updateDepartmentByCode(department)>0){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员修改了院系编码:"+department.getCode()+" 的院系信息");
            logParams.put("action", LogActionType.UPDATE.getnCode());
            logParams.put("operationUser", operationUser);
            logParams.put("operatedId", department.getCode());
            logParams.put("operatedType", OperatedType.DEPARTMENT.getnCode());
            insertLog(logParams);
            return StatusCode.UPDATE_SUCCESS;
        }else{
            return StatusCode.UPDATE_ERROR;
        }
    }

    /**
     * 修改管理员个人信息
     * @param userInfo 个人信息
     * @param operationUser 操作者
     * @return 状态码
     */
    public StatusCode updateAdminUserInfo(UserInfo userInfo,User operationUser) {
        StatusCode code = null;
        userInfo.setDepartment(selectDepartmentByCode(userInfo.getDepartment().getCode()));
        userInfo.setUser(selectUserInfoByUsername(userInfo.getUser().getUsername()).getUser());
        if(selectUserInfoByUsername(userInfo.getUser().getUsername())==null){
            code = StatusCode.NOT_USER;
        } else if (userInfo.equals(selectUserInfoByUsername(userInfo.getUser().getUsername()))) {
            code = StatusCode.UPDATE_NOT;
        } else if (superAdminDao.updateAdminUserInfo(userInfo)>0){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员修改了用户名:"+userInfo.getUser().getUsername()+" 的管理员信息!");
            logParams.put("action", LogActionType.UPDATE.getnCode());
            logParams.put("operationUser", operationUser);
            logParams.put("operatedId", userInfo.getUser().getUsername());
            logParams.put("operatedType", OperatedType.USER.getnCode());
            insertLog(logParams);
            code = StatusCode.UPDATE_SUCCESS;
        } else{
            code = StatusCode.UPDATE_ERROR;
        }
        return code;
    }

    /**
     * 查询全校日志记录
     * @return list
     */
    public List<Log> selectAllLogs(Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        return superAdminDao.selectAllLogsByPage(map);
    }

    /**
     * 查询所有院系管理员信息
     * @return list
     */
    public List<UserInfo> selectAllAdmin(Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        List<UserRole> userRoleList = superAdminDao.selectAllAdminByPage(map);
        List<UserInfo> userInfoList = new ArrayList<>();
        for (UserRole userRole: userRoleList) {
            userInfoList.add(selectUserInfoByUsername(userRole.getUser().getUsername()));
        }
        return  userInfoList;
    }

    /**
     * 恢复用户删除文件
     * @param dataId 文件ID
     * @param operationUser 超级管理员
     * @return StatusCode
     */
    public StatusCode recoverData(String dataId,User operationUser){
        if (superAdminDao.recoverData(dataId)>0){
            Map<String,Object> map = new HashMap<>();
            map.put("content","超级管理员恢复了一份用户文件!");
            map.put("action",LogActionType.RECOVER.getnCode());
            map.put("operatedId",dataId);
            map.put("operatedType",OperatedType.FILE.getnCode());
            map.put("operationUser",operationUser);
            insertLog(map);
            return StatusCode.RECOVER_SUCCESS;
        }else {
            return StatusCode.RECOVER_ERROR;
        }
    }
}
