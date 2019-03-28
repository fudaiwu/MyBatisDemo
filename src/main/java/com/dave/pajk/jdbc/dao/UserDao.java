package com.dave.pajk.jdbc.dao;

import com.dave.pajk.jdbc.entity.User;
import com.dave.pajk.jdbc.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    //校验用户名和密码是否正确
    public boolean login(String name,String password) throws Exception {
        Connection conn = JDBCUtil.init();

        String sql = "select * from user where name = ? and password = ? and status = 0 and deleted = 0";

        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1,name);
        pst.setString(2,password);

        ResultSet rs = pst.executeQuery();
        boolean b = rs.next();

        JDBCUtil.close(rs,pst,conn);

        return b;
    }

    //返回用户信息
    public User getUser(int id) throws Exception {
        User user = new User();

        Connection conn = JDBCUtil.init();

        String sql = "select * from user where id = ?  and status = 0 and deleted = 0";

        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1,id);

        ResultSet rs = pst.executeQuery();

        if(rs.next()){
            user.setId(rs.getInt("id"));
            user.setName(rs.getString("name"));
            user.setStatus(rs.getString("status").charAt(0));
            user.setDeleted(rs.getString("status").charAt(0));
        }

        JDBCUtil.close(rs,pst,conn);

        return user;
    }

    //返回所有的用户信息
    public List<User> getUserList() throws Exception {
        List<User> userList = new ArrayList<User>();

        Connection conn = JDBCUtil.init();

        String sql = "select * from user where status = 0 and deleted = 0";
        Statement st = conn.createStatement();

        ResultSet rs = st.executeQuery(sql);

        while(rs.next()){
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setName(rs.getString("name"));
            user.setStatus(rs.getString("status").charAt(0));
            user.setDeleted(rs.getString("status").charAt(0));
            userList.add(user);
        }

        JDBCUtil.close(rs,st,conn);

        return userList;
    }

    //新增用户信息
    public void addUser(User user) throws Exception {
        Connection conn = JDBCUtil.init();

        String sql = "insert into user(creator,modifier,name,password,status,deleted) VALUES('amdin','admin',?,?,0,0)";

        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1,user.getName());
        pst.setString(2,user.getPassword());
        pst.execute();
        JDBCUtil.close(null,pst,conn);
    }

    //删除用户信息
    public void deleteUser(int id) throws Exception{
        Connection conn = JDBCUtil.init();

        String sql = "update user set deleted = 1 where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1,id);

        pst.execute();
    }
}
