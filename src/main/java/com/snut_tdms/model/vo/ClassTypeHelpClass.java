package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.ClassType;
import com.snut_tdms.model.po.TypeContent;

import java.util.List;

/**
 * 类目属性辅助类
 * Created by huankai on 2018/4/22.
 */
public class ClassTypeHelpClass {

    private ClassType classType;
    private List<TypeContent> typeContentList;

    public ClassTypeHelpClass() {
    }

    public ClassTypeHelpClass(ClassType classType, List<TypeContent> typeContentList) {
        this.classType = classType;
        this.typeContentList = typeContentList;
    }

    public ClassType getClassType() {
        return classType;
    }

    public void setClassType(ClassType classType) {
        this.classType = classType;
    }

    public List<TypeContent> getTypeContentList() {
        return typeContentList;
    }

    public void setTypeContentList(List<TypeContent> typeContentList) {
        this.typeContentList = typeContentList;
    }

    @Override
    public String toString() {
        return "ClassTypeHelpClass{" +
                "classType=" + classType +
                ", typeContentList=" + typeContentList +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ClassTypeHelpClass that = (ClassTypeHelpClass) o;

        if (classType != null ? !classType.equals(that.classType) : that.classType != null) return false;
        return typeContentList != null ? typeContentList.equals(that.typeContentList) : that.typeContentList == null;
    }

    @Override
    public int hashCode() {
        int result = classType != null ? classType.hashCode() : 0;
        result = 31 * result + (typeContentList != null ? typeContentList.hashCode() : 0);
        return result;
    }
}
