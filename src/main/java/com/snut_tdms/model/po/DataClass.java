package com.snut_tdms.model.po;

/**
 * 资料类别
 * Created by huankai on 2018/3/22.
 */
public class DataClass {
    private String id;
    private String name;
    private Role role;
    private User user;
    private Department department;
    private String classTypes;
    private Integer flag;

    public DataClass() {
    }

    public DataClass(String id, String name, Role role, User user, Department department, String classTypes, Integer flag) {
        this.id = id;
        this.name = name;
        this.role = role;
        this.user = user;
        this.department = department;
        this.classTypes = classTypes;
        this.flag = flag;
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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public String getClassTypes() {
        return classTypes;
    }

    public void setClassTypes(String classTypes) {
        this.classTypes = classTypes;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    @Override
    public String toString() {
        return "DataClass{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", role=" + role +
                ", user=" + user +
                ", department=" + department +
                ", classTypes='" + classTypes + '\'' +
                ", flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DataClass dataClass = (DataClass) o;

        if (id != null ? !id.equals(dataClass.id) : dataClass.id != null) return false;
        if (name != null ? !name.equals(dataClass.name) : dataClass.name != null) return false;
        if (role != null ? !role.equals(dataClass.role) : dataClass.role != null) return false;
        if (user != null ? !user.equals(dataClass.user) : dataClass.user != null) return false;
        if (department != null ? !department.equals(dataClass.department) : dataClass.department != null) return false;
        if (classTypes != null ? !classTypes.equals(dataClass.classTypes) : dataClass.classTypes != null) return false;
        return flag != null ? flag.equals(dataClass.flag) : dataClass.flag == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (department != null ? department.hashCode() : 0);
        result = 31 * result + (classTypes != null ? classTypes.hashCode() : 0);
        result = 31 * result + (flag != null ? flag.hashCode() : 0);
        return result;
    }
}
