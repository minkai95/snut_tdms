package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.User;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;

/**
 * 资料追踪辅助类
 * Created by huankai on 2018/4/12.
 */
public class LogHelpClass {

    private Log log;
    private UserInfo operationUserInfo;
    private UserRole operationUserRole;
    private UserInfo operatedUserInfo;

    public LogHelpClass() {
    }

    public LogHelpClass(Log log, UserInfo operationUserInfo, UserRole operationUserRole, UserInfo operatedUserInfo) {
        this.log = log;
        this.operationUserInfo = operationUserInfo;
        this.operationUserRole = operationUserRole;
        this.operatedUserInfo = operatedUserInfo;
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

    public UserInfo getOperatedUserInfo() {
        return operatedUserInfo;
    }

    public void setOperatedUserInfo(UserInfo operatedUserInfo) {
        this.operatedUserInfo = operatedUserInfo;
    }

    @Override
    public String toString() {
        return "LogHelpClass{" +
                "log=" + log +
                ", operationUserInfo=" + operationUserInfo +
                ", operationUserRole=" + operationUserRole +
                ", operatedUserInfo=" + operatedUserInfo +
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
        return operatedUserInfo != null ? operatedUserInfo.equals(that.operatedUserInfo) : that.operatedUserInfo == null;
    }

    @Override
    public int hashCode() {
        int result = log != null ? log.hashCode() : 0;
        result = 31 * result + (operationUserInfo != null ? operationUserInfo.hashCode() : 0);
        result = 31 * result + (operationUserRole != null ? operationUserRole.hashCode() : 0);
        result = 31 * result + (operatedUserInfo != null ? operatedUserInfo.hashCode() : 0);
        return result;
    }
}
