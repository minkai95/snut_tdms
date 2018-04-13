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

    int insertData(Data data);

    int deleteDataByIds(Map<String,Object> ids);

    int updatePassword(User user);

    int updateUserInfo(UserInfo userInfo);

    int resetAdminPassword(String username);

    int logicalDeleteDataByIds(Map<String,Object> map);

    UserRole selectUserByUsername(String username);

    UserInfo selectUserInfoByUsername(String username);

    List<SystemNotice> selectSystemNotice(Map<String,Object> map);

    List<DataClass> selectDataClass(Map<String,Object> map);

    List<Data> selectDataByParams(Map<String,Object> map);

    Data selectDataById(String dataId);

    List<ClassType> selectClassTypesByDataClassId(String dataClassId);

    List<Department> selectAllDepartment();

    Department selectDepartmentByCode(String departmentCode);

    Role selectRoleById(String roleId);

    List<Role> selectAllRole();

    Integer selectDepartmentDataClassCount(Map<String,Object> map);

    Integer selectAllNoticeCount(String departmentCode);

    List<Log> selectPersonLogs(String username);
}
