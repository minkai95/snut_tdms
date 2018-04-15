package com.snut_tdms.dao;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 学办DAO层
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface StudentOfficeDao extends UserDao {

    Integer selectStudentOfficeDataCount(Map<String,Object> map);

    Integer selectAdminNoticeCount(String departmentCode);

}
