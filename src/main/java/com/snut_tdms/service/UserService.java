package com.snut_tdms.service;

import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service("userService")
public class UserService {
    private UserDao userDao;

    @Autowired
    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    /**
     * 用户插入日志记录
     * @param map
     * @return 状态码
     */
    public StatusCode insertLog(Map<String,Object> map){
        String id = SystemUtils.getUUID();
        String content = (String) map.get("content");
        String action = (String) map.get("action");
        Timestamp time = new Timestamp(System.currentTimeMillis());
        User operationUser = (User) map.get("operationUser");
        User operatedUser = (User) map.get("operatedUser");
        if(userDao.insertLog(new Log(id,content,action,time,operationUser,operatedUser))>0){
            return StatusCode.INSERT_SUCCESS;
        }else{
            return StatusCode.INSERT_ERROR;
        }
    }

    /**
     * 新增资料类型(申请/直接添加)
     * @param dataClass
     * @param departmentCode
     * @param operationUser
     * @return 状态码
     */
    public StatusCode insertDataClass(DataClass dataClass,String departmentCode,User operationUser){
        List<DataClass> dataClassList = selectDataClass(departmentCode,"");
        List<String> list = new ArrayList<>();
        for (DataClass d: dataClassList) {
            if(d!=null){
                list.add(d.getName());
            }
        }
        if(!list.contains(dataClass.getName())) {
            if (userDao.insertDataClass(dataClass) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","insert");
                map.put("operationUser",operationUser);
                map.put("operatedUser",dataClass.getUser());
                if(dataClass.getFlag()==0){
                    map.put("content","用户申请新增类目！");
                    insertLog(map);
                    return StatusCode.APPLY_SUCCESS;
                }else if (dataClass.getFlag()==1){
                    map.put("content","管理员新增了一条类目！");
                    insertLog(map);
                    return StatusCode.INSERT_SUCCESS;
                }
            } else {
                return StatusCode.APPLY_ERROR;
            }
        }else{
            return StatusCode.DATA_CLASS_ERROR;
        }
        return StatusCode.INSERT_ERROR;
    }

    /**
     * 用户更新密码
     * @param user
     * @return 状态码
     */
    public StatusCode updatePassword(User user,User operationUser){
        if((userDao.selectUserByUsername(user.getUsername())).getUser().getPassword().equals(user.getPassword())){
            return StatusCode.NEW_PASSWORD_EQUALS_OLD;
        }else {
            String password = user.getPassword();
            user = userDao.selectUserByUsername(user.getUsername()).getUser();
            user.setPassword(password);
            if (userDao.updatePassword(user) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","update");
                map.put("content","用户更新了密码");
                map.put("operationUser",operationUser);
                map.put("operatedUser",userDao.selectUserByUsername(user.getUsername()).getUser());
                insertLog(map);
                return StatusCode.UPDATE_SUCCESS;
            } else {
                return StatusCode.UPDATE_ERROR;
            }
        }
    }

    /**
     * 用户更新个人信息
     * @param userInfo
     * @return 状态码
     */
    public StatusCode updateUserInfo(UserInfo userInfo,User operationUser){
        if(!userInfo.equals(userDao.selectUserInfoByUsername(userInfo.getUser().getUsername()))) {
            if (userDao.updateUserInfo(userInfo) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","update");
                map.put("content","用户更新了个人信息");
                map.put("operationUser",operationUser);
                map.put("operatedUser",userDao.selectUserByUsername(userInfo.getUser().getUsername()).getUser());
                insertLog(map);
                return StatusCode.UPDATE_SUCCESS;
            } else {
                return StatusCode.UPDATE_ERROR;
            }
        }else{
            return StatusCode.UPDATE_NOT;
        }
    }

    /**
     * 用户登录功能
     * @param username
     * @param password
     * @return Map
     */
    public Map<String, Object> userLogin(String username,String password){
        Map<String,Object> map = new HashMap<>();
        UserRole userRole = userDao.selectUserByUsername(username);
        if(userRole != null){
            if(userRole.getUser().getPassword().equals(password)){
                Map<String,Object> m = new HashMap<>();
                m.put("action","login");
                m.put("content","用户登录了");
                m.put("operationUser",userRole.getUser());
                m.put("operatedUser",userRole.getUser());
                insertLog(m);
                map.put("StatusCode",StatusCode.LOGIN_SUCCESS);
                map.put("userRole",userRole);
            }else{
                map.put("StatusCode",StatusCode.PASSWORD_ERROR);
            }
        }else{
            map.put("StatusCode",StatusCode.NOT_USER);
        }
        return map;
    }

    /**
     * 查询本院公告(roleId为空表示查看所有公告)
     * @param departmentCode
     * @param roleId
     * @return List
     */
    public List<SystemNotice> selectSystemNotice(String departmentCode,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        return userDao.selectSystemNotice(map);
    }

    /**
     * 查询本院公共资料类型,如果roleId为空则查询本院所有公共资料类型
     * @param departmentCode
     * @param roleId
     * @return List
     */
    public List<DataClass> selectDataClass(String departmentCode,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        return userDao.selectDataClass(map);
    }

    /**
     * 根据用户名查询用户资料
     * @param username
     * @return UserInfo
     */
    public UserInfo selectUserInfoByUsername(String username){
        return userDao.selectUserInfoByUsername(username);
    }


}
