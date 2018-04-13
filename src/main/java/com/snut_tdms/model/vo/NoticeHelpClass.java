package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.SystemNotice;
import com.snut_tdms.model.po.UserInfo;

/**
 * 公告辅助类
 * Created by huankai on 2018/4/12.
 */
public class NoticeHelpClass {

    private SystemNotice systemNotice;
    private UserInfo userInfo;

    public NoticeHelpClass() {
    }

    public NoticeHelpClass(SystemNotice systemNotice, UserInfo userInfo) {
        this.systemNotice = systemNotice;
        this.userInfo = userInfo;
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
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        NoticeHelpClass that = (NoticeHelpClass) o;

        if (systemNotice != null ? !systemNotice.equals(that.systemNotice) : that.systemNotice != null) return false;
        return userInfo != null ? userInfo.equals(that.userInfo) : that.userInfo == null;
    }

    @Override
    public int hashCode() {
        int result = systemNotice != null ? systemNotice.hashCode() : 0;
        result = 31 * result + (userInfo != null ? userInfo.hashCode() : 0);
        return result;
    }
}
