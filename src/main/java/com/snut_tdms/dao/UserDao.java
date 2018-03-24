package com.snut_tdms.dao;

import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.User;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by huankai on 2018/3/22.
 */
@Repository
public interface UserDao {

    int insertLog(Log log);

    int updatePassword(User user);

    int updateUserInfo(UserInfo userInfo);

    UserRole selectUserByUsername(String username);

    UserInfo selectUserInfoByUsername(String username);
}
