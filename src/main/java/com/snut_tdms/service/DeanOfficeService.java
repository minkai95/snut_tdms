package com.snut_tdms.service;

import com.snut_tdms.dao.DeanOfficeDao;
import com.snut_tdms.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 教务处service层
 * Created by huankai on 2018/3/27.
 */
@Service("deanOfficeService")
public class DeanOfficeService extends UserService{

    private UserDao userDao;
    private DeanOfficeDao deanOfficeDao;

    @Autowired
    public DeanOfficeService(UserDao userDao, DeanOfficeDao deanOfficeDao) {
        super(userDao);
        this.userDao = userDao;
        this.deanOfficeDao = deanOfficeDao;
    }

    public Integer selectDataCountByParams(String departmentCode,Integer dataClassFlag,String username,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("dataClassFlag",dataClassFlag);
        map.put("username",username);
        map.put("roleId",roleId);
        return deanOfficeDao.selectDataCountByParams(map);
    }
}
