package com.dave.pajk.jdbc.service;

import com.dave.pajk.jdbc.dao.UserDao;
import com.dave.pajk.jdbc.entity.User;

import java.util.List;

public class UserService {
    //生成一批初始化数据，亦用于测试
    public void initUser() throws Exception {
        UserDao userDao = new UserDao();
        userDao.addUser(new User("chukecheng","Ckc123"));
        userDao.addUser(new User("hujinlin","Hjl123"));
        userDao.addUser(new User("wujiangjiang","Wjj123"));
        userDao.addUser(new User("yangming","Ym123"));

        User user = userDao.getUser(1);
        System.out.println("用户信息：\n"+user);

        List userList = userDao.getUserList();
        System.out.println("用户列表信息：\n"+userList);

        userDao.deleteUser(5);
        user = userDao.getUser(1);
        System.out.println("用户信息：\n"+user);

        userList = userDao.getUserList();
        System.out.println("用户列表信息：\n"+userList);
    }
}
