package com.dave.pajk.jdbc.entity;

public class User {
    private Integer id;
    private String name;
    private String password;
    private char status;    //0：正常;  1:异常
    private char deleted;     //是否删除：0：未删除; 1：已删除

    public User(){

    }

    public User(String name,String password){
        this.name = name;
        this.password = password;
    }

    public User(Integer id, String name, String password, char status, char deleted) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.status = status;
        this.deleted = deleted;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public char getDeleted() {
        return deleted;
    }

    public void setDeleted(char deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "[id:"+this.id+", name:"+this.name+", status:"+this.status+", deleted:"+this.deleted+"]";
    }
}
