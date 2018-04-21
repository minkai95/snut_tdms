package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.*;

import java.util.List;

/**
 * 文件类型辅助类
 * Created by huankai on 2018/4/20.
 */
public class DataClassHelpClass {

    private DataClass dataClass;
    private List<ClassType> classTypeList;
    private UserInfo userInfo;//上传者信息
    private UserRole userRole;//上传者角色

    public DataClassHelpClass() {
    }

    public DataClassHelpClass(DataClass dataClass, List<ClassType> classTypeList, UserInfo userInfo, UserRole userRole) {
        this.dataClass = dataClass;
        this.classTypeList = classTypeList;
        this.userInfo = userInfo;
        this.userRole = userRole;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    public DataClass getDataClass() {
        return dataClass;
    }

    public void setDataClass(DataClass dataClass) {
        this.dataClass = dataClass;
    }

    public List<ClassType> getClassTypeList() {
        return classTypeList;
    }

    public void setClassTypeList(List<ClassType> classTypeList) {
        this.classTypeList = classTypeList;
    }

    @Override
    public String toString() {
        return "DataClassHelpClass{" +
                "dataClass=" + dataClass +
                ", classTypeList=" + classTypeList +
                ", userInfo=" + userInfo +
                ", userRole=" + userRole +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DataClassHelpClass that = (DataClassHelpClass) o;

        if (dataClass != null ? !dataClass.equals(that.dataClass) : that.dataClass != null) return false;
        if (classTypeList != null ? !classTypeList.equals(that.classTypeList) : that.classTypeList != null)
            return false;
        if (userInfo != null ? !userInfo.equals(that.userInfo) : that.userInfo != null) return false;
        return userRole != null ? userRole.equals(that.userRole) : that.userRole == null;
    }

    @Override
    public int hashCode() {
        int result = dataClass != null ? dataClass.hashCode() : 0;
        result = 31 * result + (classTypeList != null ? classTypeList.hashCode() : 0);
        result = 31 * result + (userInfo != null ? userInfo.hashCode() : 0);
        result = 31 * result + (userRole != null ? userRole.hashCode() : 0);
        return result;
    }
}
