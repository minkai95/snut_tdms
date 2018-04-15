package com.snut_tdms.service;

import com.snut_tdms.dao.StudentOfficeDao;
import com.snut_tdms.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

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

    /**
     * 查询学办文件数据条数
     * @param map 参数
     * @return Integer
     */
    public Integer selectStudentOfficeDataCount(Map<String,Object> map){
        return studentOfficeDao.selectStudentOfficeDataCount(map);
    }

    /**
     * 查询本院管理员所发送的公告条数
     * @param departmentCode 院系编码
     * @return Integer
     */
    public Integer selectAdminNoticeCount(String departmentCode){
        return studentOfficeDao.selectAdminNoticeCount(departmentCode);
    }
}
