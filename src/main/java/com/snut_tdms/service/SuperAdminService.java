package com.snut_tdms.service;

import com.snut_tdms.dao.SuperAdminDao;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.Department;
import com.snut_tdms.model.po.User;
import com.snut_tdms.util.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 超级管理员service层
 * Created by huankai on 2018/3/27.
 */
@Service("superAdminService")
public class SuperAdminService extends UserService {

    private SuperAdminDao superAdminDao;
    private UserDao userDao;

    @Autowired
    public SuperAdminService(UserDao userDao, SuperAdminDao superAdminDao) {
        super(userDao);
        this.superAdminDao = superAdminDao;
        this.userDao = userDao;
    }

    /**
     * 插入院系
     * @param departmentList 院系列表
     * @param user 超级管理员
     * @return Map
     */
    public Map<String,Object> insertDepartmentList(List<Department> departmentList, User user){
        Map<String,Object> map = new HashMap<>();
        List<Department> relDepartmentList = new ArrayList<>();
        List<String> departmentCodeList = new ArrayList<>();
        List<String> departmentNameList = new ArrayList<>();
        for (Department department:userDao.selectAllDepartment()) {
            departmentCodeList.add(department.getCode());
            departmentNameList.add(department.getName());
        }
        for (Department department:departmentList) {
            if(!departmentCodeList.contains(department.getCode()) && !departmentNameList.contains(department.getName())){
                relDepartmentList.add(department);
            }
        }
        int count = 0;
        if(relDepartmentList.size()>0) {
            count = superAdminDao.insertDepartmentList(relDepartmentList);
        }
        if(count==departmentList.size()){
            map.put("StatusCode",count+"条数据全部成功插入");
        }else if(count<departmentList.size()){
            map.put("StatusCode",count+"条数据插入成功,"+(departmentList.size()-count)+"条数据插入失败!请检查院系是否重复！");
        }
        if(count>0) {
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", map.get("StatusCode"));
            logParams.put("action", "insert");
            logParams.put("operationUser", user);
            logParams.put("operatedUser", user);
            insertLog(logParams);
        }
        return map;
    }

    /**
     * 删除院系信息
     * @param departmentCodeList 院系编码
     * @param user 超级管理员
     * @return map
     */
    public Map<String,Object> deleteDepartmentListByCodes(List<String> departmentCodeList,User user){
        int count = superAdminDao.deleteDepartmentListByCodes(departmentCodeList);
        Map<String,Object> map = new HashMap<>();
        if(count>0 && count<departmentCodeList.size()){
            map.put("StatusCode",count+"条数据删除成功!"+(departmentCodeList.size()-count)+"条数据删除失败!");
        }else if(count==departmentCodeList.size()){
            map.put("StatusCode",count+"条数据删除成功!");
        }else {
            map.put("StatusCode",departmentCodeList.size()+"条数据删除失败!");
        }
        if(count>0){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", map.get("StatusCode"));
            logParams.put("action", "delete");
            logParams.put("operationUser", user);
            logParams.put("operatedUser", user);
            insertLog(logParams);
        }
        return map;
    }

    /**
     * 修改院系
     * @param department 院系
     * @param user 超级管理员
     * @return 状态码
     */
    public StatusCode updateDepartmentByCode(Department department,User user){
        if(selectDepartmentByCode(department.getCode()).getName().equals(department.getName())){
            return StatusCode.UPDATE_NOT;
        }
        if(superAdminDao.updateDepartmentByCode(department)>0){
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "超级管理员修改了一条院系编码:"+department.getCode()+" 的院系信息");
            logParams.put("action", "delete");
            logParams.put("operationUser", user);
            logParams.put("operatedUser", user);
            insertLog(logParams);
            return StatusCode.UPDATE_SUCCESS;
        }else{
            return StatusCode.UPDATE_ERROR;
        }
    }
}
