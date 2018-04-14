package com.snut_tdms.dao;

import com.snut_tdms.model.po.Department;
import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 超级管理员DAO
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface SuperAdminDao extends UserDao{

    int insertDepartmentList(List<Department> departmentList);

    int insertAdmin(Map<String,Object> map);

    int deleteDepartmentListByCodes(List<String> departmentCodeList);

    int deleteAdminByUsernameList(List<String> usernameList);

    int updateDepartmentByCode(Department department);

    int updateAdminUserInfo(UserInfo userInfo);

    int recoverData(String dataId);

    List<Log> selectAllLogs();

    List<UserRole> selectAllAdmin();

}
