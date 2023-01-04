/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : multi_field

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 23/06/2021 17:58:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for 5kcrm_admin_scene_default
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_scene_default`;
CREATE TABLE `5kcrm_admin_scene_default`  (
  `default_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `user_id` int(11) NOT NULL COMMENT '人员ID',
  `scene_id` int(11) NOT NULL COMMENT '场景ID',
  UNIQUE INDEX `default_id`(`default_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '场景默认关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_scene_default
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_sort
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_sort`;
CREATE TABLE `5kcrm_admin_sort`  (
  `sort_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '排序内容',
  PRIMARY KEY (`sort_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '顶部导航栏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_sort
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_structure
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_structure`;
CREATE TABLE `5kcrm_admin_structure`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) NULL DEFAULT 0,
  `owner_user_id` int(5) UNSIGNED NULL DEFAULT 0 COMMENT '当前部门负责人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_structure
-- ----------------------------
INSERT INTO `5kcrm_admin_structure` VALUES (1, '办公室', 0, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_system
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_system`;
CREATE TABLE `5kcrm_admin_system`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_system
-- ----------------------------
INSERT INTO `5kcrm_admin_system` VALUES (1, 'name', '悟空CRM', '网站名称');
INSERT INTO `5kcrm_admin_system` VALUES (2, 'logo', '', '企业logo');

-- ----------------------------
-- Table structure for 5kcrm_admin_system_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_system_log`;
CREATE TABLE `5kcrm_admin_system_log`  (
  `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `target_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被操作对象的名称',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `client_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户IP',
  `module_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块名',
  `controller_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `action_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `action_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作ID',
  `action_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1为删除操作',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `create_time` int(10) NOT NULL COMMENT '时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统操作日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_system_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_upgrade_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_upgrade_record`;
CREATE TABLE `5kcrm_admin_upgrade_record`  (
  `version` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '版本号',
  UNIQUE INDEX `version`(`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '升级记录，用于防止重复执行升级SQL。' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_upgrade_record
-- ----------------------------
INSERT INTO `5kcrm_admin_upgrade_record` VALUES (1103);
INSERT INTO `5kcrm_admin_upgrade_record` VALUES (1104);

-- ----------------------------
-- Table structure for 5kcrm_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_user`;
CREATE TABLE `5kcrm_admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理后台账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理后台密码',
  `salt` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '安全符',
  `img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `thumb_img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像缩略图',
  `create_time` int(11) NOT NULL,
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '员工编号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `sex` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '男、女',
  `structure_id` int(11) NOT NULL DEFAULT 0 COMMENT '部门',
  `post` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '岗位',
  `status` tinyint(3) NOT NULL DEFAULT 2 COMMENT '状态,0禁用,1启用,2未激活',
  `parent_id` int(10) NOT NULL DEFAULT 0 COMMENT '直属上级ID',
  `authkey` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证信息',
  `authkey_time` int(11) NOT NULL DEFAULT 0 COMMENT '验证失效时间',
  `type` tinyint(2) NOT NULL COMMENT '1系统用户 0非系统用户',
  `is_read_notice` tinyint(1) NOT NULL DEFAULT 0 COMMENT '用户是否已读升级公告：1已读；0未读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for 5kcrm_admin_user_field
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_user_field`;
CREATE TABLE `5kcrm_admin_user_field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `types` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `datas` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '属性值',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义字段展示排序关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_user_field
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_user_threeparty
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_user_threeparty`;
CREATE TABLE `5kcrm_admin_user_threeparty`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联模块',
  `value` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '关联第三方' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_user_threeparty
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_achievement
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_achievement`;
CREATE TABLE `5kcrm_crm_achievement`  (
  `achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名字',
  `obj_id` int(11) NOT NULL DEFAULT 0 COMMENT '对象ID',
  `type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '1公司2部门3员工',
  `year` int(8) NOT NULL COMMENT '年',
  `january` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '一月',
  `february` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '二月',
  `march` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '三月',
  `april` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '四月',
  `may` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '五月',
  `june` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '六月',
  `july` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '七月',
  `august` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '八月',
  `september` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '九月',
  `october` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '十月',
  `november` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '十一月',
  `december` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '十二月',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '1销售（目标）2回款（目标）',
  `yeartarget` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '年目标',
  PRIMARY KEY (`achievement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_achievement
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_activity
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_activity`;
CREATE TABLE `5kcrm_crm_activity`  (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联类型',
  `activity_type_id` int(11) NOT NULL COMMENT '类型ID',
  `type` int(1) NULL DEFAULT 1 COMMENT '活动类型 1 跟进记录 2 创建记录 3 商机阶段变更 4 外勤签到',
  `status` int(2) NULL DEFAULT 1 COMMENT '0 删除 1 未删除',
  `lng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '签到地址',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联客户',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联合同',
  `leads_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联线索',
  `activity_type` int(1) NOT NULL COMMENT '活动类型 1 线索 2 客户 3 联系人 4 产品 5 商机 6 合同 7回款 8日志 9审批 10日程 11任务 12 发邮件',
  `content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟进内容',
  `category` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '跟进类型',
  `next_time` int(11) NULL DEFAULT 0 COMMENT '下次联系时间',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商机ID',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  UNIQUE INDEX `activity_id`(`activity_id`) USING BTREE,
  INDEX `create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '跟进记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_activity
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_activity_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_activity_file`;
CREATE TABLE `5kcrm_crm_activity_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '跟进记录附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_activity_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business`;
CREATE TABLE `5kcrm_crm_business`  (
  `business_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `type_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商机状态组',
  `status_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商机阶段',
  `status_time` int(11) NOT NULL DEFAULT 0 COMMENT '阶段推进时间',
  `is_end` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1赢单2输单3无效',
  `next_time` int(11) NOT NULL DEFAULT 0 COMMENT '下次联系时间',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商机名称',
  `money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '商机金额',
  `total_price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '产品总金额',
  `deal_date` date NULL DEFAULT NULL COMMENT '预计成交日期',
  `discount_rate` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '整单折扣',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `is_dealt` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否已经处理（待办事项）：1已处理；0未处理；',
  `expire_remind` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否提醒合同到期：1提醒；0提醒',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后跟进时间',
  `last_record` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后跟进记录',
  `contacts_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`business_id`) USING BTREE,
  INDEX `bi_analysis`(`create_time`, `is_end`, `owner_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_data`;
CREATE TABLE `5kcrm_crm_business_data`  (
  `business_id` int(10) UNSIGNED NOT NULL COMMENT '商机表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_business_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_file`;
CREATE TABLE `5kcrm_crm_business_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL COMMENT '商机ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_log`;
CREATE TABLE `5kcrm_crm_business_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL COMMENT '商机id',
  `status_id` int(11) NOT NULL COMMENT '状态id',
  `is_end` tinyint(4) NOT NULL COMMENT '1赢单2输单3无效',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机推进日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business_product
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_product`;
CREATE TABLE `5kcrm_crm_business_product`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL COMMENT '商机ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '产品单价',
  `sales_price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '销售价格',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `discount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '折扣',
  `subtotal` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '小计（折扣后价格）',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '单位',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机产品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business_product
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_business_status
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_status`;
CREATE TABLE `5kcrm_crm_business_status`  (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL COMMENT '商机状态类别ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识',
  `rate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '赢单率',
  `order_id` tinyint(4) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`status_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机状态' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business_status
-- ----------------------------
INSERT INTO `5kcrm_crm_business_status` VALUES (1, 0, '赢单', '100', 99);
INSERT INTO `5kcrm_crm_business_status` VALUES (2, 0, '输单', '0', 100);
INSERT INTO `5kcrm_crm_business_status` VALUES (3, 0, '无效', '0', 101);
INSERT INTO `5kcrm_crm_business_status` VALUES (4, 1, '验证客户', '20', 1);
INSERT INTO `5kcrm_crm_business_status` VALUES (5, 1, '需求分析', '15', 2);
INSERT INTO `5kcrm_crm_business_status` VALUES (6, 1, '方案/报价', '30', 3);
INSERT INTO `5kcrm_crm_business_status` VALUES (7, 1, '谈判审核', '30', 4);

-- ----------------------------
-- Table structure for 5kcrm_crm_business_type
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_business_type`;
CREATE TABLE `5kcrm_crm_business_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识',
  `structure_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门ID',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1启用0禁用',
  `is_display` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '软删除：1显示0不显示',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机状态组类别' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_business_type
-- ----------------------------
INSERT INTO `5kcrm_crm_business_type` VALUES (1, '系统默认', '', 1, 1540973371, 1540973371, 1, 1);

-- ----------------------------
-- Table structure for 5kcrm_crm_config
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_config`;
CREATE TABLE `5kcrm_crm_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'CRM管理相关配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_config
-- ----------------------------
INSERT INTO `5kcrm_crm_config` VALUES (1, 'follow_day', '7', '距跟进天数');
INSERT INTO `5kcrm_crm_config` VALUES (2, 'deal_day', '30', '距成交天数');
INSERT INTO `5kcrm_crm_config` VALUES (3, 'config', '0', '1启用规则');
INSERT INTO `5kcrm_crm_config` VALUES (4, 'contract_day', '15', '合同到期提醒天数');
INSERT INTO `5kcrm_crm_config` VALUES (5, 'record_type', '[\"\\u6253\\u7535\\u8bdd\",\"\\u53d1\\u90ae\\u4ef6\",\"\\u53d1\\u77ed\\u4fe1\",\"\\u89c1\\u9762\\u62dc\\u8bbf\",\"\\u6d3b\\u52a8\"]', '跟进记录类型');
INSERT INTO `5kcrm_crm_config` VALUES (6, 'contract_config', '1', '1开启');
INSERT INTO `5kcrm_crm_config` VALUES (9, 'activity_phrase', 'a:4:{i:0;s:18:\"电话无人接听\";i:1;s:15:\"客户无意向\";i:2;s:42:\"客户意向度适中，后续继续跟进\";i:3;s:42:\"客户意向度较强，成交几率较大\";}', '跟进记录常用语');
INSERT INTO `5kcrm_crm_config` VALUES (10, 'visit_config', '1', '是否开启回访提醒：1开启；0不开启');
INSERT INTO `5kcrm_crm_config` VALUES (11, 'visit_day', '10', '客户回访提醒天数');

-- ----------------------------
-- Table structure for 5kcrm_crm_contacts
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contacts`;
CREATE TABLE `5kcrm_crm_contacts`  (
  `contacts_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `decision` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否关键决策人',
  `post` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务',
  `sex` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `detail_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人ID',
  `next_time` int(11) NULL DEFAULT NULL COMMENT '下次联系时间',
  `primary` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是首要联系人：1是；0不是',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后跟进时间',
  `last_record` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后跟进记录',
  PRIMARY KEY (`contacts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '联系人表' ROW_FORMAT = DYNAMIC;
