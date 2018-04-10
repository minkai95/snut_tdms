package com.snut_tdms.dao;

import com.snut_tdms.model.po.Data;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 教师DAO层
 * Created by huankai on 2018/3/25.
 */
@Repository
public interface TeacherDao extends UserDao{

    Integer selectTeacherDataCount(Map<String,Object> map);


}
