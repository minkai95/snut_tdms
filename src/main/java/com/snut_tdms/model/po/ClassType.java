package com.snut_tdms.model.po;

/**
 * 数据类型子类
 * Created by huankai on 2018/4/2.
 */
public class ClassType {

    private String id;
    private String name;
    private Department department;
    private User user;

    public ClassType() {
    }

    public ClassType(String id, String name, Department department, User user) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.user = user;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "ClassType{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", department=" + department +
                ", user=" + user +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ClassType classType = (ClassType) o;

        if (id != null ? !id.equals(classType.id) : classType.id != null) return false;
        if (name != null ? !name.equals(classType.name) : classType.name != null) return false;
        if (department != null ? !department.equals(classType.department) : classType.department != null) return false;
        return user != null ? user.equals(classType.user) : classType.user == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (department != null ? department.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        return result;
    }
}
