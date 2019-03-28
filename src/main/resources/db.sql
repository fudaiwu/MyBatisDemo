-- 创建考勤数据库
CREATE DATABASE IF NOT EXISTS oa DEFAULT CHARACTER SET utf8;

USE oa;

-- 用户表
DROP TABLE IF EXISTS `user`;

CREATE TABLE USER(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     `name` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
     `password` VARCHAR(50) NOT NULL COMMENT '密码',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常;  1:异常',
	   deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     parent_id BIGINT(10),
     ext_props VARCHAR(50) COMMENT '扩展字段',
     CONSTRAINT user_parent_id_fk FOREIGN KEY(parent_id) REFERENCES USER(id)
)COMMENT='用户表';

INSERT INTO USER(creator,MODIFIER,NAME,PASSWORD) VALUES('amdin','admin','admin','admin');

-- 角色表
-- 工程师 业务组长 职能组长 经理
DROP TABLE IF EXISTS `role`;
CREATE TABLE role(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     is_deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常; 1:异常',
     role_type VARCHAR(32) NOT NULL UNIQUE COMMENT '角色类型',
     ext_props VARCHAR(50) COMMENT '扩展字段'
)COMMENT='角色表';
INSERT INTO role(role_type) VALUES('工程师');
INSERT INTO role(role_type) VALUES('业务组长');
INSERT INTO role(role_type) VALUES('职能组长');
INSERT INTO role(role_type) VALUES('经理');
INSERT INTO role(role_type) VALUES('管理员');


-- 用户-角色关系表
DROP TABLE IF EXISTS `user_role_rel`;
CREATE TABLE user_role_rel(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     is_deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常; 1:异常',
     user_id BIGINT(10) NOT NULL COMMENT '用户表主键id',
     role_id BIGINT(10) NOT NULL COMMENT '角色表主键id',
     ext_props VARCHAR(50) COMMENT '扩展字段',
     CONSTRAINT userRoleRel_user_id_fk FOREIGN KEY(user_id) REFERENCES USER(id),
     CONSTRAINT userRoleRel_role_id_fk FOREIGN KEY(role_id) REFERENCES role(id),
     CONSTRAINT userRoleRel_user_role_uk UNIQUE(user_id,role_id)   
)COMMENT='用户-角色关系表';

INSERT INTO user_role_rel(user_id,role_id) VALUES(1,5);

-- 菜单表
DROP TABLE IF EXISTS `menu`;
CREATE TABLE menu(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     is_deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常; 1:异常',
     menu_name VARCHAR(32) NOT NULL COMMENT '菜单名称',
     parent_id BIGINT(10)  COMMENT '父级id',
     `level` CHAR(1) NOT NULL COMMENT '菜单级别：1:一级菜单; 2:二级菜单',
     max_operat_authority VARCHAR(10) NOT NULL DEFAULT '0' COMMENT '菜单最大的操作权限: 1:新增 2:编辑 3:修改 4:保存 5:提交 6:打回 7:查看',
     ext_props VARCHAR(50) COMMENT '扩展字段',
     CONSTRAINT menu_parent_id_fk FOREIGN KEY(parent_id) REFERENCES menu(id)    
)COMMENT='菜单表';

INSERT INTO menu(menu_name,LEVEL) VALUES('日常工作','1');
INSERT INTO menu(menu_name,parent_id,LEVEL,max_operat_authority) VALUES('KPI管理',1,'2','1234567');
INSERT INTO menu(menu_name,parent_id,LEVEL) VALUES('考勤管理',1,'2');
INSERT INTO menu(menu_name,LEVEL) VALUES('系统设置','1');
INSERT INTO menu(menu_name,parent_id,LEVEL,max_operat_authority) VALUES('菜单管理',3,'2','12347');
INSERT INTO menu(menu_name,parent_id,LEVEL,max_operat_authority) VALUES('角色管理',3,'2','12347');
INSERT INTO menu(menu_name,parent_id,LEVEL,max_operat_authority) VALUES('用户管理',3,'2','12347');

-- 角色_菜单关系表
DROP TABLE IF EXISTS `role_menu_rel`;
CREATE TABLE role_menu_rel(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     is_deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常; 1:异常',
     role_id BIGINT(10) COMMENT '角色id',
     menu_id BIGINT(10) COMMENT '菜单id',
     operat_authority VARCHAR(10) NOT NULL DEFAULT 0 COMMENT '操作权限',
     ext_props VARCHAR(50) COMMENT '扩展字段',
     CONSTRAINT roleMenuAuthRel_role_id_fk FOREIGN KEY(role_id) REFERENCES role(id),
     CONSTRAINT roleMenuAuthRel_menu_id_fk FOREIGN KEY(menu_id) REFERENCES menu(id),
     CONSTRAINT roleMenuAuthRel_role_menu_uk UNIQUE(role_id,menu_id)
)COMMENT='角色_菜单关系表';

INSERT INTO role_menu_rel(role_id,menu_id) VALUES(5,1);
INSERT INTO role_menu_rel(role_id,menu_id,operat_authority) VALUES(5,2,'234567');
INSERT INTO role_menu_rel(role_id,menu_id) VALUES(5,3);
INSERT INTO role_menu_rel(role_id,menu_id) VALUES(5,4);
INSERT INTO role_menu_rel(role_id,menu_id,operat_authority) VALUES(5,5,'12347');
INSERT INTO role_menu_rel(role_id,menu_id,operat_authority) VALUES(5,6,'12347');
INSERT INTO role_menu_rel(role_id,menu_id,operat_authority) VALUES(5,7,'12347');

-- KPI管理表
DROP TABLE IF EXISTS `KPI_Manage`;
CREATE TABLE KPI_Manage(
     id BIGINT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
     creator VARCHAR(128) COMMENT '创建人',
     gmt_created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `modifier` VARCHAR(128) COMMENT '修改人',
     gmt_modified DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
     is_deleted CHAR(1) DEFAULT '0' COMMENT '是否删除：0：未删除; 1：已删除',
     `status` CHAR(1) DEFAULT '0' COMMENT '状态：0：正常; 1:异常',
     user_id BIGINT(10) NOT NULL COMMENT '用户表主键id', 
     `date` CHAR(7) NOT NULL COMMENT 'KPI考核年-月(yyyy-MM)',
     quality_selfRate VARCHAR(1024) COMMENT '质量自评',
     quality_selfRate_score DOUBLE COMMENT '质量自评分',
     quality_ownerRate_score DOUBLE COMMENT '质量业务owner评分',
     quality_leaderRate_score DOUBLE COMMENT '质量业务leader评分',
     efficiency_selfRate VARCHAR(1024) COMMENT '效率自评',
     efficiency_selfRate_score DOUBLE COMMENT '效率自评分',
     efficiency_ownerRate_score DOUBLE COMMENT '效率业务owner评分',
     efficiency_leaderRate_score DOUBLE COMMENT '效率业务leader评分',
     worth_selfRate VARCHAR(1024) COMMENT '价值观自评',
     worth_selfRate_score DOUBLE COMMENT '价值观自评分',    
     worth_ownerRate_score DOUBLE COMMENT '价值观owner评分',
     worth_leaderRate_score DOUBLE COMMENT '价值观leader评分',
     total_score DOUBLE COMMENT '最终得分',
     total_rate VARCHAR(256) COMMENT '综合评价',
     flow_status CHAR(1) NOT NULL COMMENT '工作流状态：0:新增; 1:已提交; 2:业务组长提交 3:完成 4:打回',
     ext_props VARCHAR(50) COMMENT '扩展字段',
     CONSTRAINT KPIManage_user_id_fk FOREIGN KEY(user_id) REFERENCES USER(id)
)COMMENT='KPI管理表';

INSERT INTO kpi_manage(user_id,DATE,quality_selfRate,quality_selfRate_score,quality_ownerRate_score,quality_leaderRate_score,efficiency_selfRate,efficiency_selfRate_score,efficiency_ownerRate_score,efficiency_leaderRate_score,
worth_selfRate,worth_selfRate_score,worth_ownerRate_score,worth_leaderRate_score,total_score,total_rate,flow_status)
VALUES(1,'2018-09','质量自我描述',100,100,100,'效率自我描述',100,100,100,'价值观自我描述',100,100,100,100,'整体描述','3');

INSERT INTO kpi_manage(user_id,DATE,quality_selfRate,quality_selfRate_score,quality_ownerRate_score,quality_leaderRate_score,efficiency_selfRate,efficiency_selfRate_score,efficiency_ownerRate_score,efficiency_leaderRate_score,
worth_selfRate,worth_selfRate_score,worth_ownerRate_score,worth_leaderRate_score,total_score,total_rate,flow_status)
VALUES(1,'2018-10','质量自我描述',100,100,100,'效率自我描述',100,100,100,'价值观自我描述',100,100,100,100,'整体描述','3');

INSERT INTO kpi_manage(user_id,DATE,quality_selfRate,quality_selfRate_score,quality_ownerRate_score,quality_leaderRate_score,efficiency_selfRate,efficiency_selfRate_score,efficiency_ownerRate_score,efficiency_leaderRate_score,
worth_selfRate,worth_selfRate_score,worth_ownerRate_score,worth_leaderRate_score,total_score,total_rate,flow_status)
VALUES(1,'2018-11','质量自我描述',100,100,100,'效率自我描述',100,100,100,'价值观自我描述',100,100,100,100,'整体描述','3');

INSERT INTO kpi_manage(user_id,DATE,quality_selfRate,quality_selfRate_score,quality_ownerRate_score,quality_leaderRate_score,efficiency_selfRate,efficiency_selfRate_score,efficiency_ownerRate_score,efficiency_leaderRate_score,
worth_selfRate,worth_selfRate_score,worth_ownerRate_score,worth_leaderRate_score,total_score,total_rate,flow_status)
VALUES(1,'2018-12','质量自我描述',100,100,100,'效率自我描述',100,100,100,'价值观自我描述',100,100,100,100,'整体描述','3');

INSERT INTO kpi_manage(user_id,DATE,quality_selfRate,quality_selfRate_score,quality_ownerRate_score,quality_leaderRate_score,efficiency_selfRate,efficiency_selfRate_score,efficiency_ownerRate_score,efficiency_leaderRate_score,
worth_selfRate,worth_selfRate_score,worth_ownerRate_score,worth_leaderRate_score,total_rate,flow_status)
VALUES(1,'2018-08','质量自我描述',100,100,100,'效率自我描述',100,100,100,'价值观自我描述',100,100,100,'整体描述','3');