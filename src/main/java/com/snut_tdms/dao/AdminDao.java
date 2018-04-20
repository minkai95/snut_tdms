package com.snut_tdms.dao;

import com.snut_tdms.model.po.*;
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

    int insertSystemNotice(SystemNotice systemNotice);

    int insertClassType(ClassType classType);

    int deleteUserByUsernameList(List<String> usernameList);

    int deleteClassTypeById(String classTypeId);

    int deleteDataClassById(String dataClassId);

    int recoverData(String dataId);

    List<Log> selectDepartmentLogsByPage(Map<String,Object> map);

    List<UserRole> selectUserByParamsByPage(Map<String,Object> map);

}
