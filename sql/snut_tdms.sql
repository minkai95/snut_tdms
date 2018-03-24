/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : snut_tdms

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2018-03-24 13:18:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for data
-- ----------------------------
DROP TABLE IF EXISTS `data`;
CREATE TABLE `data` (
  `id` varchar(255) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `src` varchar(255) DEFAULT NULL,
  `data_class` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` int(255) unsigned zerofill DEFAULT NULL COMMENT '0表示正常，1表示被逻辑删除',
  PRIMARY KEY (`id`),
  KEY `data_class` (`data_class`),
  KEY `user` (`user`),
  CONSTRAINT `data_ibfk_1` FOREIGN KEY (`data_class`) REFERENCES `data_class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data
-- ----------------------------

-- ----------------------------
-- Table structure for data_class
-- ----------------------------
DROP TABLE IF EXISTS `data_class`;
CREATE TABLE `data_class` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `flag` int(255) DEFAULT NULL COMMENT '0表示为公共库，1表示私人库',
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `data_class_ibfk_2` (`user`),
  KEY `department` (`department`),
  CONSTRAINT `data_class_ibfk_1` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_class_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_class_ibfk_3` FOREIGN KEY (`department`) REFERENCES `department` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_class
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` varchar(255) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `operation_user` varchar(255) DEFAULT NULL,
  `operated_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `log_ibfk_1` (`operation_user`),
  KEY `operated_user` (`operated_user`),
  CONSTRAINT `log_ibfk_2` FOREIGN KEY (`operated_user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`operation_user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('001', '超级管理员');
INSERT INTO `role` VALUES ('002', '管理员');
INSERT INTO `role` VALUES ('003', '学办');
INSERT INTO `role` VALUES ('004', '教务处');
INSERT INTO `role` VALUES ('005', '教师');

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `system_notice_ibfk_1` (`user`),
  CONSTRAINT `system_notice_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user_role` (`user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_notice_ibfk_2` FOREIGN KEY (`role`) REFERENCES `user_role` (`role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT '123456',
  `id_card` varchar(255) DEFAULT NULL,
  `first_login` int(2) DEFAULT '0' COMMENT '0表示第一次登陆',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('123', '123456', null, '0');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user`),
  KEY `department` (`department`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_info_ibfk_2` FOREIGN KEY (`department`) REFERENCES `department` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  KEY `user` (`user`),
  KEY `role` (`role`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('123', '001');

-- ----------------------------
-- Procedure structure for aa
-- ----------------------------
DROP PROCEDURE IF EXISTS `aa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aa`()
BEGIN
		SET @tablename = (SELECT log.user_type FROM log WHERE log.`user` = '888');

		SET @sqlStr = CONCAT('select department from ',@tablename,' where id=','888');
	
		PREPARE stmt FROM	@sqlStr;
	
	




		execute stmt;
		
END
;;
DELIMITER ;
