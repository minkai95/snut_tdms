package com.snut_tdms.dao;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by huankai on 2018/3/22.
 */
@Repository
public interface UserDao {

    int insertUser(Map<String,Object> map);
    
}
