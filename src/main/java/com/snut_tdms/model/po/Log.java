package com.snut_tdms.model.po;

import java.sql.Timestamp;

/**
 * Created by huankai on 2018/3/22.
 */
public class Log {
    private String id;
    private String content;
    private String action;
    private Timestamp time;
    private User operationUser;
    private User operatedUser;

    public Log() {
    }

    public Log(String id, String content, String action, Timestamp time, User operationUser, User operatedUser) {
        this.id = id;
        this.content = content;
        this.action = action;
        this.time = time;
        this.operationUser = operationUser;
        this.operatedUser = operatedUser;
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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public User getOperationUser() {
        return operationUser;
    }

    public void setOperationUser(User operationUser) {
        this.operationUser = operationUser;
    }

    public User getOperatedUser() {
        return operatedUser;
    }

    public void setOperatedUser(User operatedUser) {
        this.operatedUser = operatedUser;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", action='" + action + '\'' +
                ", time=" + time +
                ", operationUser=" + operationUser +
                ", operatedUser=" + operatedUser +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Log log = (Log) o;

        if (id != null ? !id.equals(log.id) : log.id != null) return false;
        if (content != null ? !content.equals(log.content) : log.content != null) return false;
        if (action != null ? !action.equals(log.action) : log.action != null) return false;
        if (time != null ? !time.equals(log.time) : log.time != null) return false;
        if (operationUser != null ? !operationUser.equals(log.operationUser) : log.operationUser != null) return false;
        return operatedUser != null ? operatedUser.equals(log.operatedUser) : log.operatedUser == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        result = 31 * result + (time != null ? time.hashCode() : 0);
        result = 31 * result + (operationUser != null ? operationUser.hashCode() : 0);
        result = 31 * result + (operatedUser != null ? operatedUser.hashCode() : 0);
        return result;
    }
}
