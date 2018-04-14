/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : snut_tdms

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2018-04-14 23:20:30
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of class_type
-- ----------------------------
INSERT INTO `class_type` VALUES ('11', '学期', '001', '123');
INSERT INTO `class_type` VALUES ('22', '专业', '001', '123');
INSERT INTO `class_type` VALUES ('33', '班级', '001', '123');
INSERT INTO `class_type` VALUES ('44', '部门', '001', '123');

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
  `flag` int(255) DEFAULT '0' COMMENT '''0''表示正常,''1''表示被逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `data_class` (`data_class`),
  KEY `user` (`user`),
  CONSTRAINT `data_ibfk_1` FOREIGN KEY (`data_class`) REFERENCES `data_class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of data
-- ----------------------------
INSERT INTO `data` VALUES ('2e1af6fd6a5d41f38c29f38786028b80', '211', '2e1af6fd6a5d41f38c29f38786028b80_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\12\\6', '11', null, 'teacher', '2018-04-14 20:45:25', null, '0');
INSERT INTO `data` VALUES ('50f08fc293414b20ba76c062a5d58b8e', '描述', '50f08fc293414b20ba76c062a5d58b8e_待学习功能.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\8\\6', '1', null, 'teacher', '2018-04-11 14:51:05', '2018-04-14 16:25:04', '1');
INSERT INTO `data` VALUES ('8d5f45a25c2c42cfadf4f4c4f8fd2b12', '嗯嗯', '8d5f45a25c2c42cfadf4f4c4f8fd2b12_待学习功能.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\0\\6', '6', null, 'teacher', '2018-04-14 16:26:10', '2018-04-14 20:44:31', '1');
INSERT INTO `data` VALUES ('a0a2bf3f89b94361b3f749943b7c6eaa', 'QQ资料', 'a0a2bf3f89b94361b3f749943b7c6eaa_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\12\\6', '1', null, 'teacher', '2018-04-14 16:25:29', '2018-04-14 20:44:35', '0');
INSERT INTO `data` VALUES ('ac1e28da1716404b9efab9177b1ee897', '描述', 'ac1e28da1716404b9efab9177b1ee897_待学习功能.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\2\\2', '1', null, 'teacher', '2018-04-14 20:44:54', null, '0');
INSERT INTO `data` VALUES ('bd00c40850914005ac17269f9b1cbfec', '萨达', 'bd00c40850914005ac17269f9b1cbfec_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\12\\5', '1', null, 'teacher', '2018-04-12 10:31:13', '2018-04-14 16:24:58', '1');
INSERT INTO `data` VALUES ('c4df05c3ece0406fa51ae3ff87c691c3', '2112', 'c4df05c3ece0406fa51ae3ff87c691c3_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\8\\9', '6', null, 'teacher', '2018-04-14 20:45:09', null, '0');
INSERT INTO `data` VALUES ('d10158654f804e17b699ea632c4fafeb', '12', 'd10158654f804e17b699ea632c4fafeb_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\14\\7', '5', null, 'teacher', '2018-04-12 11:59:46', '2018-04-14 16:24:51', '1');

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
  `flag` int(255) DEFAULT '0' COMMENT '0表示公共类型未审核,1表示公共类型已审核,2表示私人类型',
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
INSERT INTO `data_class` VALUES ('1', '实验报告', '001', '123', '001', '11/22/33', '1');
INSERT INTO `data_class` VALUES ('10', '检讨', '001', '123', '001', null, '0');
INSERT INTO `data_class` VALUES ('11', '私人类型', '001', '123', '001', null, '2');
INSERT INTO `data_class` VALUES ('2', '贫困申请材料', '001', '123', '001', '11/22/33', '0');
INSERT INTO `data_class` VALUES ('3', '毕业设计报告', '001', '123', '001', '11/22', '0');
INSERT INTO `data_class` VALUES ('4', '试卷', '001', '123', '001', '11/22/33', '1');
INSERT INTO `data_class` VALUES ('5', '论文', '001', '123', '001', '11/22/33', '1');
INSERT INTO `data_class` VALUES ('6', '党员资料', '001', '123', '001', '11/22/33', '1');
INSERT INTO `data_class` VALUES ('7', '学生会材料汇总', '001', '123', '001', '44', '1');
INSERT INTO `data_class` VALUES ('8', '建档立卡复印件及材料证明', '001', '123', '001', '11/22/33', '1');
INSERT INTO `data_class` VALUES ('9', '三方协议复印件', '001', '123', '001', '11/22/33', '1');

-- ----------------------------
-- Table structure for data_sequence
-- ----------------------------
DROP TABLE IF EXISTS `data_sequence`;
CREATE TABLE `data_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of data_sequence
-- ----------------------------
INSERT INTO `data_sequence` VALUES ('1');
INSERT INTO `data_sequence` VALUES ('2');
INSERT INTO `data_sequence` VALUES ('3');
INSERT INTO `data_sequence` VALUES ('4');
INSERT INTO `data_sequence` VALUES ('5');

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
INSERT INTO `department` VALUES ('001', '管理学院');
INSERT INTO `department` VALUES ('002', '体育学院');
INSERT INTO `department` VALUES ('003', '文学院');
INSERT INTO `department` VALUES ('004', '旅游学院');

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
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('0eca6d9aa1f343c8abfbae269cad688a', '用户上传了一个文件！', '新增', '2018-04-14 20:44:54', 'teacher', 'ac1e28da1716404b9efab9177b1ee897', '文件', null);
INSERT INTO `log` VALUES ('323f8179344049399d5d3a2aa34243ca', '用户登录了', '登录', '2018-04-14 23:04:47', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('3dcb9b582aac45aa910542918c04575a', '超级管理员恢复了一份用户文件!', '恢复', '2018-04-14 21:22:59', 'superadmin', 'a0a2bf3f89b94361b3f749943b7c6eaa', '文件', null);
INSERT INTO `log` VALUES ('6867b12fe92d4f71b89857d7ad534e85', '用户上传了一个文件！', '新增', '2018-04-14 20:45:09', 'teacher', 'c4df05c3ece0406fa51ae3ff87c691c3', '文件', null);
INSERT INTO `log` VALUES ('6971eb50b644488d891728d2a359c504', '用户登录了', '登录', '2018-04-14 21:42:34', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('83eb4e2fe26c42af9d2f17c3901f9d91', '刘二彻底删除了1份私人资料！', '删除', '2018-04-14 20:45:16', 'teacher', '25b3f3ffc63543f38413285233194cfa', '文件', '');
INSERT INTO `log` VALUES ('88dc4cd439fb40e6861e2ec9ae90eecf', '用户登录了', '登录', '2018-04-14 23:03:54', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('8b79622de94f4893a60c6c6b689238fc', '用户登录了', '登录', '2018-04-14 20:43:59', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('90a0ecc513ab423abc66b446e0d61305', '用户登录了', '登录', '2018-04-14 21:22:17', 'superadmin', 'superadmin', '用户', null);
INSERT INTO `log` VALUES ('91ee6994876e4cf59c6728217f57b6ff', '刘二彻底删除了1份私人资料！', '删除', '2018-04-14 22:01:54', 'teacher', 'b458c0efa99d4d058ae729e701962dd7', '文件', '');
INSERT INTO `log` VALUES ('9e5f32062a4d4cde86b9a555bdb2d030', '用户登录了', '登录', '2018-04-14 21:41:09', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('afb4a3a56e434ca2b7c64b9e39c6cca4', '用户登录了', '登录', '2018-04-14 20:46:09', 'superadmin', 'superadmin', '用户', null);
INSERT INTO `log` VALUES ('b7305f625a6248a79c166aeb5f709d8a', '用户登录了', '登录', '2018-04-14 21:41:49', 'superadmin', 'superadmin', '用户', null);
INSERT INTO `log` VALUES ('c80172dc470d4cab9e5a40478644b441', '用户上传了一个文件！', '新增', '2018-04-14 20:45:25', 'teacher', '2e1af6fd6a5d41f38c29f38786028b80', '文件', null);
INSERT INTO `log` VALUES ('e4ca16bfa54d43478ae1c29c7f0612cb', '更新了用户的个人信息!', '更新', '2018-04-14 20:45:47', 'teacher', 'teacher', '用户', null);
INSERT INTO `log` VALUES ('f25ee63c077d48969d1bee0271a0b304', '逻辑删除了一份资料！', '逻辑删除', '2018-04-14 20:44:31', 'teacher', '8d5f45a25c2c42cfadf4f4c4f8fd2b12', '文件', '');
INSERT INTO `log` VALUES ('f528b90fd5a94218977de6652826d56e', '逻辑删除了一份资料！', '逻辑删除', '2018-04-14 20:44:35', 'teacher', 'a0a2bf3f89b94361b3f749943b7c6eaa', '文件', '111');
INSERT INTO `log` VALUES ('f9c2cb24862440a79162c42e0dce8b13', '更新了用户的个人信息!', '更新', '2018-04-14 20:45:43', 'teacher', 'teacher', '用户', null);

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
INSERT INTO `role` VALUES ('001', 'superAdmin');
INSERT INTO `role` VALUES ('002', 'admin');
INSERT INTO `role` VALUES ('003', 'teacherOffice');
INSERT INTO `role` VALUES ('004', 'deanOffice');
INSERT INTO `role` VALUES ('005', 'teacher');

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
-- Records of system_notice
-- ----------------------------
INSERT INTO `system_notice` VALUES ('12', '系统公告1', '阿达', '2018-03-24 17:02:54', '123', '001');
INSERT INTO `system_notice` VALUES ('55', '系统2', '阿斯顿撒', '2018-03-24 17:13:47', '123', '001');
INSERT INTO `system_notice` VALUES ('99', '公告', '萨达大撒', '2018-03-24 17:30:45', '123', '003');

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
-- Records of type_content
-- ----------------------------
INSERT INTO `type_content` VALUES ('1', '大一第一学期', '11', '123');
INSERT INTO `type_content` VALUES ('10', '文化部', '44', '123');
INSERT INTO `type_content` VALUES ('11', '体育部', '44', '123');
INSERT INTO `type_content` VALUES ('12', '自律部', '44', '123');
INSERT INTO `type_content` VALUES ('2', '大一第二学期', '11', '123');
INSERT INTO `type_content` VALUES ('3', '大二第一学期', '11', '123');
INSERT INTO `type_content` VALUES ('4', '大二第二学期', '11', '123');
INSERT INTO `type_content` VALUES ('5', '电子商务', '22', '123');
INSERT INTO `type_content` VALUES ('6', '物流管理', '22', '123');
INSERT INTO `type_content` VALUES ('7', '1401', '33', '123');
INSERT INTO `type_content` VALUES ('8', '1402', '33', '123');
INSERT INTO `type_content` VALUES ('9', '学习部', '44', '123');

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
INSERT INTO `user` VALUES ('123', '1111', '11', '0');
INSERT INTO `user` VALUES ('222', '123456', null, '0');
INSERT INTO `user` VALUES ('999', '123456', null, '0');
INSERT INTO `user` VALUES ('superadmin', '123456', null, '1');
INSERT INTO `user` VALUES ('teacher', '123456', '612501199605052222', '1');

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
INSERT INTO `user_info` VALUES ('123', '张三', '男', '155999999', 'sadsa@qq.com', '001');
INSERT INTO `user_info` VALUES ('222', '二娃', '女', '155555555', '23233@qq.com', '001');
INSERT INTO `user_info` VALUES ('999', '王五', '男', '11111111111', 'dsa@qq.con', '002');
INSERT INTO `user_info` VALUES ('superadmin', '超管', '男', null, null, '002');
INSERT INTO `user_info` VALUES ('teacher', '刘二', '男', '15588889658', 'dsa@qq.com', '001');

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
INSERT INTO `user_role` VALUES ('222', '002');
INSERT INTO `user_role` VALUES ('999', '002');
INSERT INTO `user_role` VALUES ('teacher', '005');
INSERT INTO `user_role` VALUES ('superadmin', '001');

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
