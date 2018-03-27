package com.snut_tdms.service;

import com.snut_tdms.dao.StudentOfficeDao;
import com.snut_tdms.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 学办service
 * Created by huankai on 2018/3/27.
 */
@Service("studentOfficeService")
public class StudentOfficeService extends UserService{

    private StudentOfficeDao studentOfficeDao;
    private UserDao userDao;

    @Autowired
    public StudentOfficeService(UserDao userDao, StudentOfficeDao studentOfficeDao) {
        super(userDao);
        this.userDao = userDao;
        this.studentOfficeDao = studentOfficeDao;
    }
}
