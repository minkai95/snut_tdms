/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : snut_tdms

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2018-04-12 20:09:39
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
INSERT INTO `data` VALUES ('25b3f3ffc63543f38413285233194cfa', '大萨达奥所多撒大所', '25b3f3ffc63543f38413285233194cfa_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\12\\2', '11', null, 'teacher', '2018-04-12 10:15:26', null, '0');
INSERT INTO `data` VALUES ('50f08fc293414b20ba76c062a5d58b8e', '描述', '50f08fc293414b20ba76c062a5d58b8e_待学习功能.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\8\\6', '1', null, 'teacher', '2018-04-11 14:51:05', null, '0');
INSERT INTO `data` VALUES ('bd00c40850914005ac17269f9b1cbfec', '萨达', 'bd00c40850914005ac17269f9b1cbfec_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\12\\5', '1', null, 'teacher', '2018-04-12 10:31:13', '2018-04-12 13:10:23', '0');
INSERT INTO `data` VALUES ('d10158654f804e17b699ea632c4fafeb', '12', 'd10158654f804e17b699ea632c4fafeb_QQ.txt', 'D:\\ideaproject\\snut_tdms\\target\\snut_tdms\\WEB-INF\\upload\\001\\14\\7', '5', null, 'teacher', '2018-04-12 11:59:46', '2018-04-12 12:37:09', '0');

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
  `description` varchar(255) DEFAULT NULL COMMENT '选填项',
  PRIMARY KEY (`id`),
  KEY `log_ibfk_2` (`operated_user`),
  KEY `log_ibfk_1` (`operation_user`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`operation_user`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `log_ibfk_2` FOREIGN KEY (`operated_user`) REFERENCES `user` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('00fd347e668f43abbbbbcb4ec7ca2641', '超级管理员修改了一条院系编码:001 的院系信息', 'delete', '2018-04-04 10:52:06', '123', '123', null);
INSERT INTO `log` VALUES ('0111dd3494fe4a1faa216a72f12ff017', '用户登录了', 'login', '2018-04-11 15:47:02', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('078b0e8cc76848ffafac42a4a12e363c', '用户登录了', 'login', '2018-04-10 11:31:48', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('087ffcfb457947aeac801a55a0adc14f', '更新了用户的个人信息!', 'update', '2018-04-10 14:40:57', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('098cc25e5225430497806318b6fa97fe', '管理员新增了一条类目！', 'insert', '2018-03-25 12:26:09', '123', '123', null);
INSERT INTO `log` VALUES ('0aebd817ed2b4e5fbd76cdc3b258266d', '用户登录了', 'login', '2018-04-10 15:08:25', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('0d3ea49986a742899ae7ff981487ec23', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('0efe4169360f4a67b41009b1d3486c8b', '2条数据插入成功,1条数据插入失败!请检查院系是否重复！', 'insert', '2018-04-04 10:08:08', '123', '123', null);
INSERT INTO `log` VALUES ('1081936ca6ce4c2383c61841075d0fbb', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-12 12:36:37', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('10e6c2c6fd7d44e2b669f5d993f718f7', '用户登录了', 'login', '2018-04-10 11:45:08', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('11a7c5cbc5d94a138345e91f944e0694', '用户登录了', 'login', '2018-04-10 11:35:27', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('125c8c2275b647bd874d8286f645feec', '用户登录了', 'login', '2018-04-10 11:32:54', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('13337f497eec4bdd9cee254daa892a20', '用户登录了', 'login', '2018-04-11 14:05:22', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('16c57c8a3ac34739bfcc467b4f295fa5', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('1cd78bccc80147b99a2004625b3d3041', '用户登录了', 'login', '2018-04-11 12:36:11', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('238db4e2482342f49e5d30a107427dca', '用户登录了', 'login', '2018-04-10 14:40:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('281c5ac798d2403d875cdbfe59ad4052', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 15:09:39', 'teacher', 'teacher', '212');
INSERT INTO `log` VALUES ('28819e64346d4cf7bd81e1ab063a3cbd', '用户登录了', 'login', '2018-04-10 11:33:03', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('2eb7ba1a422e4385aa1336e423ffda70', '用户登录了', 'login', '2018-04-12 10:15:00', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('3023f1ab0991490db8cb65a24632eb29', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('35b0e1d09f65483185b34030fabdbf15', '用户登录了', 'login', '2018-04-12 12:35:13', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('3ade0ad7be3e495daf4c1f0f005b39e1', '超级管理员修改了一名用户名:999 的管理员信息', 'update', '2018-04-04 13:07:24', '123', '999', null);
INSERT INTO `log` VALUES ('3dc327f78c0049af9545e8c436e22c43', '用户登录了', 'login', '2018-04-10 11:43:48', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('42ed5e499f3f4d6f8ff8c174e2bad823', '成功删除了3份资料！', 'delete', '2018-03-27 14:56:46', '123', '123', '文件不合格而被删除');
INSERT INTO `log` VALUES ('436b7076c3dd45a5a9ad4d81fab9f460', '0条数据插入成功,3条数据插入失败!请检查院系编码是否重复！', 'insert', '2018-04-04 10:01:25', '123', '123', null);
INSERT INTO `log` VALUES ('45f5ad7266e3439ea3f9712287b8f07a', '用户上传了一个文件！', 'insert', '2018-04-12 11:59:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('46572fd91ea24068af219f16002531ce', '用户登录了', 'login', '2018-04-10 11:33:03', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('486bf71861104d74a4a447d6b59dc028', '用户登录了', 'login', '2018-04-10 13:56:13', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('49c7349752824d27b6a297a00a48c58a', '用户登录了', 'login', '2018-04-12 15:40:41', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('4cf7d66d0cf248088c42916b3a4d8f75', '用户上传了一个文件！', 'insert', '2018-04-11 12:06:23', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('4d4170f1e7ba4646b3f9e148291ce588', '用户登录了', 'login', '2018-04-12 13:17:07', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('4ec14006971049c3878087ce0675ac83', '用户登录了', 'login', '2018-04-10 11:33:13', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('4f60a9fd363b4cff82dc36f08a5091ce', '用户上传了一个文件！', 'insert', '2018-04-11 12:36:26', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('50a7fe58ab5d4b76abe6669ef61f9223', '用户登录了', 'login', '2018-04-12 10:26:48', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('5195b78e6f1e4efd8c7f03a643344eff', '数据全部成功插入', 'insert', '2018-04-04 09:51:58', '123', '123', null);
INSERT INTO `log` VALUES ('52420f6626fe450db9899f142e7536d3', '用户登录了', 'login', '2018-04-10 13:55:01', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('546b5c099eb4442ea55cffd7c82a6511', '用户登录了', 'login', '2018-04-10 11:32:54', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('5703564a582b41c887ea066fb103f624', '超级管理员修改了一名用户名:999 的管理员信息', 'update', '2018-04-04 13:00:11', '123', '999', null);
INSERT INTO `log` VALUES ('584555081e7541a0a0cb5001e2279803', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-12 12:37:09', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('5975fea362d44424abbf2ffc9e08f41c', '用户登录了', 'login', '2018-04-10 11:53:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('5e59f23dbe294f298902c15b3d9f17e2', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('5e6547e1874240afaafb9392dd4e49b2', '1条数据插入成功,2条数据插入失败!请检查院系编码是否重复！', 'insert', '2018-04-04 10:02:16', '123', '123', null);
INSERT INTO `log` VALUES ('5fe54eeb4f354037b6d87978fad79baa', '用户登录了', 'login', '2018-04-10 14:11:17', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('60e78c9460aa4859a0d3228400dab77f', '用户逻辑删除了4份资料！', 'delete', '2018-03-27 15:40:47', '123', '123', '上传错了！');
INSERT INTO `log` VALUES ('61b73aa7cb034afab35ffcca1fa93de3', '用户登录了', 'login', '2018-04-10 11:16:25', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('6412d11e777748b7b98381e61b9602b4', '用户登录了', 'login', '2018-04-10 13:52:48', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('657d4f5634bd497c95ef5716bd0ab832', '超级管理员重置了一名用户名:999 的管理员密码!', 'update', '2018-04-04 13:16:02', '123', '999', null);
INSERT INTO `log` VALUES ('6ae61dbc645b4e6ab5bd4f226811b2da', '用户登录了', 'login', '2018-04-10 11:10:11', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('6bb5dfce2ce34e3398f27b01983456e3', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 14:18:58', 'teacher', 'teacher', 'ewq');
INSERT INTO `log` VALUES ('70abeb86114748a184e79ed0350673fe', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 15:07:19', 'teacher', 'teacher', '123');
INSERT INTO `log` VALUES ('72e1237ab46c40319c7bb1056e986f94', '用户登录了', 'login', '2018-04-12 13:26:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('74ec76b1382a4a2dad66db49271c1a74', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-12 10:54:46', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('7545dc34baec4c9a85ad02f599c792d4', '用户登录了', 'login', '2018-04-10 11:36:19', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('761d546624c84a32963ff5bbc014f67a', '用户登录了', 'login', '2018-04-12 10:44:16', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('77e73397590a43b3bc4ae6d99f72c8ae', '用户登录了', 'login', '2018-04-11 15:35:32', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('799121550421480c9da9da3a9a7660f0', '用户登录了', 'login', '2018-04-10 11:39:44', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('7a6aecb8bf2a4cbf8816c36913065e2e', '超级管理员修改了一名用户名:999 的管理员信息', 'update', '2018-04-04 13:07:16', '123', '999', null);
INSERT INTO `log` VALUES ('7e7299734bc244a7b72989aef756c73e', '用户登录了', 'login', '2018-04-10 11:12:50', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('864abef2747544139832b940a95a8655', '更新了用户的个人信息!', 'update', '2018-04-10 14:42:03', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('8bbfdf33adf342f3bc86f551b6746e48', '用户登录了', 'login', '2018-04-12 12:36:24', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('8caa87f0a6bb48ed8c8c7090ab52d842', '用户登录了', 'login', '2018-04-12 16:10:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('8cd90091310b4b25a0b0e9942101850a', '用户更新了密码', 'update', '2018-03-24 15:50:40', '123', '123', 'null');
INSERT INTO `log` VALUES ('8ecfe143264d4e2c8bc2b7a1077cc3d4', '超级管理员新增了一名院系管理员！', 'insert', '2018-04-04 12:56:47', '123', '999', null);
INSERT INTO `log` VALUES ('8f9fc84b90c14533b5da6c034fb937c9', '用户登录了', 'login', '2018-04-10 13:54:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('93520d40ec5f43fe92a08c98be50922c', '用户登录了', 'login', '2018-04-10 11:11:09', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('947fed388ae0433e88295dfed7dd668b', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 14:21:26', 'teacher', 'teacher', '312');
INSERT INTO `log` VALUES ('94856dcae81143ad83456440ddeeacc4', '用户上传了一个文件！', 'insert', '2018-04-11 12:12:03', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('9a8770efd20c47b48c86c3117b835e02', '用户上传了一个文件！', 'insert', '2018-04-11 12:30:02', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('9becd25889014a2aabed5113cd0ce0d3', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 14:29:53', 'teacher', 'teacher', '2131');
INSERT INTO `log` VALUES ('9ce7e7afa72d47b2a93c5fe106a10032', '用户登录了', 'login', '2018-04-11 14:18:21', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('a4855f516fdf4903ae5e7564624453ec', '用户登录了', 'login', '2018-04-10 11:38:25', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('a7b04671ef224efc994079757cdec308', '用户登录了', 'login', '2018-04-10 11:32:54', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('a8380dadcdab406485c400f91ab45086', '3条数据全部成功插入', 'insert', '2018-04-04 09:52:40', '123', '123', null);
INSERT INTO `log` VALUES ('a866c2904ea7440dbacb76d0ed862809', '用户登录了', 'login', '2018-04-10 11:42:56', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('a8cb0505b2444cfcac1ac4197f7ea2ad', '刘二彻底删除了1份私人资料！', 'delete', '2018-04-12 13:26:53', '123', 'teacher', '');
INSERT INTO `log` VALUES ('ac0dbb3328db45b59a6e679c006e3d25', '0条数据插入成功,3条数据插入失败!请检查院系编码是否重复！', 'insert', '2018-04-04 10:06:28', '123', '123', null);
INSERT INTO `log` VALUES ('ad8bc9dcc3bb4dbbb07f65522c649162', '用户登录了', 'login', '2018-04-10 11:07:50', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('b1eb8d0e6bc6431fbebc3041dd33d9d0', '用户申请新增类目！', 'insert', '2018-03-24 19:10:24', '123', '123', null);
INSERT INTO `log` VALUES ('b30bba8a8d654aab8fe3c31b2b89fcab', '用户登录了', 'login', '2018-04-10 13:53:41', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('b3d0e375447443eca429c10ba9aed498', '用户登录了', 'login', '2018-04-11 13:52:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('b3fc4d205f2741a19f490ba4b7f4939e', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-12 11:59:21', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('b6f3375c7d7a49db916734651c2a381a', '用户上传了一个文件！', 'insert', '2018-04-11 14:51:06', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('bafe51d3dbdf4b0c93c470ef29f6661f', '用户上传了一个文件！', 'insert', '2018-04-12 10:31:13', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('bfb956b6e43847b280ff03d31d0148d8', '更新了用户的个人信息!', 'update', '2018-04-10 14:41:23', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('c1974294693141888d3ef2f34335b90f', '用户登录了', 'login', '2018-03-24 16:05:40', '123', '123', null);
INSERT INTO `log` VALUES ('c3af2f4df104462ebd279fe57ac678e3', '用户登录了', 'login', '2018-04-10 11:32:47', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('cd02b90a354b4727b4c4ea16971e0f50', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('ce1f89aba1bb4126925232c153cf38db', '用户登录了', 'login', '2018-04-10 11:15:20', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('ce5bc3eb2ef640d5bf0f490f50e48d3e', '用户登录了', 'login', '2018-04-10 11:40:58', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('ce85060120fd473695b1ae76a21d9724', '用户上传了一个文件！', 'insert', '2018-04-12 11:58:54', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('cf00cc1677ff4426bc8299d24e2c3aa4', '用户登录了', 'login', '2018-04-10 11:32:55', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d0838b8b5def41f69191ba4fe84c0419', '用户登录了', 'login', '2018-04-11 15:08:50', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d0dd15fac2244a809a3c6a1b88196977', '用户登录了', 'login', '2018-04-12 10:35:40', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d171d18e10a84d599188672671444568', '用户登录了', 'login', '2018-04-10 11:40:25', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d4809f557c81496eb38627c8990a4e48', '用户登录了', 'login', '2018-04-10 12:14:06', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d7490d57c82d426fa08c93fc73918bab', '用户登录了', 'login', '2018-04-10 11:56:42', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('d8008fed0df24993b8de68e824c22854', '用户登录了', 'login', '2018-04-12 14:37:56', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('de9e31d4a4584ccb8145330c45840412', '用户登录了', 'login', '2018-04-12 11:58:09', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('defce977efd54e848d28dd026f47a311', '用户登录了', 'login', '2018-04-11 13:40:07', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e1bd0e07b65449e89cdd886bd59ec5f5', '管理员新增了一条类目！', 'insert', '2018-03-24 19:15:04', '123', '123', null);
INSERT INTO `log` VALUES ('e2d4d6c547c4428c8cfb244738e922ce', '用户登录了', 'login', '2018-04-12 13:08:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e3aadd48f5234ae89fa722a4abe2ac04', '用户登录了', 'login', '2018-04-10 11:45:57', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e4e4258f59d8442abe82f71924f1caee', '用户登录了', 'login', '2018-04-10 11:32:55', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e5b5e3192d124cae91a53401b1a81811', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e707e04be66e474db7ea12263ff127b1', '用户上传了一个文件！', 'insert', '2018-04-12 10:15:26', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e70ca5d32a68498587c97b60defa48b3', '2条数据删除成功!1条数据删除失败!', 'delete', '2018-04-04 10:31:52', '123', '123', null);
INSERT INTO `log` VALUES ('e8737e8dee56487d995990e3de1628b9', '用户登录了', 'login', '2018-04-10 11:49:23', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('e9f07380805f467db963a0119b0927b6', '用户逻辑删除了4份资料！', 'logicalDelete', '2018-03-27 15:42:33', '123', '123', '上传错了！');
INSERT INTO `log` VALUES ('eacc056143e646dc90dd723f4f297866', '用户登录了', 'login', '2018-04-11 12:11:49', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('eb311ef6b3f64bba8234cd209b2dae7e', '用户登录了', 'login', '2018-04-10 11:19:12', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('eb6c110449234436af3430d76160e041', '用户登录了', 'login', '2018-04-11 12:29:47', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('ed60bc5ba3a84d3db47e569d8439ca82', '用户登录了', 'login', '2018-04-10 11:24:43', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('ee67184c05d849729b5144fc27aaa7c1', '用户登录了', 'login', '2018-04-10 13:50:46', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('eeea61767b10459f8bc4d04d06e1fdbb', '用户登录了', 'login', '2018-04-10 12:06:51', 'teacher', 'teacher', null);
INSERT INTO `log` VALUES ('f16587d3bfce4a9fbe07e2e776e26c30', '1条管理员信息删除成功!', 'delete', '2018-04-04 12:39:39', '123', '123', '描述！！！');
INSERT INTO `log` VALUES ('f38df8d4d204481a8c1132c906ac3988', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-11 15:02:06', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('f65e492e7dff405aa52cf98f39cc8d65', '逻辑删除了一份资料！', 'logicalDelete', '2018-04-12 13:10:23', 'teacher', 'teacher', '');
INSERT INTO `log` VALUES ('f74f746374f246f19fe943af04b56a2d', '用户登录了', 'login', '2018-04-10 11:33:04', 'teacher', 'teacher', null);

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
INSERT INTO `role` VALUES ('001', 'superadmin');
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
INSERT INTO `user_info` VALUES ('222', '大赛', '男', '5555555', '55555', '002');
INSERT INTO `user_info` VALUES ('999', '王五', '男', '15599999999', 'dsa@qq.con', '002');
INSERT INTO `user_info` VALUES ('teacher', '刘二', '男', '15588889658', 'dsa@qq.comq', '001');

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
