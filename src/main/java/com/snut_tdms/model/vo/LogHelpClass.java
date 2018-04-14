package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.*;
import com.snut_tdms.util.OperatedType;

/**
 * 资料追踪辅助类
 * Created by huankai on 2018/4/12.
 */
public class LogHelpClass {

    private Log log;
    private UserInfo operationUserInfo;
    private UserRole operationUserRole;

    private String operatedType;
    private UserInfo operatedUserInfo;
    private UserRole operatedUserRole;
    private Department operatedDepartment;
    private Data operatedData;
    private UserInfo operatedDataUserInfo;
    private UserRole operatedDataUserRole;
    private DataClass operatedDataClass;

    public LogHelpClass() {
    }

    public LogHelpClass(Log log, UserInfo operationUserInfo, UserRole operationUserRole, String operatedType, UserInfo operatedUserInfo, UserRole operatedUserRole, Department operatedDepartment, Data operatedData, UserInfo operatedDataUserInfo, UserRole operatedDataUserRole, DataClass operatedDataClass) {
        this.log = log;
        this.operationUserInfo = operationUserInfo;
        this.operationUserRole = operationUserRole;
        this.operatedType = operatedType;
        this.operatedUserInfo = operatedUserInfo;
        this.operatedUserRole = operatedUserRole;
        this.operatedDepartment = operatedDepartment;
        this.operatedData = operatedData;
        this.operatedDataUserInfo = operatedDataUserInfo;
        this.operatedDataUserRole = operatedDataUserRole;
        this.operatedDataClass = operatedDataClass;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }

    public UserInfo getOperationUserInfo() {
        return operationUserInfo;
    }

    public void setOperationUserInfo(UserInfo operationUserInfo) {
        this.operationUserInfo = operationUserInfo;
    }

    public UserRole getOperationUserRole() {
        return operationUserRole;
    }

    public void setOperationUserRole(UserRole operationUserRole) {
        this.operationUserRole = operationUserRole;
    }

    public String getOperatedType() {
        return operatedType;
    }

    public void setOperatedType(String operatedType) {
        this.operatedType = operatedType;
    }

    public UserInfo getOperatedUserInfo() {
        return operatedUserInfo;
    }

    public void setOperatedUserInfo(UserInfo operatedUserInfo) {
        this.operatedUserInfo = operatedUserInfo;
    }

    public UserRole getOperatedUserRole() {
        return operatedUserRole;
    }

    public void setOperatedUserRole(UserRole operatedUserRole) {
        this.operatedUserRole = operatedUserRole;
    }

    public Department getOperatedDepartment() {
        return operatedDepartment;
    }

    public void setOperatedDepartment(Department operatedDepartment) {
        this.operatedDepartment = operatedDepartment;
    }

    public Data getOperatedData() {
        return operatedData;
    }

    public void setOperatedData(Data operatedData) {
        this.operatedData = operatedData;
    }

    public DataClass getOperatedDataClass() {
        return operatedDataClass;
    }

    public void setOperatedDataClass(DataClass operatedDataClass) {
        this.operatedDataClass = operatedDataClass;
    }

    public UserInfo getOperatedDataUserInfo() {
        return operatedDataUserInfo;
    }

    public void setOperatedDataUserInfo(UserInfo operatedDataUserInfo) {
        this.operatedDataUserInfo = operatedDataUserInfo;
    }

    public UserRole getOperatedDataUserRole() {
        return operatedDataUserRole;
    }

    public void setOperatedDataUserRole(UserRole operatedDataUserRole) {
        this.operatedDataUserRole = operatedDataUserRole;
    }

    @Override
    public String toString() {
        return "LogHelpClass{" +
                "log=" + log +
                ", operationUserInfo=" + operationUserInfo +
                ", operationUserRole=" + operationUserRole +
                ", operatedType='" + operatedType + '\'' +
                ", operatedUserInfo=" + operatedUserInfo +
                ", operatedUserRole=" + operatedUserRole +
                ", operatedDepartment=" + operatedDepartment +
                ", operatedData=" + operatedData +
                ", operatedDataUserInfo=" + operatedDataUserInfo +
                ", operatedDataUserRole=" + operatedDataUserRole +
                ", operatedDataClass=" + operatedDataClass +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LogHelpClass that = (LogHelpClass) o;

        if (log != null ? !log.equals(that.log) : that.log != null) return false;
        if (operationUserInfo != null ? !operationUserInfo.equals(that.operationUserInfo) : that.operationUserInfo != null)
            return false;
        if (operationUserRole != null ? !operationUserRole.equals(that.operationUserRole) : that.operationUserRole != null)
            return false;
        if (operatedType != null ? !operatedType.equals(that.operatedType) : that.operatedType != null) return false;
        if (operatedUserInfo != null ? !operatedUserInfo.equals(that.operatedUserInfo) : that.operatedUserInfo != null)
            return false;
        if (operatedUserRole != null ? !operatedUserRole.equals(that.operatedUserRole) : that.operatedUserRole != null)
            return false;
        if (operatedDepartment != null ? !operatedDepartment.equals(that.operatedDepartment) : that.operatedDepartment != null)
            return false;
        if (operatedData != null ? !operatedData.equals(that.operatedData) : that.operatedData != null) return false;
        if (operatedDataUserInfo != null ? !operatedDataUserInfo.equals(that.operatedDataUserInfo) : that.operatedDataUserInfo != null)
            return false;
        if (operatedDataUserRole != null ? !operatedDataUserRole.equals(that.operatedDataUserRole) : that.operatedDataUserRole != null)
            return false;
        return operatedDataClass != null ? operatedDataClass.equals(that.operatedDataClass) : that.operatedDataClass == null;
    }

    @Override
    public int hashCode() {
        int result = log != null ? log.hashCode() : 0;
        result = 31 * result + (operationUserInfo != null ? operationUserInfo.hashCode() : 0);
        result = 31 * result + (operationUserRole != null ? operationUserRole.hashCode() : 0);
        result = 31 * result + (operatedType != null ? operatedType.hashCode() : 0);
        result = 31 * result + (operatedUserInfo != null ? operatedUserInfo.hashCode() : 0);
        result = 31 * result + (operatedUserRole != null ? operatedUserRole.hashCode() : 0);
        result = 31 * result + (operatedDepartment != null ? operatedDepartment.hashCode() : 0);
        result = 31 * result + (operatedData != null ? operatedData.hashCode() : 0);
        result = 31 * result + (operatedDataUserInfo != null ? operatedDataUserInfo.hashCode() : 0);
        result = 31 * result + (operatedDataUserRole != null ? operatedDataUserRole.hashCode() : 0);
        result = 31 * result + (operatedDataClass != null ? operatedDataClass.hashCode() : 0);
        return result;
    }
}
