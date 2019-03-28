package com.dave.pajk.jdbc.util;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

public class PropUtil {
    public static Map<String,String> getProperties(String url){
        Map<String,String> propMap = new HashMap<String,String>();
        Properties prop = new Properties();
        try{
            InputStream is = PropUtil.class.getClassLoader().getResourceAsStream(url);
            prop.load(is);    //加载属性列表
            Iterator<String> it = prop.stringPropertyNames().iterator();
            while(it.hasNext()){
                String key = it.next();
                propMap.put(key,prop.getProperty(key));
            }
            is.close();
        }catch(Exception e){
            System.err.println("Properties文件加载异常...");
            e.printStackTrace();
        }

        return propMap;
    }
}
