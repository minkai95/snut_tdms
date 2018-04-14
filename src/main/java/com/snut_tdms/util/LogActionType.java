package com.snut_tdms.util;

/**
 * Created by huankai on 2018/3/22.
 * 日志动作类型枚举类
 */
public enum LogActionType {
    LOGIN("登录"), INSERT("新增"), DELETE("删除"),LOGICAL_DELETE("逻辑删除"), UPDATE("更新"),
    RECOVER("恢复");

    private String nCode;

    LogActionType(String nCode) {
        this.nCode = nCode;
    }

    public String getnCode() {
        return nCode;
    }

    @Override
    public String toString() {
        return "StatusCode{" +
                "nCode='" + nCode + '\'' +
                '}';
    }
}
