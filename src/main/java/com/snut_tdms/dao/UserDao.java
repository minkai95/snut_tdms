package com.snut_tdms.dao;

import com.snut_tdms.model.po.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 用户DAO层
 * Created by huankai on 2018/3/22.
 */
@Repository
public interface UserDao {

    int insertDataClass(DataClass dataClass);

    int insertLog(Log log);

    int updatePassword(User user);

    int updateUserInfo(UserInfo userInfo);

    UserRole selectUserByUsername(String username);

    UserInfo selectUserInfoByUsername(String username);

    List<SystemNotice> selectSystemNotice(Map<String,Object> map);

    List<DataClass> selectDataClass(Map<String,Object> map);
}
