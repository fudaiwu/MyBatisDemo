package com.dave.pajk.jdbc.util;

import java.sql.*;
import java.util.Map;

public class JDBCUtil {
    //连接数据库
    public static Connection init(){
        Connection conn = null;
        Map<String,String> propMap = PropUtil.getProperties("db.properties");
        if(!propMap.isEmpty()){
            String driver= propMap.get("driver");
            String url = propMap.get("url");
            String user = propMap.get("user");
            String password = propMap.get("password");
            try {
                Class.forName(driver);   //加载驱动
                conn = DriverManager.getConnection(url,user,password);
            } catch (Exception e) {
                System.err.println("数据库连接异常...");
                e.printStackTrace();
            }
        }
        return conn;
    }

    //关闭数据库连接
    public static void close(ResultSet rs, Statement st, Connection conn){
        if(rs != null){
            try {
                rs.close();
            } catch (Exception e) {
                System.err.println("结果集关闭异常...");
                e.printStackTrace();
            }
        }

        if(st != null){
            try {
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if(conn != null){
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) throws Exception {
        init();
    }
}
