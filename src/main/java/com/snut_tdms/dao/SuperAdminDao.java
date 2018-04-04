package com.snut_tdms.dao;

import com.snut_tdms.model.po.Department;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 超级管理员DAO
 * Created by huankai on 2018/3/27.
 */
@Repository
public interface SuperAdminDao extends UserDao{

    int insertDepartmentList(List<Department> departmentList);

    int deleteDepartmentListByCodes(List<String> departmentCodeList);

    int updateDepartmentByCode(Department department);

}
