package com.snut_tdms.model.po;

/**
 * 数据类型子类的数据
 * Created by huankai on 2018/4/2.
 */
public class TypeContent {

    private String id;
    private String name;
    private ClassType classType;
    private User user;

    public TypeContent() {
    }

    public TypeContent(String id, String name, ClassType classType, User user) {
        this.id = id;
        this.name = name;
        this.classType = classType;
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

    public ClassType getClassType() {
        return classType;
    }

    public void setClassType(ClassType classType) {
        this.classType = classType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "TypeContent{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", classType=" + classType +
                ", user=" + user +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TypeContent that = (TypeContent) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (classType != null ? !classType.equals(that.classType) : that.classType != null) return false;
        return user != null ? user.equals(that.user) : that.user == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (classType != null ? classType.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        return result;
    }
}
