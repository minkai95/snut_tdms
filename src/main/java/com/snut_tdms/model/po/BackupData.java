package com.snut_tdms.model.po;

import java.sql.Timestamp;

/**
 * 数据备份实体类
 * Created by huankai on 2018/4/26.
 */
public class BackupData {

    private String id;
    private String type;
    private User user;
    private Timestamp time;
    private Integer flag;

    public BackupData() {
    }

    public BackupData(String id, String type, User user, Timestamp time, Integer flag) {
        this.id = id;
        this.type = type;
        this.user = user;
        this.time = time;
        this.flag = flag;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    @Override
    public String toString() {
        return "BackupData{" +
                "id='" + id + '\'' +
                ", type='" + type + '\'' +
                ", user=" + user +
                ", time=" + time +
                ", flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BackupData that = (BackupData) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (user != null ? !user.equals(that.user) : that.user != null) return false;
        if (time != null ? !time.equals(that.time) : that.time != null) return false;
        return flag != null ? flag.equals(that.flag) : that.flag == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (time != null ? time.hashCode() : 0);
        result = 31 * result + (flag != null ? flag.hashCode() : 0);
        return result;
    }
}
