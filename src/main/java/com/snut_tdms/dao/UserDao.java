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

    int deleteDataById(Map<String,Object> map);

    int updatePassword(User user);

    int updateUserInfo(UserInfo userInfo);

    int updateUserRole(UserRole userRole);

    int updateUser(User user);

    int resetAdminPassword(String username);

    int logicalDeleteDataByIds(Map<String,Object> map);

    UserRole selectUserByUsername(String username);

    UserInfo selectUserInfoByUsername(String username);

    List<SystemNotice> selectSystemNoticeByPage(Map<String,Object> map);

    List<DataClass> selectDataClass(Map<String,Object> map);

    List<DataClass> selectDataClassByPage(Map<String,Object> map);

    DataClass selectDataClassById(String dataClassId);

    List<Data> selectDataByParamsByPage(Map<String,Object> map);

    List<Data> selectRoleAllPublicDataByPage(Map<String,Object> map);

    Data selectDataById(String dataId);

    List<ClassType> selectClassTypesByDataClassId(String dataClassId);

    List<Department> selectAllDepartmentByPage(Map<String,Object> map);

    Department selectDepartmentByCode(String departmentCode);

    Role selectRoleById(String roleId);

    List<Role> selectAllRole();

    Integer selectDepartmentDataClassCount(Map<String,Object> map);

    Integer selectAllNoticeCount(String departmentCode);

    List<Log> selectPersonLogsByPage(Map<String,Object> map);

    List<ClassType> selectClassType(Map<String,Object> map);

    List<TypeContent> selectTypeContentByPage(Map<String,Object> map);

    List<TypeContent> selectTypeContentByParam(Map<String,Object> map);
}
