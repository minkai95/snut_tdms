package com.snut_tdms.util;

/**
 * Created by huankai on 2018/3/22.
 * 被操作类型枚举类
 */
public enum OperatedType {
    FILE("文件"), FILE_TYPE("文件类型"), USER("用户"), DEPARTMENT("院系");

    private String nCode;

    OperatedType(String nCode) {
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
