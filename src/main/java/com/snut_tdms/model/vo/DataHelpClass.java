package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.Data;
import com.snut_tdms.model.po.UserInfo;

/**
 * 资料辅助工具类
 * Created by huankai on 2018/4/10.
 */
public class DataHelpClass {

    private Data data;
    private UserInfo userInfo;

    public DataHelpClass() {
    }

    public DataHelpClass(Data data, UserInfo userInfo) {
        this.data = data;
        this.userInfo = userInfo;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    @Override
    public String toString() {
        return "DataHelpClass{" +
                "data=" + data +
                ", userInfo=" + userInfo +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DataHelpClass that = (DataHelpClass) o;

        if (data != null ? !data.equals(that.data) : that.data != null) return false;
        return userInfo != null ? userInfo.equals(that.userInfo) : that.userInfo == null;
    }

    @Override
    public int hashCode() {
        int result = data != null ? data.hashCode() : 0;
        result = 31 * result + (userInfo != null ? userInfo.hashCode() : 0);
        return result;
    }
}
