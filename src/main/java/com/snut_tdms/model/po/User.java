package com.snut_tdms.model.po;

/**
 * Created by huankai on 2018/3/22.
 */
public class User {
    private String username;
    private String password;
    private String idCard;
    private Integer firstLogin;

    public User() {
    }

    public User(String username, String password, String idCard, Integer firstLogin) {
        this.username = username;
        this.password = password;
        this.idCard = idCard;
        this.firstLogin = firstLogin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public Integer getFirstLogin() {
        return firstLogin;
    }

    public void setFirstLogin(Integer firstLogin) {
        this.firstLogin = firstLogin;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", idCard='" + idCard + '\'' +
                ", firstLogin=" + firstLogin +
                '}';
    }

    @Override
    public boolean equals(Object o) {

        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (username != null ? !username.equals(user.username) : user.username != null) return false;
        if (password != null ? !password.equals(user.password) : user.password != null) return false;
        if (idCard != null ? !idCard.equals(user.idCard) : user.idCard != null) return false;
        return firstLogin != null ? firstLogin.equals(user.firstLogin) : user.firstLogin == null;
    }

    @Override
    public int hashCode() {
        int result = username != null ? username.hashCode() : 0;
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (idCard != null ? idCard.hashCode() : 0);
        result = 31 * result + (firstLogin != null ? firstLogin.hashCode() : 0);
        return result;
    }
}
