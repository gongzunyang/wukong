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
-- Records of 5kcrm_crm_contacts
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contacts_business
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contacts_business`;
CREATE TABLE `5kcrm_crm_contacts_business`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `contacts_id` int(10) NOT NULL,
  `business_id` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_contacts_business
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contacts_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contacts_data`;
CREATE TABLE `5kcrm_crm_contacts_data`  (
  `contacts_id` int(10) UNSIGNED NOT NULL COMMENT '联系人表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '联系人表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_contacts_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contacts_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contacts_file`;
CREATE TABLE `5kcrm_crm_contacts_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `contacts_id` int(11) NOT NULL COMMENT '联系人ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '联系人附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_contacts_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contract
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contract`;
CREATE TABLE `5kcrm_crm_contract`  (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `business_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商机名称',
  `contacts_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户签约人',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同名称',
  `num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `order_date` date NULL DEFAULT NULL COMMENT '下单时间',
  `money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '合同金额',
  `total_price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '产品总金额',
  `discount_rate` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '整单折扣',
  `check_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0待审核、1审核中、2审核通过、3审核未通过、4撤销、5草稿(未提交)',
  `flow_id` int(11) NOT NULL DEFAULT 0 COMMENT '审核流程ID',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT '审核步骤排序ID',
  `check_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审批人IDs',
  `flow_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流程审批人ID',
  `start_time` date NULL DEFAULT NULL COMMENT '合同开始时间',
  `end_time` date NULL DEFAULT NULL COMMENT '合同到期时间',
  `order_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司签约人',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  `next_time` int(11) NOT NULL DEFAULT 0 COMMENT '下次联系时间',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `is_visit` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已回访：1已回访；2未回访',
  `expire_remind` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否提醒合同到期：1提醒；0提醒',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后跟进时间',
  `last_record` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后跟进记录',
  PRIMARY KEY (`contract_id`) USING BTREE,
  INDEX `bi_analysis`(`check_status`, `customer_id`, `order_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_contract
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contract_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contract_data`;
CREATE TABLE `5kcrm_crm_contract_data`  (
  `contract_id` int(10) UNSIGNED NOT NULL COMMENT '合同表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_contract_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contract_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contract_file`;
CREATE TABLE `5kcrm_crm_contract_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL COMMENT '合同ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_contract_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_contract_product
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_contract_product`;
CREATE TABLE `5kcrm_crm_contract_product`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL COMMENT '合同ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '产品单价',
  `sales_price` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '销售价格',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '数量',
  `discount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '折扣',
  `subtotal` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '小计（折扣后价格）',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '单位',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同产品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_contract_product
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer`;
CREATE TABLE `5kcrm_crm_customer`  (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `is_lock` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1锁定',
  `deal_time` int(11) NOT NULL COMMENT '领取，分配，创建时间',
  `level` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户级别',
  `industry` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户行业',
  `source` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户来源',
  `telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人ID',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省市区',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '定位信息',
  `detail_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `lng` double(14, 11) NULL DEFAULT NULL COMMENT '地理位置经度',
  `lat` double(14, 11) NULL DEFAULT NULL COMMENT '地理位置维度',
  `next_time` int(11) NULL DEFAULT NULL COMMENT '下次联系时间',
  `follow` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟进',
  `obtain_time` int(10) NOT NULL DEFAULT 0 COMMENT '负责人获取客户时间',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `is_dealt` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否已经处理（待办事项）：1已处理；0未处理；',
  `is_allocation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是分配给我的客户：1是；0不是',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后跟进时间',
  `last_record` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后跟进记录',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `before_owner_user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '前负责人',
  `into_pool_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '进入公海时间',
  `pool_remain` tinyint(1) NOT NULL DEFAULT 0 COMMENT '代办事项待进入公海：1已处理，0未处理',
  `deal_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未成交' COMMENT '成交状态',
  PRIMARY KEY (`customer_id`) USING BTREE,
  INDEX `bi_analysis`(`create_time`, `owner_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_config
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_config`;
CREATE TABLE `5kcrm_crm_customer_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工',
  `structure_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门',
  `types` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1拥有客户上限2锁定客户上限',
  `value` int(10) NOT NULL COMMENT '数值',
  `is_deal` tinyint(4) NOT NULL COMMENT '1成交客户',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户配置表（锁定、拥有）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_config
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_data`;
CREATE TABLE `5kcrm_crm_customer_data`  (
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_customer_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_file`;
CREATE TABLE `5kcrm_crm_customer_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool`;
CREATE TABLE `5kcrm_crm_customer_pool`  (
  `pool_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pool_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `admin_user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员IDS',
  `user_ids` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '成员IDS',
  `department_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '部门IDS',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1启用，0停用',
  `before_owner_conf` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '前负责人领取规则：1限制，0不限制',
  `before_owner_day` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '前负责人领取规则限制天数',
  `receive_conf` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '领取频率规则：1限制，0不限制',
  `receive_count` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '领取频率个数',
  `remind_conf` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提醒规则：1开启，0不开启',
  `remain_day` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提前几天提醒',
  `recycle_conf` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '自动回收规则：1自动回收，0不自动回收',
  `create_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建人',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`pool_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool
-- ----------------------------
INSERT INTO `5kcrm_crm_customer_pool` VALUES (1, '系统默认公海', ',1,', ',1,2,3,4,', '', 1, 0, 0, 0, 0, 0, 0, 1, 1, 1624437604);

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool_field_setting
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool_field_setting`;
CREATE TABLE `5kcrm_crm_customer_pool_field_setting`  (
  `setting_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pool_id` int(10) UNSIGNED NOT NULL COMMENT '公海ID',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段中文名',
  `field_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段英文名',
  `form_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段类型，与5kcrm_admin_field表的form_type类型一致',
  `is_hidden` tinyint(1) UNSIGNED NOT NULL COMMENT '是否隐藏：1隐藏，0不隐藏',
  `is_null` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否必填：1必填，0不是必填',
  `is_unique` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否唯一：1唯一，0不唯一',
  PRIMARY KEY (`setting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海字段表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool_field_setting
-- ----------------------------
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (1, 1, '客户名称', 'name', 'text', 0, 1, 1);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (2, 1, '客户级别', 'level', 'select', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (3, 1, '客户行业', 'industry', 'select', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (4, 1, '客户来源', 'source', 'select', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (5, 1, '电话', 'telephone', 'text', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (6, 1, '网址', 'website', 'text', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (7, 1, '下次联系时间', 'next_time', 'datetime', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (8, 1, '备注', 'remark', 'textarea', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (9, 1, '手机', 'mobile', 'mobile', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (10, 1, '邮箱', 'email', 'email', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (33, 1, '省、市、区/县', 'address', 'customer_address', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (34, 1, '详细地址', 'detail_address', 'text', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (35, 1, '最后跟进记录', 'last_record', 'text', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (36, 1, '最后跟进时间', 'last_time', 'datetime', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (37, 1, '前负责人', 'before_owner_user_id', 'user', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (38, 1, '进入公海时间', 'into_pool_time', 'datetime', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (39, 1, '创建时间', 'create_time', 'datetime', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (40, 1, '更新时间', 'update_time', 'datetime', 0, 0, 0);
INSERT INTO `5kcrm_crm_customer_pool_field_setting` VALUES (41, 1, '创建人', 'create_user_id', 'user', 0, 0, 0);

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool_field_style
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool_field_style`;
CREATE TABLE `5kcrm_crm_customer_pool_field_style`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `pool_id` int(10) UNSIGNED NOT NULL COMMENT '公海ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海字段样式表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool_field_style
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool_record`;
CREATE TABLE `5kcrm_crm_customer_pool_record`  (
  `record_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '员工ID',
  `pool_id` int(10) UNSIGNED NOT NULL COMMENT '公海ID',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型：1领取公海客户；2将客户放入公海',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海操作记录（领取公海客户、将客户放入公海）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool_record
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool_relation`;
CREATE TABLE `5kcrm_crm_customer_pool_relation`  (
  `relation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pool_id` int(10) UNSIGNED NOT NULL COMMENT '公海ID',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户ID',
  PRIMARY KEY (`relation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海与客户关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_customer_pool_rule
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_customer_pool_rule`;
CREATE TABLE `5kcrm_crm_customer_pool_rule`  (
  `rule_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pool_id` int(10) UNSIGNED NOT NULL COMMENT '公海ID',
  `type` tinyint(1) UNSIGNED NOT NULL COMMENT '收回规则类型：1跟进记录；2商机；3成交状态',
  `deal_handle` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '选择不进入公海客户（成交客户）：1已选，0未选',
  `business_handle` tinyint(1) UNSIGNED NOT NULL COMMENT '选择不进入公海客户（有商机客户）：1已选，0不选',
  `level_conf` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '客户级别设置：1全部，2根据客户级别设置',
  `level` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '客户级别的设置数据',
  `limit_day` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '公海规则限制天数',
  PRIMARY KEY (`rule_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公海规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_customer_pool_rule
-- ----------------------------
INSERT INTO `5kcrm_crm_customer_pool_rule` VALUES (1, 1, 1, 0, 0, 1, '[{\"level\":\"\\u6240\\u6709\\u5ba2\\u6237\",\"limit_day\":30}]', 0);

-- ----------------------------
-- Table structure for 5kcrm_crm_dashboard
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_dashboard`;
CREATE TABLE `5kcrm_crm_dashboard`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dashboard` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(4) NOT NULL COMMENT '创建人 、修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仪表盘样式' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_dashboard
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_dealt_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_dealt_relation`;
CREATE TABLE `5kcrm_crm_dealt_relation`  (
  `dealt_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：crm_contract；crm_invoice；crm_receivables',
  `types_id` int(10) UNSIGNED NOT NULL COMMENT '类型ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`dealt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '待办事项关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_dealt_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_invoice
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_invoice`;
CREATE TABLE `5kcrm_crm_invoice`  (
  `invoice_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_apple_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票申请编号',
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contract_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `invoice_money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '开票金额',
  `invoice_date` date NULL DEFAULT NULL COMMENT '开票日期',
  `invoice_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开票类型',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `title_type` tinyint(1) NOT NULL COMMENT '抬头类型：1企业；2个人',
  `invoice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开票抬头',
  `tax_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '纳税人识别号',
  `deposit_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开户账号',
  `deposit_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开票地址',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '电话',
  `contacts_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系人',
  `contacts_mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系方式',
  `contacts_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系地址',
  `real_invoice_date` date NULL DEFAULT NULL COMMENT '实际开票日期',
  `invoice_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '发票号码',
  `logistics_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '物流单号',
  `create_user_id` int(10) UNSIGNED NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `check_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0待审核；1审核中；2审核通过；3审核未通过；4撤回',
  `flow_id` int(10) NULL DEFAULT 0 COMMENT '审核流程ID',
  `order_id` int(10) NULL DEFAULT 0 COMMENT '审核步骤排序ID',
  `check_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '审批人IDs',
  `flow_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '流程审批人ID',
  `invoice_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发票状态：0未开票；1已开票',
  `update_time` int(10) NOT NULL COMMENT '修改日期',
  `create_time` int(10) NOT NULL COMMENT '创建日期',
  `deposit_bank` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户行',
  `contract_money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '合同金额',
  PRIMARY KEY (`invoice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_invoice_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_invoice_data`;
CREATE TABLE `5kcrm_crm_invoice_data`  (
  `invoice_id` int(10) UNSIGNED NOT NULL COMMENT '发票表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发票表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_invoice_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_invoice_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_invoice_file`;
CREATE TABLE `5kcrm_crm_invoice_file`  (
  `r_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) UNSIGNED NOT NULL COMMENT '发票ID',
  `file_id` int(10) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发票附件关联表' ROW_FORMAT = DYNAMIC;
