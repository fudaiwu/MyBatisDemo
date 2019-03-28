package com.dave.pajk.jdbc.main;


import com.dave.pajk.jdbc.service.UserService;

public class App {
    public static void main(String[] args) throws Exception {
        UserService userService = new UserService();
        userService.initUser();
    }
}
