package com.snut_tdms.dao;

import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.User;
import com.snut_tdms.model.po.UserInfo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 管理员DAO层
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface AdminDao extends UserDao {

    int insertUser(Map<String,Object> map);

    int deleteUserByUsernameList(List<String> usernameList);

    int deleteDataByIds(Map<String,Object> ids);

    List<Log> selectDepartmentLogs(String departmentCode);

    List<User> selectUserByRole(String roleId);
}
