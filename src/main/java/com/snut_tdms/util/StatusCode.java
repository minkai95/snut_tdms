package com.snut_tdms.util;

/**
 * Created by huankai on 2018/3/22.
 * 状态码枚举类
 */
public enum StatusCode {
    USERNAME_ERROR("用户名错误！"), PASSWORD_ERROR("密码错误！"), LOGIN_SUCCESS("登陆成功！"),
    DELETE_SUCCESS("删除成功！"), DELETE_ERROR("删除失败！"),
    INSERT_SUCCESS("添加成功！"),INSERT_ERROR("添加失败！"),INSERT_ERROR_CODE("添加失败，编码不能重复!"),
    INSERT_ERROR_CODE_CHOICE("添加失败，编码不能与单选题编码重复!"),INSERT_ERROR_CODE_MULTI_SELECT("添加失败，编码不能与多选题编码重复!"),INSERT_ERROR_CODE_JUDGMENT("添加失败，编码不能与判断题编码重复!"),
    UPDATE_SUCCESS("更新成功！"),UPDATE_ERROR("更新失败！"),UPDATE_NOT("您未做任何修改！"),
    NOT_USER("该用户不存在！"),NEW_PASSWORD_EQUALS_OLD("新密码与旧密码重复！"),
    SUBMIT_SUCCESS("提交成功！"),SUBMIT_ERROR("提交失败");

    private String nCode;

    StatusCode(String nCode) {
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
