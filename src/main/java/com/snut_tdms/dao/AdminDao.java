package com.snut_tdms.dao;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 管理员DAO层
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface AdminDao extends UserDao {

    int deleteDataByIds(Map<String,Object> ids);

}
