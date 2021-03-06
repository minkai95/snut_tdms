/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : snut_tdms

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2018-04-27 10:35:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for backup_data
-- ----------------------------
DROP TABLE IF EXISTS `backup_data`;
CREATE TABLE `backup_data` (
  `id` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `flag` int(1) unsigned zerofill DEFAULT '0' COMMENT '0表示正常,1表示已被覆盖',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  CONSTRAINT `backup_data_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for class_type
-- ----------------------------
DROP TABLE IF EXISTS `class_type`;
CREATE TABLE `class_type` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department` (`department`),
  KEY `class_type_ibfk_2` (`user`),
  CONSTRAINT `class_type_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_type_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `type_contents` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` int(255) DEFAULT '0' COMMENT '''0''表示正常,''1''表示被逻辑删除,''2''表示被彻底删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `data_ibfk_1` (`data_class`),
  KEY `data_ibfk_2` (`user`),
  CONSTRAINT `data_ibfk_1` FOREIGN KEY (`data_class`) REFERENCES `data_class` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `data_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  `class_types` varchar(255) DEFAULT NULL,
  `flag` int(255) DEFAULT '0' COMMENT '0表示公共类型未审核,1表示公共类型已审核,2表示私人类型,3表示已被删除',
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `data_class_ibfk_2` (`user`),
  KEY `department` (`department`),
  CONSTRAINT `data_class_ibfk_1` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_class_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_class_ibfk_3` FOREIGN KEY (`department`) REFERENCES `department` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for data_sequence
-- ----------------------------
DROP TABLE IF EXISTS `data_sequence`;
CREATE TABLE `data_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` varchar(255) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `operation_user` varchar(255) DEFAULT NULL COMMENT '操作者',
  `operated_id` varchar(255) DEFAULT NULL COMMENT '被操作对象ID',
  `operated_type` varchar(255) DEFAULT NULL COMMENT '被操作对象类型',
  `description` varchar(255) DEFAULT NULL COMMENT '选填项',
  PRIMARY KEY (`id`),
  KEY `log_ibfk_1` (`operation_user`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`operation_user`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  KEY `system_notice_ibfk_1` (`user`),
  KEY `system_notice_ibfk_2` (`role`),
  CONSTRAINT `system_notice_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `system_notice_ibfk_2` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for type_content
-- ----------------------------
DROP TABLE IF EXISTS `type_content`;
CREATE TABLE `type_content` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `class_type` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_type` (`class_type`),
  KEY `user` (`user`),
  CONSTRAINT `type_content_ibfk_1` FOREIGN KEY (`class_type`) REFERENCES `class_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `type_content_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
