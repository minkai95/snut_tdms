package com.snut_tdms.service;

import com.snut_tdms.dao.SuperAdminDao;
import com.snut_tdms.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
