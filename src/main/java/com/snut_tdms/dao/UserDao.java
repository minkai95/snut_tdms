package com.snut_tdms.dao;

import com.snut_tdms.model.po.UserRole;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by huankai on 2018/3/22.
 */
@Repository
public interface UserDao {

    int insertUser(Map<String,Object> map);

    UserRole selectUserByUsername(String username);
}
