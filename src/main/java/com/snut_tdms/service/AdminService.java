package com.snut_tdms.service;

import com.snut_tdms.dao.AdminDao;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.User;
import com.snut_tdms.model.po.UserInfo;
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
                m.put("content","院系管理员添加了一名用户");
                m.put("action","insert");
                m.put("operationUser",operationUser);
                m.put("operatedUser",selectUserInfoByUsername(username).getUser());
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
     * 删除本院系用户
     * @param usernameList 管理员用户名
     * @param operationUser 操作者
     * @param description 描述
     * @return String
     */
    public String deleteAdminByUsernameList(List<String> usernameList,User operationUser,String description){
        Map<String,Object> logParam = new HashMap<>();
        List<User> userList = new ArrayList<>();
        for (String username:usernameList) {
            userList.add(selectUserInfoByUsername(username).getUser());
        }
        if(userList.size()>0){
            logParam.put("content", "管理员删除了一名用户!");
            logParam.put("action","delete");
            logParam.put("operationUser", operationUser);
            logParam.put("description", description);
            for (User operatedUser:userList) {
                logParam.put("operatedUser", operatedUser);
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
    public List<Log> selectDepartmentLogs(String departmentCode){
        if (selectDepartmentByCode(departmentCode) != null) {
            return adminDao.selectDepartmentLogs(departmentCode);
        }else {
            return null;
        }
    }

    /**
     * 查询本院系不同角色的用户资料
     * @param roleId 角色ID
     * @return list
     */
    public List<UserInfo> selectUserByRole(String roleId, String departmentCode){
        List<User> list = adminDao.selectUserByRole(roleId);
        List<UserInfo> userInfoList = new ArrayList<>();
        for (User user:list) {
            UserInfo userInfo = selectUserInfoByUsername(user.getUsername());
            if (userInfo.getDepartment().getCode().equals(departmentCode)){
                userInfoList.add(userInfo);
            }
        }
        return userInfoList;
    }
}
