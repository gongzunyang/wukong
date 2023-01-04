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
-- Records of 5kcrm_crm_invoice_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_invoice_info
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_invoice_info`;
CREATE TABLE `5kcrm_crm_invoice_info`  (
  `info_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL COMMENT '客户ID',
  `title_type` tinyint(1) NULL DEFAULT NULL COMMENT '抬头类型：1企业；2个人',
  `invoice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开票抬头',
  `tax_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '纳税人识别号',
  `deposit_bank` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户行',
  `deposit_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户账号',
  `deposit_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开票地址',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '编辑时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发票开户行信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_invoice_info
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_leads
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_leads`;
CREATE TABLE `5kcrm_crm_leads`  (
  `leads_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL DEFAULT 0 COMMENT '线索转化为客户ID',
  `is_transform` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1已转化',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '线索名称',
  `source` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '线索来源',
  `telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `industry` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户行业',
  `level` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户级别',
  `detail_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `next_time` int(11) NULL DEFAULT NULL COMMENT '下次联系时间',
  `follow` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟进',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `is_dealt` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否已经处理（待办事项）：1已处理；0未处理；',
  `is_allocation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是分配给我的线索：1是；0不是',
  `last_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后跟进时间',
  `last_record` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后跟进记录',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  PRIMARY KEY (`leads_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '线索表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_leads
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_leads_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_leads_data`;
CREATE TABLE `5kcrm_crm_leads_data`  (
  `leads_id` int(10) UNSIGNED NOT NULL COMMENT '线索表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '线索表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_leads_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_leads_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_leads_file`;
CREATE TABLE `5kcrm_crm_leads_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `leads_id` int(11) NOT NULL COMMENT '线索ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '线索附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_leads_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_market
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_market`;
CREATE TABLE `5kcrm_crm_market`  (
  `market_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动名称',
  `admin_market_id` int(11) NOT NULL COMMENT '关联对象 自定义字段',
  `main_user_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参与人',
  `market_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动类型',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '截止时间',
  `browse_number` int(11) NULL DEFAULT NULL COMMENT '浏览数',
  `submit_number` int(11) NULL DEFAULT NULL COMMENT '提交数',
  `budget_money` decimal(10, 0) NULL DEFAULT NULL COMMENT '活动预算',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动地址',
  `profiles` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `cover_images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动图片',
  `details_images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动详情图片',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态 0停用',
  `create_user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `market_field_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单自定义字段id',
  `second` tinyint(2) NULL DEFAULT 1 COMMENT '用户提交次数',
  PRIMARY KEY (`market_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_market
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_market_field
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_market_field`;
CREATE TABLE `5kcrm_crm_market_field`  (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_market_id` int(30) NOT NULL COMMENT '分类',
  `field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识名',
  `form_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段类型',
  `default_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '默认值',
  `max_length` int(4) NOT NULL DEFAULT 0 COMMENT ' 字数上限',
  `is_unique` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否唯一（1是，0否）',
  `is_null` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否必填（1是，0否）',
  `input_tips` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '输入提示',
  `setting` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '设置',
  `order_id` int(4) NOT NULL DEFAULT 0 COMMENT '排序ID',
  `operating` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0改删，1改，2删，3无',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `relevant` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关字段名',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否隐藏：1隐藏；0不隐藏',
  PRIMARY KEY (`field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义字段表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_market_field
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_market_form
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_market_form`;
CREATE TABLE `5kcrm_crm_market_form`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `market_id` int(11) NOT NULL COMMENT '活动关联',
  `synchro_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '同步状态 0未同步 1同步成功 2同步失败',
  `market_form` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表单数据',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '提交人',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '活动表单提交数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_market_form
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_number_sequence`;
CREATE TABLE `5kcrm_crm_number_sequence`  (
  `number_sequence_id` int(10) NOT NULL AUTO_INCREMENT,
  `sort` int(2) NOT NULL COMMENT '编号顺序',
  `type` int(2) NOT NULL COMMENT '编号类型 1文本 2日期 3数字',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文本内容或日期格式或起始编号',
  `increase_number` int(2) NULL DEFAULT NULL COMMENT '递增数',
  `reset` int(10) NULL DEFAULT 0 COMMENT '重置编号 0 从不，1 天，2 月， 3 年，',
  `last_number` int(10) NULL DEFAULT NULL COMMENT '上次生成的编号',
  `last_date` int(11) NULL DEFAULT NULL COMMENT '上次生成的时间',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人id',
  `company_id` bigint(20) NULL DEFAULT NULL COMMENT '公司id',
  `status` int(2) NOT NULL DEFAULT 0 COMMENT '默认开启使用自动编号 1不使用',
  `number_type` int(11) NULL DEFAULT NULL COMMENT '编号规则类型',
  PRIMARY KEY (`number_sequence_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '编号规则' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_number_sequence
-- ----------------------------
INSERT INTO `5kcrm_crm_number_sequence` VALUES (1, 1, 1, 'HT', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 1);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (2, 2, 2, 'yyyyMMdd', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 1);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (3, 3, 3, '1', 1, 1, 1, 1624437606, 1624437606, 1, NULL, 0, 1);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (4, 1, 1, 'HK', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 2);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (5, 2, 2, 'yyyyMMdd', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 2);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (6, 3, 3, '1', 1, 1, 1, 1624437606, 1624437606, 1, NULL, 0, 2);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (7, 1, 1, 'HF', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 3);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (8, 2, 2, 'yyyyMMdd', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 3);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (9, 3, 3, '1', 1, 1, 1, 1624437606, 1624437606, 1, NULL, 0, 3);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (10, 1, 2, 'yyyyMMdd', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 4);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (11, 2, 1, 'FP', NULL, NULL, NULL, NULL, 1624437606, 1, NULL, 0, 4);
INSERT INTO `5kcrm_crm_number_sequence` VALUES (12, 3, 3, '1', 1, 1, 1, 1624437606, 1624437606, 1, NULL, 0, 4);

-- ----------------------------
-- Table structure for 5kcrm_crm_printing_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_printing_record`;
CREATE TABLE `5kcrm_crm_printing_record`  (
  `printing_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块：1商机、2合同；3回款',
  `action_id` int(10) UNSIGNED NOT NULL COMMENT '操作ID',
  `template_id` int(10) UNSIGNED NOT NULL COMMENT '模板ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打印内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL COMMENT '编辑时间',
  PRIMARY KEY (`printing_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '打印记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_printing_record
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_product
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_product`;
CREATE TABLE `5kcrm_crm_product`  (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品编码',
  `unit` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `price` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '标准价格',
  `status` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '上架' COMMENT '是否上架',
  `category_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品类别',
  `category_str` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品分类id(层级)',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品描述',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `delete_user_id` int(10) NOT NULL DEFAULT 0 COMMENT '删除人',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `cover_images` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色组ID',
  `details_images` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图片',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_product
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_product_category
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_product_category`;
CREATE TABLE `5kcrm_crm_product_category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_product_category
-- ----------------------------
INSERT INTO `5kcrm_crm_product_category` VALUES (1, '默认', 0);

-- ----------------------------
-- Table structure for 5kcrm_crm_product_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_product_data`;
CREATE TABLE `5kcrm_crm_product_data`  (
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '产品表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_product_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_product_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_product_file`;
CREATE TABLE `5kcrm_crm_product_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_product_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_receivables
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_receivables`;
CREATE TABLE `5kcrm_crm_receivables`  (
  `receivables_id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期数',
  `number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回款编号',
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contract_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `return_time` date NULL DEFAULT NULL COMMENT '回款日期',
  `return_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回款方式',
  `money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '回款金额',
  `check_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0待审核、1审核中、2审核通过、3审核未通过、4撤销、5草稿(未提交)',
  `flow_id` int(11) NOT NULL DEFAULT 0 COMMENT '审核流程ID',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT '审核步骤排序ID',
  `check_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审批人IDs',
  `flow_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流程审批人ID',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(10) NOT NULL COMMENT '负责人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  PRIMARY KEY (`receivables_id`) USING BTREE,
  INDEX `bi_analysis`(`check_status`, `return_time`, `owner_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_receivables
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_receivables_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_receivables_data`;
CREATE TABLE `5kcrm_crm_receivables_data`  (
  `receivables_id` int(10) UNSIGNED NOT NULL COMMENT '回款表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_receivables_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_receivables_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_receivables_file`;
CREATE TABLE `5kcrm_crm_receivables_file`  (
  `r_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `receivables_id` int(10) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_receivables_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_receivables_plan
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_receivables_plan`;
CREATE TABLE `5kcrm_crm_receivables_plan`  (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '期数',
  `receivables_id` int(11) NOT NULL DEFAULT 0 COMMENT '回款ID',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1完成',
  `contract_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `money` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '计划回款金额',
  `return_date` date NULL DEFAULT NULL COMMENT '计划回款日期',
  `return_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计划回款方式',
  `remind` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提前几日提醒',
  `remind_date` date NULL DEFAULT NULL COMMENT '提醒日期',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `is_dealt` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已经处理（待办事项）：1已处理；0未处理；',
  `real_money` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '实际回款金额',
  `real_data` date DEFAULT NULL COMMENT '实际回款日期',
  `un_money` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '未回金额',
  PRIMARY KEY (`plan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款计划表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Records of 5kcrm_crm_receivables_plan
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_receivables_plan_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_receivables_plan_data`;
CREATE TABLE `5kcrm_crm_receivables_plan_data`  (
  `plan_id` int(10) UNSIGNED NOT NULL COMMENT '发票表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款计划表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_receivables_plan_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_star
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_star`;
CREATE TABLE `5kcrm_crm_star`  (
  `star_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '员工ID',
  `target_id` int(10) NOT NULL COMMENT '目标ID：客户、商机、线索、联系人',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：crm_leads线索；crm_customer客户；crm_contacts联系人；crm_business商机;',
  PRIMARY KEY (`star_id`) USING BTREE,
  UNIQUE INDEX `user_target_type`(`user_id`, `target_id`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '我关注的' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_star
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_team
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_team`;
CREATE TABLE `5kcrm_crm_team`  (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` tinyint(4) NOT NULL COMMENT '模块 1 客户 2联系人 3商机 4合同 5回款 ',
  `target_id` int(11) NOT NULL COMMENT '团队成员所属对象id',
  `target_time` int(11) NULL DEFAULT NULL COMMENT '截止到期时间',
  `team_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '团队用户id',
  `auth` tinyint(2) NOT NULL COMMENT '1 只读权限 2读写权限',
  PRIMARY KEY (`team_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '团队成员截止时间' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_team
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_top
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_top`;
CREATE TABLE `5kcrm_crm_top`  (
  `top_id` int(10) NOT NULL AUTO_INCREMENT,
  `module_id` int(10) NOT NULL COMMENT '相关模块ID',
  `set_top` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1置顶',
  `top_time` int(10) NOT NULL COMMENT '置顶时间',
  `create_role_id` int(10) NOT NULL COMMENT '创建人ID',
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'business' COMMENT '置顶模块',
  PRIMARY KEY (`top_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '置顶表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_top
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_visit
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_visit`;
CREATE TABLE `5kcrm_crm_visit`  (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '回访id',
  `owner_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回访人',
  `create_user_id` int(11) NOT NULL COMMENT '创建人id',
  `customer_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contract_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `contacts_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回访编号',
  `shape` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回访形式',
  `status` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理状态',
  `satisfaction` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户满意度',
  `feedback` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '客户反馈',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_state` int(2) NOT NULL DEFAULT 0 COMMENT '删除状态0 正常1回收站',
  `ro_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '只读权限',
  `rw_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '读写权限',
  `visit_time` date NULL DEFAULT NULL COMMENT '回访时间',
  `num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  PRIMARY KEY (`visit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_visit
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_visit_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_visit_data`;
CREATE TABLE `5kcrm_crm_visit_data`  (
  `visit_id` int(10) UNSIGNED NOT NULL COMMENT '回访表ID',
  `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回访表扩展字段数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_crm_visit_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_crm_visit_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_crm_visit_file`;
CREATE TABLE `5kcrm_crm_visit_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL COMMENT '回访ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回访客户附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_crm_visit_file
-- ----------------------------


-- ----------------------------
-- Table structure for 5kcrm_oa_announcement
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_announcement`;
CREATE TABLE `5kcrm_oa_announcement`  (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `structure_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知部门',
  `owner_user_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知人',
  `read_user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '阅读人',
  `is_read` tinyint(2) NOT NULL DEFAULT 0 COMMENT '1表示已读 0表示未读',
  PRIMARY KEY (`announcement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_event
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_event`;
CREATE TABLE `5kcrm_oa_event`  (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日程标题',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `owner_user_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参与人',
  `schedule_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'admin_oa_schedule表的主键ID',
  PRIMARY KEY (`event_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_event
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_event_notice
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_event_notice`;
CREATE TABLE `5kcrm_oa_event_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL COMMENT '日程ID',
  `noticetype` tinyint(4) UNSIGNED NULL DEFAULT NULL COMMENT '1分 2时 3天',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `stop_time` int(11) NOT NULL COMMENT '介绍时间',
  `number` tinyint(4) NOT NULL DEFAULT 0 COMMENT '根据noticetype来决定提前多久提醒',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程提醒设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_event_notice
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_event_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_event_relation`;
CREATE TABLE `5kcrm_oa_event_relation`  (
  `eventrelation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日程关联业务表',
  `event_id` int(11) NOT NULL COMMENT '日程ID',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户IDs',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人IDs',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商机IDs',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同IDs',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '状态1可用',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`eventrelation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程关联业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_event_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine`;
CREATE TABLE `5kcrm_oa_examine`  (
  `examine_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT 1 COMMENT '审批类型',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `money` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '差旅、报销总金额',
  `start_time` int(11) NOT NULL DEFAULT 0 COMMENT '开始时间',
  `end_time` int(11) NOT NULL DEFAULT 0 COMMENT '结束时间',
  `duration` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '时长',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `check_user_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审批人ID',
  `flow_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流程审批人ID',
  `check_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态（0待审、1审批中、2通过、3失败、4撤销）',
  `flow_id` int(11) NOT NULL DEFAULT 0 COMMENT '审批流程ID',
  `order_id` int(10) NOT NULL DEFAULT 0 COMMENT '审批流程排序ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `last_user_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '上一审批人',
  PRIMARY KEY (`examine_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_category
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_category`;
CREATE TABLE `5kcrm_oa_examine_category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1启用，0禁用',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1为系统类型，不能删除',
  `user_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '可见范围（员工）',
  `structure_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '可见范围（部门）',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1已删除',
  `delete_time` int(11) NOT NULL DEFAULT 0 COMMENT '删除时间',
  `delete_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '删除人ID',
  `flow_id` int(11) NOT NULL DEFAULT 0 COMMENT '审批流ID',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型图标和颜色',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_category
-- ----------------------------
INSERT INTO `5kcrm_oa_examine_category` VALUES (1, '普通审批', '普通审批', 1, 1, 1, '', '', 1612576450, 1612576450, 0, 0, 0, 1, 'wk wk-leave,#00CAAB');
INSERT INTO `5kcrm_oa_examine_category` VALUES (2, '请假审批', '请假审批', 1, 1, 1, '', '', 1612518097, 1612518097, 0, 0, 0, 2, 'wk wk-l-record,#3ABCFB');
INSERT INTO `5kcrm_oa_examine_category` VALUES (3, '出差审批', '出差审批', 1, 1, 1, '', '', 1548911542, 1548911542, 0, 0, 0, 3, 'wk wk-trip,#3ABCFB');
INSERT INTO `5kcrm_oa_examine_category` VALUES (4, '加班审批', '加班审批', 1, 1, 1, '', '', 1548911542, 1548911542, 0, 0, 0, 4, 'wk wk-overtime,#FAAD14');
INSERT INTO `5kcrm_oa_examine_category` VALUES (5, '差旅报销', '差旅报销', 1, 1, 1, '', '', 1548911542, 1548911542, 0, 0, 0, 5, 'wk wk-reimbursement,#3ABCFB');
INSERT INTO `5kcrm_oa_examine_category` VALUES (6, '借款申请', '借款申请', 1, 1, 1, '', '', 1548911542, 1548911542, 0, 0, 0, 6, 'wk wk-go-out,#FF6033');

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_data`;
CREATE TABLE `5kcrm_oa_examine_data`  (
  `data_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `examine_id` int(11) NOT NULL COMMENT '审批ID',
  `field` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  PRIMARY KEY (`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批数据扩展表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_file`;
CREATE TABLE `5kcrm_oa_examine_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `examine_id` int(11) NOT NULL COMMENT '审批ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_order
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_order`;
CREATE TABLE `5kcrm_oa_examine_order`  (
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `work_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '办公审批流排序表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_order
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_relation`;
CREATE TABLE `5kcrm_oa_examine_relation`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '审批关联业务表',
  `examine_id` int(11) NOT NULL COMMENT '审批ID',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户IDs',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人IDs',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商机IDs',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同IDs',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态1可用',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批关联业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_travel
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_travel`;
CREATE TABLE `5kcrm_oa_examine_travel`  (
  `travel_id` int(11) NOT NULL AUTO_INCREMENT,
  `examine_id` int(11) NOT NULL COMMENT '审批ID',
  `start_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '出发地',
  `start_time` int(11) NOT NULL COMMENT '出发时间',
  `end_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '目的地',
  `end_time` int(11) NOT NULL COMMENT '到达时间',
  `traffic` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '交通费',
  `stay` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '住宿费',
  `diet` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '餐饮费',
  `other` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '其他费用',
  `money` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `vehicle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '交通工具',
  `trip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '单程往返（单程、往返）',
  `duration` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '时长',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`travel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '差旅行程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_travel
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_examine_travel_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_examine_travel_file`;
CREATE TABLE `5kcrm_oa_examine_travel_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `travel_id` int(11) NOT NULL COMMENT '差旅id',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '差旅附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_examine_travel_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_log`;
CREATE TABLE `5kcrm_oa_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` tinyint(2) NOT NULL DEFAULT 1 COMMENT '日志类型（1日报，2周报，3月报）',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
  `tomorrow` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '明日工作内容',
  `question` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '遇到问题',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `send_user_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知人',
  `send_structure_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知部门',
  `read_user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '已读ids',
  `is_relation` tinyint(2) NOT NULL DEFAULT 1 COMMENT '0不关联1关联',
  `save_customer` int(10) NOT NULL DEFAULT 0 COMMENT '每日新增客户数量',
  `save_business` int(10) NOT NULL DEFAULT 0 COMMENT '每日新增商机',
  `save_contract` int(10) NOT NULL DEFAULT 0 COMMENT '每日新增合同',
  `save_receivables` decimal(18, 2) NOT NULL DEFAULT 0.00 COMMENT '每日新增回款',
  `save_activity` int(10) NOT NULL DEFAULT 0 COMMENT '新增跟进记录',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_log_favour
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_log_favour`;
CREATE TABLE `5kcrm_oa_log_favour`  (
  `favour_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '点赞人id',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态 0禁用 1显示',
  PRIMARY KEY (`favour_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '点赞记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_log_favour
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_log_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_log_file`;
CREATE TABLE `5kcrm_oa_log_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_id` int(11) NOT NULL COMMENT '日志ID',
  `file_id` int(11) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志附件关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_log_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_oa_log_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_oa_log_relation`;
CREATE TABLE `5kcrm_oa_log_relation`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志关联业务表',
  `log_id` int(11) NOT NULL COMMENT '日志ID',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户IDs',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人IDs',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商机IDs',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同IDs',
  `status` tinyint(2) NOT NULL COMMENT '状态1可用',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志关联业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_oa_log_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_task
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_task`;
CREATE TABLE `5kcrm_task`  (
  `task_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务表',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `main_user_id` int(11) NOT NULL COMMENT '负责人ID',
  `owner_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '团队成员ID',
  `structure_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门IDs',
  `create_time` int(11) NOT NULL COMMENT '新建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '完成状态 1正在进行,2延期,5结束',
  `class_id` int(5) NOT NULL DEFAULT 0 COMMENT '分类 要做 在做 待定',
  `lable_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标签 ,号拼接',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `pid` int(11) NULL DEFAULT 0 COMMENT '上级ID',
  `start_time` int(11) NOT NULL DEFAULT 0 COMMENT '开始时间',
  `stop_time` int(11) NOT NULL DEFAULT 0 COMMENT '结束时间',
  `priority` tinyint(2) NOT NULL DEFAULT 0 COMMENT '优先级 从大到小',
  `work_id` int(11) NULL DEFAULT 0 COMMENT '项目ID',
  `is_top` tinyint(2) NULL DEFAULT 0 COMMENT '工作台展示 0收件箱 1，2，3',
  `is_open` tinyint(2) NULL DEFAULT 1 COMMENT '是否公开',
  `order_id` tinyint(4) NOT NULL DEFAULT 0 COMMENT '排序ID',
  `top_order_id` tinyint(4) NOT NULL DEFAULT 0 COMMENT '我的任务排序ID',
  `is_archive` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1归档',
  `archive_time` int(11) NOT NULL DEFAULT 0 COMMENT '归档时间',
  `ishidden` tinyint(2) NULL DEFAULT 0 COMMENT '是否删除',
  `hidden_time` int(11) NOT NULL DEFAULT 0 COMMENT '删除时间',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_task
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_task_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_task_relation`;
CREATE TABLE `5kcrm_task_relation`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务关联业务表',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户IDs',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人IDs',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商机IDs',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同IDs',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态1可用',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务关联业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_task_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work`;
CREATE TABLE `5kcrm_work`  (
  `work_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名字',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '状态 1启用 0归档',
  `create_time` int(11) NOT NULL,
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `color` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '颜色',
  `is_open` tinyint(2) NULL DEFAULT 0 COMMENT '是否所有人可见 1可见',
  `owner_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目成员',
  `ishidden` tinyint(2) NULL DEFAULT 0 COMMENT '是否删除',
  `archive_time` int(11) NOT NULL DEFAULT 0 COMMENT '归档时间',
  `group_id` tinyint(1) NOT NULL DEFAULT 0 COMMENT '角色组ID',
  `cover_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面图片',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  `is_system_cover` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否是系统封面：1是；0不是',
  `is_follow` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注：1关注',
  PRIMARY KEY (`work_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_lable_order
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_lable_order`;
CREATE TABLE `5kcrm_work_lable_order`  (
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lable_id` int(10) UNSIGNED NOT NULL COMMENT '标签ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `order` int(10) UNSIGNED NOT NULL COMMENT '排序',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签排序表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_lable_order
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_order
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_order`;
CREATE TABLE `5kcrm_work_order`  (
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `work_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目排序表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_order
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_relation`;
CREATE TABLE `5kcrm_work_relation`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志关联业务表',
  `work_id` int(11) NOT NULL COMMENT '项目ID',
  `customer_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户IDs',
  `contacts_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人IDs',
  `business_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商机IDs',
  `contract_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '合同IDs',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态1可用',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目关联业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_task_class
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_task_class`;
CREATE TABLE `5kcrm_work_task_class`  (
  `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务分类表',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '状态1正常',
  `work_id` int(11) NOT NULL COMMENT '项目ID',
  `order_id` tinyint(4) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`class_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_task_class
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_task_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_task_file`;
CREATE TABLE `5kcrm_work_task_file`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL COMMENT '文件ID',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_task_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_task_lable
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_task_lable`;
CREATE TABLE `5kcrm_work_task_lable`  (
  `lable_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建人ID',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '状态',
  `color` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '颜色',
  PRIMARY KEY (`lable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_task_lable
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_task_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_task_log`;
CREATE TABLE `5kcrm_work_task_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '项目日志表',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(2) NULL DEFAULT 0 COMMENT '状态 4删除',
  `task_id` int(11) NULL DEFAULT 0 COMMENT '任务ID',
  `work_id` int(11) NULL DEFAULT 0 COMMENT '项目ID',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_task_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_work_user
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_work_user`;
CREATE TABLE `5kcrm_work_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` int(11) NOT NULL COMMENT '项目ID',
  `user_id` int(11) NOT NULL COMMENT '成员ID',
  `types` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1管理员，0初始权限',
  `group_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目成员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_work_user
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_app_navigation
-- ----------------------------

CREATE TABLE `5kcrm_app_navigation`  (
    `p_id` int(11) NOT NULL AUTO_INCREMENT,
    `data` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据集',
    `create_user_id` int(11) NOT NULL COMMENT '创建人',
    PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '手机端导航数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 5kcrm_app_navigation
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
