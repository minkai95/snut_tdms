package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;

/**
 * 用户辅助类
 * Created by huankai on 2018/4/19.
 */
public class UserHelpClass {

    private UserInfo userInfo;
    private UserRole userRole;

    public UserHelpClass() {
    }

    public UserHelpClass(UserInfo userInfo, UserRole userRole) {
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

    @Override
    public String toString() {
        return "UserHelpClass{" +
                "userInfo=" + userInfo +
                ", userRole=" + userRole +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserHelpClass that = (UserHelpClass) o;

        if (userInfo != null ? !userInfo.equals(that.userInfo) : that.userInfo != null) return false;
        return userRole != null ? userRole.equals(that.userRole) : that.userRole == null;
    }

    @Override
    public int hashCode() {
        int result = userInfo != null ? userInfo.hashCode() : 0;
        result = 31 * result + (userRole != null ? userRole.hashCode() : 0);
        return result;
    }
}
