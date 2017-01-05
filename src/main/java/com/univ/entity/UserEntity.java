package com.univ.entity;

/**
 * Univ
 * 2017/1/4 19:44
 */

/**
 * 实验室用户
 *
 * todo:实验室用户应该和实验室关联
 * todo:考虑只能使用邮箱登录，用户名只用于显示
 */
public class UserEntity {

    private Long id;
    private String username;
    private String password;

    private String telephone;
    private String email;

    /*
     * 1：学生；
     * 2：老师；
     * 3：管理员；
     * todo:为何将角色设置成1，2，3，考虑枚举？
     */
    private int role;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
