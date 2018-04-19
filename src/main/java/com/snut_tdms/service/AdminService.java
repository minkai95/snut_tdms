package com.snut_tdms.service;

import com.snut_tdms.controller.UserController;
import com.snut_tdms.dao.AdminDao;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.LogHelpClass;
import com.snut_tdms.model.vo.UserHelpClass;
import com.snut_tdms.util.LogActionType;
import com.snut_tdms.util.OperatedType;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.*;

/**
 * 管理员service层
 * Created by huankai on 2018/3/27.
 */
@Service("adminService")
public class AdminService extends UserService{

    private AdminDao adminDao;
    private UserDao userDao;

    @Autowired
    public AdminService(AdminDao adminDao, UserDao userDao) {
        super(userDao);
        this.adminDao = adminDao;
        this.userDao = userDao;
    }

    /**
     * 管理员发布公告
     * @param systemNotice 公告
     * @param operationUser 管理员
     * @return 状态码
     */
    public StatusCode insertSystemNotice(SystemNotice systemNotice,User operationUser){
        if (adminDao.insertSystemNotice(systemNotice)>0){
            Map<String,Object> m = new HashMap<>();
            m.put("content","管理员发布了一条公告!");
            m.put("action", LogActionType.INSERT.getnCode());
            m.put("operationUser",operationUser);
            m.put("operatedId",systemNotice.getId());
            m.put("operatedType", OperatedType.SYSTEM_NOTICE.getnCode());
            insertLog(m);
            return StatusCode.PUBLISH_SUCCESS;
        }else {
            return StatusCode.PUBLISH_ERROR;
        }
    }

    /**
     * 管理员发布公告
     * @param classType 类目属性
     * @param operationUser 管理员
     * @return 状态码
     */
    public StatusCode insertClassType(ClassType classType,User operationUser){
        if (adminDao.insertClassType(classType)>0){
            Map<String,Object> m = new HashMap<>();
            m.put("content","管理员新增了一条类目属性!");
            m.put("action", LogActionType.INSERT.getnCode());
            m.put("operationUser",operationUser);
            m.put("operatedId",classType.getId());
            m.put("operatedType", OperatedType.CLASS_TYPE.getnCode());
            insertLog(m);
            return StatusCode.INSERT_SUCCESS;
        }else {
            return StatusCode.INSERT_ERROR;
        }
    }

    /**
     * 院系管理员新增本院用户
     * @param username 用户名
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @param operationUser 操作者
     * @return 状态码
     */
    public StatusCode insertUser(String username,String departmentCode,String roleId,User operationUser){
        if (selectUserInfoByUsername(username)==null){
            Map<String,Object> map = new HashMap<>();
            map.put("username",username);
            map.put("departmentCode",departmentCode);
            map.put("roleId",roleId);
            if(adminDao.insertUser(map)>0){
                Map<String,Object> m = new HashMap<>();
                m.put("content","院系管理员添加了一名用户!");
                m.put("action", LogActionType.INSERT.getnCode());
                m.put("operationUser",operationUser);
                m.put("operatedId",username);
                m.put("operatedType", OperatedType.USER.getnCode());
                insertLog(m);
                return StatusCode.INSERT_SUCCESS;
            } else {
                return StatusCode.INSERT_ERROR;
            }
        }else{
            return StatusCode.INSERT_ERROR_USERNAME;
        }
    }

    /**
     * 管理员删除类目属性
     * @param classTypeId 类目属性ID
     * @param operationUser 管理员
     * @return 状态码
     */
    public StatusCode deleteClassTypeById(String classTypeId,User operationUser,String description){
        if (adminDao.deleteClassTypeById(classTypeId)>0){
            Map<String,Object> m = new HashMap<>();
            m.put("content","管理员删除了一条类目属性!");
            m.put("action", LogActionType.DELETE.getnCode());
            m.put("operationUser",operationUser);
            m.put("operatedId",classTypeId);
            m.put("operatedType", OperatedType.CLASS_TYPE.getnCode());
            m.put("description",description);
            insertLog(m);
            return StatusCode.DELETE_SUCCESS;
        }else {
            return StatusCode.DELETE_ERROR;
        }
    }

    /**
     * 删除本院系用户
     * @param usernameList 管理员用户名
     * @param operationUser 操作者
     * @param description 描述
     * @return String
     */
    public String deleteUserByUsernameList(List<String> usernameList,User operationUser,String description){
        Map<String,Object> logParam = new HashMap<>();
        List<User> userList = new ArrayList<>();
        for (String username:usernameList) {
            userList.add(selectUserInfoByUsername(username).getUser());
        }
        if(userList.size()>0){
            logParam.put("content", "管理员删除了一名用户!");
            logParam.put("action",LogActionType.DELETE.getnCode());
            logParam.put("operationUser", operationUser);
            logParam.put("description", description);
            logParam.put("operatedType", OperatedType.USER.getnCode());
            for (User operatedUser:userList) {
                logParam.put("operatedId", operatedUser.getUsername());
                insertLog(logParam);
            }
        }
        int count = adminDao.deleteUserByUsernameList(usernameList);
        String resultStr;
        if(count==usernameList.size()){
            resultStr = count+"条用户信息删除成功!";
        }else if (count>0){
            resultStr = count+"条用户信息删除成功,"+(usernameList.size()-count)+"条删除失败!";
        }else{
            resultStr = StatusCode.DELETE_ERROR.getnCode();
        }
        return resultStr;
    }

    /**
     * 管理员查询本院系所有日志记录
     * @param departmentCode 院系编码
     * @return List
     */
    public List<LogHelpClass> selectDepartmentLogs(String departmentCode){
        return formatLog(adminDao.selectDepartmentLogs(departmentCode));
    }

    /**
     * 查询本院系不同角色的用户资料
     * @param roleId 角色ID
     * @return list
     */
    public List<UserHelpClass> selectUserByParams(String departmentCode, String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("roleId",roleId);
        map.put("departmentCode",departmentCode);
        String[] strArr = {"teacher","deanOffice","studentOffice"};
        List<String> target = Arrays.asList(strArr);
        List<UserHelpClass> userHelpClassList = new ArrayList<>();
        List<UserRole> list = adminDao.selectUserByParams(map);
        for (UserRole userRole:list) {
            UserInfo userInfo = selectUserInfoByUsername(userRole.getUser().getUsername());
            if (userInfo.getDepartment().getCode().equals(departmentCode) && target.contains(userRole.getRole().getName())){
                userHelpClassList.add(new UserHelpClass(userInfo,userRole));
            }
        }
        return userHelpClassList;
    }

    /**
     * 恢复用户删除文件
     * @param dataId 文件ID
     * @param operationUser 超级管理员
     * @return StatusCode
     */
    public StatusCode recoverData(String dataId,User operationUser){
        if (adminDao.recoverData(dataId)>0){
            Map<String,Object> map = new HashMap<>();
            map.put("content","管理员恢复了一份用户文件!");
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

    /**
     * 查询本院所有类目属性
     * @param departmentCode 院系编码
     * @return List
     */
    public List<ClassType> selectClassTypeByDepartmentCode(String departmentCode){
        return adminDao.selectClassTypeByDepartmentCode(departmentCode);
    }
}
