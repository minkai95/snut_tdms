package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.SystemNotice;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.model.po.UserRole;

/**
 * 公告辅助类
 * Created by huankai on 2018/4/12.
 */
public class NoticeHelpClass {

    private SystemNotice systemNotice;
    private UserInfo userInfo;
    private UserRole userRole;

    public NoticeHelpClass() {
    }

    public NoticeHelpClass(SystemNotice systemNotice, UserInfo userInfo, UserRole userRole) {
        this.systemNotice = systemNotice;
        this.userInfo = userInfo;
        this.userRole = userRole;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    public SystemNotice getSystemNotice() {
        return systemNotice;
    }

    public void setSystemNotice(SystemNotice systemNotice) {
        this.systemNotice = systemNotice;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    @Override
    public String toString() {
        return "NoticeHelpClass{" +
                "systemNotice=" + systemNotice +
                ", userInfo=" + userInfo +
                ", userRole=" + userRole +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        NoticeHelpClass that = (NoticeHelpClass) o;

        if (systemNotice != null ? !systemNotice.equals(that.systemNotice) : that.systemNotice != null) return false;
        if (userInfo != null ? !userInfo.equals(that.userInfo) : that.userInfo != null) return false;
        return userRole != null ? userRole.equals(that.userRole) : that.userRole == null;
    }

    @Override
    public int hashCode() {
        int result = systemNotice != null ? systemNotice.hashCode() : 0;
        result = 31 * result + (userInfo != null ? userInfo.hashCode() : 0);
        result = 31 * result + (userRole != null ? userRole.hashCode() : 0);
        return result;
    }
}
