package com.snut_tdms.model.po;

import java.sql.Timestamp;

/**
 * Created by huankai on 2018/3/22.
 */
public class Data {
    private String id;
    private String content;
    private String fileName;
    private String src;
    private DataClass dataClass;
    private User user;
    private Timestamp submitTime;
    private Timestamp deleteTime;
    private Integer flag;

    public Data() {
    }

    public Data(String id, String content, String fileName, String src, DataClass dataClass, User user, Timestamp submitTime, Timestamp deleteTime, Integer flag) {
        this.id = id;
        this.content = content;
        this.fileName = fileName;
        this.src = src;
        this.dataClass = dataClass;
        this.user = user;
        this.submitTime = submitTime;
        this.deleteTime = deleteTime;
        this.flag = flag;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public DataClass getDataClass() {
        return dataClass;
    }

    public void setDataClass(DataClass dataClass) {
        this.dataClass = dataClass;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Timestamp submitTime) {
        this.submitTime = submitTime;
    }

    public Timestamp getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Timestamp deleteTime) {
        this.deleteTime = deleteTime;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    @Override
    public String toString() {
        return "Data{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", fileName='" + fileName + '\'' +
                ", src='" + src + '\'' +
                ", dataClass=" + dataClass +
                ", user=" + user +
                ", submitTime=" + submitTime +
                ", deleteTime=" + deleteTime +
                ", flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Data data = (Data) o;

        if (id != null ? !id.equals(data.id) : data.id != null) return false;
        if (content != null ? !content.equals(data.content) : data.content != null) return false;
        if (fileName != null ? !fileName.equals(data.fileName) : data.fileName != null) return false;
        if (src != null ? !src.equals(data.src) : data.src != null) return false;
        if (dataClass != null ? !dataClass.equals(data.dataClass) : data.dataClass != null) return false;
        if (user != null ? !user.equals(data.user) : data.user != null) return false;
        if (submitTime != null ? !submitTime.equals(data.submitTime) : data.submitTime != null) return false;
        if (deleteTime != null ? !deleteTime.equals(data.deleteTime) : data.deleteTime != null) return false;
        return flag != null ? flag.equals(data.flag) : data.flag == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (fileName != null ? fileName.hashCode() : 0);
        result = 31 * result + (src != null ? src.hashCode() : 0);
        result = 31 * result + (dataClass != null ? dataClass.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (submitTime != null ? submitTime.hashCode() : 0);
        result = 31 * result + (deleteTime != null ? deleteTime.hashCode() : 0);
        result = 31 * result + (flag != null ? flag.hashCode() : 0);
        return result;
    }
}