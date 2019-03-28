package com.dave.pajk.jdbc.enume;

public enum KPIStatus {  //0:新增; 1:已提交; 2:业务组长提交 3:完成 4:打回
    insert(0,"新增"),submit(1,"提交"),owerSubmit(2,"业务组长提交"),end(3,"完成"),back(4,"打回");

    private int key;
    private String desc;

    public int getKey() {
        return key;
    }

    public void setKey(int key) {
        this.key = key;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    private KPIStatus(int key, String desc){
        this.key = key;
        this.desc = desc;
    }
}
