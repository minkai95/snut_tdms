package com.snut_tdms.service;

import com.snut_tdms.dao.UserDao;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.HashMap;

@Service("userService")
public class UserService {
    private UserDao userDao;

    @Autowired
    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public StatusCode insertUser(String username,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("roleId",roleId);
        if(userDao.insertUser(map)>0){
            return StatusCode.INSERT_SUCCESS;
        }else{
            return StatusCode.INSERT_ERROR;
        }
    }


}
