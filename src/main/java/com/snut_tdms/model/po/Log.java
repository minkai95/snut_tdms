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
    private User user;

    public Log() {
    }

    public Log(String id, String content, String action, Timestamp time, User user) {
        this.id = id;
        this.content = content;
        this.action = action;
        this.time = time;
        this.user = user;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", action='" + action + '\'' +
                ", time=" + time +
                ", user=" + user +
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
        return user != null ? user.equals(log.user) : log.user == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        result = 31 * result + (time != null ? time.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        return result;
    }
}
