package com.snut_tdms.service;

import com.snut_tdms.dao.TeacherDao;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.Data;
import com.snut_tdms.model.po.DataClass;
import com.snut_tdms.model.po.User;
import com.snut_tdms.util.FileUploadUtil;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * 教师service层
 * Created by huankai on 2018/3/25.
 */
@Service("teacherService")
public class TeacherService extends UserService{

    private TeacherDao teacherDao;
    private UserDao userDao;

    @Autowired
    public TeacherService(UserDao userDao, TeacherDao teacherDao) {
        super(userDao);
        this.userDao = userDao;
        this.teacherDao = teacherDao;
    }

    /**
     * 查询教师上传的公共类目资料数目
     * @param username 用户名
     * @return 数目
     */
    public Integer selectTeacherDataCount(String username,Integer flag){
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("flag",flag);
        return teacherDao.selectTeacherDataCount(map);
    }
}
