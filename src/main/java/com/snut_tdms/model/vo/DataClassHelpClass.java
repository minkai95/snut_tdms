package com.snut_tdms.model.vo;

import com.snut_tdms.model.po.ClassType;
import com.snut_tdms.model.po.Data;
import com.snut_tdms.model.po.DataClass;

import java.util.List;

/**
 * 文件类型辅助类
 * Created by huankai on 2018/4/20.
 */
public class DataClassHelpClass {

    private DataClass dataClass;
    private List<ClassType> classTypeList;

    public DataClassHelpClass() {
    }

    public DataClassHelpClass(DataClass dataClass, List<ClassType> classTypeList) {
        this.dataClass = dataClass;
        this.classTypeList = classTypeList;
    }

    public DataClass getDataClass() {
        return dataClass;
    }

    public void setDataClass(DataClass dataClass) {
        this.dataClass = dataClass;
    }

    public List<ClassType> getClassTypeList() {
        return classTypeList;
    }

    public void setClassTypeList(List<ClassType> classTypeList) {
        this.classTypeList = classTypeList;
    }

    @Override
    public String toString() {
        return "DataClassHelpClass{" +
                "dataClass=" + dataClass +
                ", classTypeList=" + classTypeList +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DataClassHelpClass that = (DataClassHelpClass) o;

        if (dataClass != null ? !dataClass.equals(that.dataClass) : that.dataClass != null) return false;
        return classTypeList != null ? classTypeList.equals(that.classTypeList) : that.classTypeList == null;
    }

    @Override
    public int hashCode() {
        int result = dataClass != null ? dataClass.hashCode() : 0;
        result = 31 * result + (classTypeList != null ? classTypeList.hashCode() : 0);
        return result;
    }
}
