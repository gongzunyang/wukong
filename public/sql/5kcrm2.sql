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
-- Records of 5kcrm_admin_import_record
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_login_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_login_record`;
CREATE TABLE `5kcrm_admin_login_record`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '登录成功与否：0成功；1密码错误；2账号禁用',
  `create_user_id` int(10) NOT NULL DEFAULT 0 COMMENT '员工ID',
  `create_time` int(10) NOT NULL DEFAULT 0 COMMENT '登录时间',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP，IPv6是46 凑整64位',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录地址',
  `browser` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '浏览器',
  `os` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作系统',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '说明 - 暂时记录user-agent',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_login_record
-- ----------------------------

-- ----------------------------
-- Records of 5kcrm_admin_market
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_market`;
CREATE TABLE `5kcrm_admin_market`  (
    `market_field_id` int(11) NOT NULL AUTO_INCREMENT,
    `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '0 停用 1启用',
    `update_user_id` int(11) NULL DEFAULT NULL COMMENT '最后修改人',
    `create_time` int(11) NOT NULL COMMENT '创建时间',
    `update_time` int(11) NOT NULL COMMENT '修改时间',
    `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单名称',
    PRIMARY KEY (`market_field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统设置 活动表单' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Table structure for 5kcrm_admin_market
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_menu`;
CREATE TABLE `5kcrm_admin_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `pid` int(11) NULL DEFAULT 0 COMMENT '上级菜单ID',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `url` varchar(127) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '链接地址',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` tinyint(4) NOT NULL COMMENT '菜单类型',
  `sort` tinyint(4) NULL DEFAULT 0 COMMENT '排序（同级有效）',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `rule_id` int(11) NOT NULL COMMENT '权限id',
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_menu
-- ----------------------------
INSERT INTO `5kcrm_admin_menu` VALUES (1, 0, 'CRM模块', '', '', 0, 0, 1, 1, 'crm');
INSERT INTO `5kcrm_admin_menu` VALUES (2, 1, '线索', '', '', 0, 0, 1, 2, 'leads');
INSERT INTO `5kcrm_admin_menu` VALUES (3, 1, '客户', '', '', 0, 0, 1, 10, 'customer');
INSERT INTO `5kcrm_admin_menu` VALUES (4, 1, '联系人', '', '', 0, 0, 1, 22, 'contacts');
INSERT INTO `5kcrm_admin_menu` VALUES (5, 1, '公海', '', '', 0, 0, 1, 29, 'pool');
INSERT INTO `5kcrm_admin_menu` VALUES (6, 1, '商机', '', '', 0, 0, 1, 34, 'business');
INSERT INTO `5kcrm_admin_menu` VALUES (7, 1, '合同', '', '', 0, 0, 1, 42, 'contract');
INSERT INTO `5kcrm_admin_menu` VALUES (8, 1, '回款', '', '', 0, 0, 1, 50, 'receivables');
INSERT INTO `5kcrm_admin_menu` VALUES (9, 1, '产品', '', '', 0, 0, 1, 56, 'product');

-- ----------------------------
-- Table structure for 5kcrm_admin_message
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_message`;
CREATE TABLE `5kcrm_admin_message`  (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '消息类型，用于前端拼接消息',
  `to_user_id` int(10) NOT NULL COMMENT '接收人ID',
  `from_user_id` int(10) NOT NULL COMMENT '发送人ID',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送内容',
  `send_time` int(11) NOT NULL COMMENT '发送时间',
  `read_time` int(11) NOT NULL COMMENT '阅读时间',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块',
  `controller_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `action_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `action_id` int(11) NOT NULL COMMENT '操作ID',
  `advance_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提前时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态1未删除2已删除',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '站内信' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_message
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_oa_schedule
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_oa_schedule`;
CREATE TABLE `5kcrm_admin_oa_schedule`  (
  `schedule_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日程类型',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `color` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型颜色',
  `type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '类型 1系统类型2 自定义类型',
  `is_select` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '显示状态：1显示，0不显示',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程自定义类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_oa_schedule
-- ----------------------------
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (1, '分配的任务', 0, NULL, '1', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (2, '需联系的客户', 0, NULL, '2', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (3, '即将到期的合同', 0, NULL, '3', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (4, '计划回款', 0, NULL, '4', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (5, '需联系的线索', 0, NULL, '5', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (6, '需联系的商机', 0, NULL, '6', 1, 0);
INSERT INTO `5kcrm_admin_oa_schedule` VALUES (7, '预计成交的商机', 0, NULL, '7', 1, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_oa_schedule_relation
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_oa_schedule_relation`;
CREATE TABLE `5kcrm_admin_oa_schedule_relation`  (
  `schedule_relation_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '日程类型状态 0隐藏1 显示',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `schedule_id` int(10) NOT NULL DEFAULT 2 COMMENT '类型id',
  `user_id` int(10) NOT NULL COMMENT '负责人',
  PRIMARY KEY (`schedule_relation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程自定义类型显示状态' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_oa_schedule_relation
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_oalog_rule
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_oalog_rule`;
CREATE TABLE `5kcrm_admin_oalog_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) UNSIGNED NOT NULL COMMENT '类型：1日报；2周报；3月报；4欢迎语',
  `userIds` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID串',
  `effective_day` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需要统计的日志，针对日报',
  `start_time` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日报提交的开始时间',
  `end_time` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日报提交的结束时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：1启用；2禁用',
  `mark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '类型为欢迎语使用的字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日报规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_oalog_rule
-- ----------------------------
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (1, 4, NULL, NULL, NULL, NULL, 1, 'a:3:{i:0;s:27:\"每一天都是崭新的！\";i:1;s:63:\"蓝天是宁静的，空气是清新的，阳光是明媚的！\";i:2;s:93:\"以下内容为系统默认欢迎语，在日志随机展示，可自定义更改欢迎语。\";}');
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (2, 1, '3,4,10', '1,2,3,4,5,7,6', '08:00', '21:00', 1, NULL);
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (3, 2, '3,4', NULL, '1', '3', 1, NULL);
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (4, 3, '3', NULL, '3', '8', 1, NULL);

-- ----------------------------
-- Table structure for 5kcrm_admin_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_operation_log`;
CREATE TABLE `5kcrm_admin_operation_log`  (
  `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `target_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被操作对象',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '员工ID',
  `client_ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户的IP',
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块',
  `action_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '时间',
  `action_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_printing
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_printing`;
CREATE TABLE `5kcrm_admin_printing`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '预留字段：用户ID',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '显示字段：用户名称',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打印模板名称',
  `type` tinyint(1) NOT NULL COMMENT '打印类型：1商机；2合同；3回款',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打印内容',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '打印模板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_printing
-- ----------------------------
INSERT INTO `5kcrm_admin_printing` VALUES (1, 1, '超级管理员', '合同条款打印模板', 6, '{\"data\":\"<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">***\\u6709\\u9650\\u516c\\u53f8<\\/span><\\/p>\\n<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">\\u9500\\u552e\\u5408\\u540c<\\/span><\\/p>\\n<p style=\\\"text-align: right;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif; color: #525151;\\\">\\u5408\\u540c\\u7f16\\u53f7\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.num\\\">{\\u5408\\u540c\\u7f16\\u53f7}<\\/span><\\/span><\\/p>\\n<p>\\u7532\\u65b9\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--customer\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"customer.name\\\">{\\u5ba2\\u6237\\u540d\\u79f0}<\\/span><\\/p>\\n<p>\\u4e59\\u65b9\\uff1a<span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u90d1\\u5dde\\u5361\\u5361\\u7f57\\u7279\\u8f6f\\u4ef6\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8<\\/span><\\/p>\\n<p>&nbsp;<\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u7532\\u4e59\\u53cc\\u65b9\\u672c\\u7740\\u76f8\\u4e92\\u4fe1\\u4efb\\uff0c\\u771f\\u8bda\\u5408\\u4f5c\\u7684\\u539f\\u5219\\uff0c\\u7ecf\\u53cc\\u65b9\\u53cb\\u597d\\u534f\\u5546\\uff0c\\u5c31\\u4e59\\u65b9\\u4e3a\\u7532\\u65b9\\u63d0\\u4f9b\\u7279\\u5b9a\\u670d\\u52a1\\u8fbe\\u6210\\u4e00\\u81f4\\u610f\\u89c1\\uff0c\\u7279\\u7b7e\\u8ba2\\u672c\\u5408\\u540c\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\"><strong>\\u4e00\\u3001\\u670d\\u52a1\\u5185\\u5bb9<\\/strong><\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">1\\u3001\\u4e59\\u65b9\\u540c\\u610f\\u5411\\u7532\\u65b9\\u63d0\\u4f9b\\u7684\\u7279\\u5b9a\\u670d\\u52a1\\u3002\\u670d\\u52a1\\u7684\\u5185\\u5bb9\\u7684\\u6807\\u51c6\\u89c1\\u9644\\u4ef6A\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">2\\u3001\\u5982\\u679c\\u4e59\\u65b9\\u5728\\u5de5\\u4f5c\\u4e2d\\u56e0\\u81ea\\u8eab\\u8fc7\\u9519\\u800c\\u53d1\\u751f\\u4efb\\u4f55\\u9519\\u8bef\\u6216\\u9057\\u6f0f\\uff0c\\u4e59\\u65b9\\u5e94\\u65e0\\u6761\\u4ef6\\u66f4\\u6b63\\uff0c\\u800c\\u4e0d\\u53e6\\u5916\\u6536\\u8d39\\uff0c\\u5e76\\u5bf9\\u56e0\\u6b64\\u800c\\u5bf9\\u7532\\u65b9\\u9020\\u6210\\u7684\\u635f\\u5931\\u627f\\u62c5\\u8d54\\u507f\\u8d23\\u4efb\\uff0c\\u8d54\\u507f\\u4ee5\\u9644\\u4ef6A\\u6240\\u8f7d\\u660e\\u7684\\u8be5\\u9879\\u670d\\u52a1\\u5185\\u5bb9\\u5bf9\\u5e94\\u4e4b\\u670d\\u52a1\\u8d39\\u4e3a\\u9650\\u3002\\u82e5\\u56e0\\u7532\\u65b9\\u539f\\u56e0\\u9020\\u6210\\u5de5\\u4f5c\\u7684\\u5ef6\\u8bef\\uff0c\\u5c06\\u7531\\u7532\\u65b9\\u627f\\u62c5\\u76f8\\u5e94\\u7684\\u635f\\u5931\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">3\\u3001\\u4e59\\u65b9\\u7684\\u670d\\u52a1\\u627f\\u8bfa\\uff1a<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">&nbsp; &nbsp; 1\\uff09\\u4e59\\u65b9\\u63a5\\u5230\\u7532\\u65b9\\u901a\\u8fc7\\u7535\\u8bdd\\u3001\\u4fe1\\u51fd\\u4f20\\u771f\\u3001\\u7535\\u5b50\\u90ae\\u4ef6\\u3001\\u7f51\\u4e0a\\u63d0\\u4ea4\\u7b49\\u65b9\\u5f0f\\u63d0\\u51fa\\u5173\\u4e8e\\u9644\\u4ef6A\\u6240\\u5217\\u670d\\u52a1\\u7684\\u8bf7\\u6c42\\u540e\\uff0c\\u5728\\u4e24\\u4e2a\\u6709\\u6548\\u5de5\\u4f5c\\u65e5\\u5185\\u7ed9\\u4e88\\u54cd\\u5e94\\u5e76\\u63d0\\u4f9b\\u670d\\u52a1\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">&nbsp; &nbsp; 2\\uff09\\u4e59\\u65b9\\u63d0\\u4f9b\\u7ed9\\u7532\\u65b9\\u7684\\u670d\\u52a1\\uff0c\\u5fc5\\u987b\\u6309\\u7167\\u5408\\u540c\\u9644\\u4ef6A\\u89c4\\u5b9a\\u7684\\u6807\\u51c6\\u8fdb\\u884c\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">4\\u3001\\u4ea7\\u54c1\\u660e\\u7ec6\\uff1a<\\/span><\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%;\\\" border=\\\"1\\\" data-wk-table-tag=\\\"table\\\">\\n<tbody>\\n<tr data-wk-table-tr-tag=\\\"header\\\">\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u540d\\u79f0<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u7c7b\\u522b<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5355\\u4f4d<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6807\\u51c6\\u4ef7\\u683c<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u552e\\u4ef7<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6570\\u91cf<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6298\\u6263<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5408\\u8ba1<\\/td>\\n<\\/tr>\\n<tr data-wk-table-tr-tag=\\\"value\\\">\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.name\\\">{\\u4ea7\\u54c1\\u540d\\u79f0}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.category_id\\\">{\\u4ea7\\u54c1\\u7c7b\\u522b}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.unit\\\">{\\u5355\\u4f4d}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.price\\\">{\\u6807\\u51c6\\u4ef7\\u683c}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.sales_price\\\">{\\u552e\\u4ef7}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.count\\\">{\\u6570\\u91cf}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.discount\\\">{\\u6298\\u6263}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.subtotal\\\">{\\u5408\\u8ba1}<\\/span><\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p>\\u6574\\u5355\\u6298\\u6263\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.discount_rate\\\">{\\u6574\\u5355\\u6298\\u6263}<\\/span>&nbsp;&nbsp;&nbsp; \\u4ea7\\u54c1\\u603b\\u91d1\\u989d\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.total_price\\\">{\\u4ea7\\u54c1\\u603b\\u91d1\\u989d}<\\/span><\\/p>\\n<p><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\"><strong>\\u4e8c\\u3001\\u670d\\u52a1\\u8d39\\u7684\\u652f\\u4ed8<\\/strong><\\/span><\\/p>\\n<p><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">1\\u3001\\u670d\\u52a1\\u8d39\\u603b\\u91d1\\u989d\\u4e3a<span style=\\\"text-decoration: underline;\\\">&nbsp;&nbsp;&nbsp; <span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.money\\\">{\\u5408\\u540c\\u91d1\\u989d}<\\/span> &nbsp;&nbsp; <\\/span><\\/span><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u5143\\u4eba\\u6c11\\u5e01(\\u4eba\\u6c11\\u5e01\\u5927\\u5199\\uff1a<span style=\\\"text-decoration: underline;\\\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<\\/span> \\u5143\\u6574)\\u3002<span style=\\\"text-decoration: underline;\\\"><br \\/><\\/span><\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">2\\u3001\\u672c\\u8d39\\u7528\\u7ed3\\u6784\\u4ec5\\u9650\\u65bc\\u9644\\u4ef6A\\u4e2d\\u5217\\u660e\\u7684\\u5de5\\u4f5c\\u3002\\u5982\\u679c\\u7532\\u65b9\\u8981\\u6c42\\u6269\\u5927\\u9879\\u76ee\\u8303\\u56f4\\uff0c\\u6216\\u56e0\\u7532\\u65b9\\u6539\\u53d8\\u5df2\\u7ecf\\u8bae\\u5b9a\\u7684\\u9879\\u76ee\\u5185\\u5bb9\\u5bfc\\u81f4\\u4e59\\u65b9\\u9700\\u91cd\\u590d\\u8fdb\\u884c\\u9879\\u76ee\\u6b65\\u9aa4\\uff0c\\u4e59\\u65b9\\u5c06\\u9700\\u8981\\u91cd\\u65b0\\u8bc4\\u4f30\\u4e0a\\u8ff0\\u8d39\\u7528\\u7ed3\\u6784\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">3\\u3001\\u7532\\u4e59\\u53cc\\u65b9\\u4e00\\u81f4\\u540c\\u610f\\u9879\\u76ee\\u670d\\u52a1\\u8d39\\u6309\\u4e00\\u6b21\\u6027\\u4ee5\\u4eba\\u6c11\\u5e01\\u5f62\\u5f0f\\u652f\\u4ed8\\u3002\\u670d\\u52a1\\u5b8c\\u6210\\u540e\\uff0c\\u7532\\u65b9\\u5c06\\u5728\\u9a8c\\u6536\\u786e\\u8ba4\\u670d\\u52a1\\u5b8c\\u6210\\u5408\\u683c\\uff0c\\u5e76\\u4e14\\u4e59\\u65b9\\u53d1\\u51fa\\u8be5\\u9636\\u6bb5\\u5de5\\u4f5c\\u7684\\u8d39\\u7528\\u8d26\\u5355\\u53ca\\u6b63\\u5f0f\\u6709\\u6548\\u7684\\u7a0e\\u52a1\\u53d1\\u7968\\u540e3\\u4e2a\\u5de5\\u4f5c\\u65e5\\u5185\\uff0c\\u5411\\u4e59\\u65b9\\u652f\\u4ed8\\u7ea6\\u5b9a\\u7684\\u8d39\\u7528\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">4\\u3001\\u6709\\u5173\\u53d1\\u7968\\u65b9\\u9762\\u7684\\u4efb\\u4f55\\u95ee\\u9898\\uff0c\\u7532\\u65b9\\u5e94\\u5728\\u6536\\u5230\\u53d1\\u7968\\u540e\\u53ca\\u65f6\\u4e66\\u9762\\u901a\\u77e5\\u4e59\\u65b9\\uff0c\\u4fbf\\u4e59\\u65b9\\u53ca\\u65f6\\u4f5c\\u51fa\\u89e3\\u91ca\\u6216\\u89e3\\u51b3\\u95ee\\u9898\\uff0c\\u4ee5\\u4f7f\\u7532\\u65b9\\u80fd\\u6309\\u65f6\\u4ed8\\u6b3e\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">5\\u3001\\u4e59\\u65b9\\u5c06\\u81ea\\u884c\\u627f\\u62c5\\u9879\\u76ee\\u5b9e\\u65bd\\u8303\\u56f4\\u5185\\u5408\\u7406\\u7684\\u5dee\\u65c5\\u8d39\\u7528\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">6\\u3001\\u4e59\\u65b9\\u540c\\u610f\\u514d\\u9664\\u9879\\u76ee\\u6742\\u8d39\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">7\\u3001\\u672c\\u534f\\u8bae\\u6709\\u6548\\u671f\\u4e3a\\uff1a<span style=\\\"text-decoration: underline;\\\"> &nbsp;&nbsp; <span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.start_time\\\">{\\u5408\\u540c\\u5f00\\u59cb\\u65f6\\u95f4}<\\/span><\\/span><span style=\\\"text-decoration: underline;\\\"> &nbsp; &nbsp; <\\/span>&nbsp; <\\/span>\\u8d77 <span style=\\\"text-decoration: underline;\\\"> &nbsp;&nbsp; <\\/span><span style=\\\"text-decoration: underline;\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"contract.end_time\\\">{\\u5408\\u540c\\u5230\\u671f\\u65f6\\u95f4}<\\/span> &nbsp; &nbsp;&nbsp;<\\/span> \\u6b62<\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\"><strong>\\u4e09\\u3001\\u670d\\u52a1\\u7684\\u53d8\\u66f4<\\/strong><\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u7532\\u65b9\\u53ef\\u4ee5\\u63d0\\u524d\\u4e2a\\u5de5\\u4f5c\\u65e5\\u4ee5\\u4e66\\u9762\\u5f62\\u5f0f\\u8981\\u6c42\\u53d8\\u66f4\\u6216\\u589e\\u52a0\\u6240\\u63d0\\u4f9b\\u7684\\u670d\\u52a1\\u3002\\u8be5\\u7b49\\u53d8\\u66f4\\u6700\\u7ec8\\u5e94\\u7531\\u53cc\\u65b9\\u4e92\\u76f8\\u5546\\u5b9a\\u8ba4\\u53ef\\uff0c\\u5176\\u4e2d\\u5305\\u62ec\\u4e0e\\u8be5\\u7b49\\u53d8\\u66f4\\u6709\\u5173\\u7684\\u4efb\\u4f55\\u8d39\\u7528\\u8c03\\u6574\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\"><strong>\\u56db\\u3001\\u4e89\\u8bae\\u5904\\u7406<\\/strong><\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u7532\\u4e59\\u53cc\\u65b9\\u5982\\u5bf9\\u534f\\u8bae\\u6761\\u6b3e\\u89c4\\u5b9a\\u7684\\u7406\\u89e3\\u6709\\u5f02\\u8bae\\uff0c\\u6216\\u8005\\u5bf9\\u4e0e\\u534f\\u8bae\\u6709\\u5173\\u7684\\u4e8b\\u9879\\u53d1\\u751f\\u4e89\\u8bae\\uff0c\\u53cc\\u65b9\\u5e94\\u672c\\u7740\\u53cb\\u597d\\u5408\\u4f5c\\u7684\\u7cbe\\u795e\\u8fdb\\u884c\\u534f\\u5546\\u3002\\u534f\\u5546\\u4e0d\\u80fd\\u89e3\\u51b3\\u7684\\uff0c\\u4efb\\u4f55\\u4e00\\u65b9\\u53ef\\u5411\\u4ef2\\u88c1\\u59d4\\u5458\\u4f1a\\u63d0\\u8d77\\u4ef2\\u88c1\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\"><strong>\\u4e94\\u3001\\u5176\\u4ed6<\\/strong><\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">1\\u3001\\u672c\\u5408\\u540c\\u4e2d\\u6240\\u7528\\u7684\\u6807\\u9898\\u4ec5\\u4e3a\\u65b9\\u4fbf\\u800c\\u8bbe\\uff0c\\u800c\\u4e0d\\u5f71\\u54cd\\u5bf9\\u672c\\u5408\\u540c\\u7684\\u89e3\\u91ca\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">2\\u3001\\u9644\\u4ef6A\\u662f\\u672c\\u5408\\u540c\\u4e0d\\u53ef\\u5206\\u5272\\u7684\\u7ec4\\u6210\\u90e8\\u5206\\uff0c\\u4e0e\\u672c\\u5408\\u540c\\u5177\\u6709\\u540c\\u7b49\\u6cd5\\u5f8b\\u6548\\u529b\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">3\\u3001\\u672c\\u5408\\u540c\\u672a\\u5c3d\\u4e8b\\u5b9c\\uff0c\\u7531\\u7532\\u4e59\\u53cc\\u65b9\\u534f\\u5546\\u540e\\u4ea7\\u751f\\u4e66\\u9762\\u6587\\u4ef6\\uff0c\\u4f5c\\u4e3a\\u672c\\u5408\\u540c\\u7684\\u8865\\u5145\\u6761\\u6b3e\\uff0c\\u5177\\u5907\\u4e0e\\u672c\\u5408\\u540c\\u540c\\u7b49\\u6cd5\\u5f8b\\u6548\\u529b\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">4\\u3001\\u5bf9\\u672c\\u5408\\u540c\\u5185\\u5bb9\\u7684\\u4efb\\u4f55\\u4fee\\u6539\\u548c\\u53d8\\u66f4\\u9700\\u8981\\uff0c\\u7528\\u4e66\\u9762\\u5f62\\u5f0f\\uff0c\\u5e76\\u7ecf\\u53cc\\u65b9\\u786e\\u8ba4\\u540e\\u751f\\u6548\\u3002<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">(\\u4ee5\\u4e0b\\u65e0\\u6b63\\u6587)<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\">&nbsp;<\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u7532\\u65b9\\uff08\\u7b7e\\u7ae0\\uff09&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \\u4e59\\u65b9\\uff08\\u7b7e\\u7ae0\\uff09<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u4ee3\\u8868\\u7b7e\\u5b57\\uff1a&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\\u4ee3\\u8868\\u7b7e\\u5b57\\uff1a<\\/span><\\/p>\\n<p style=\\\"line-height: 1.75;\\\"><span style=\\\"font-size: 14px; font-family: simsun, serif;\\\">\\u65e5\\u671f\\uff1a&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\\u65e5\\u671f\\uff1a<\\/span><\\/p>\"}', 1617868741, 1617868741);
INSERT INTO `5kcrm_admin_printing` VALUES (2, 1, '超级管理员', '合同订单打印模板', 6, '{\"data\":\"<p style=\\\"text-align: center;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">\\u5408\\u540c\\u8ba2\\u5355<\\/span><\\/p>\\n<p style=\\\"text-align: right;\\\">\\u5408\\u540c\\u7f16\\u53f7\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.num\\\">{\\u5408\\u540c\\u7f16\\u53f7}<\\/span><\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%; height: 95px;\\\" border=\\\"1\\\">\\n<tbody>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5408\\u540c\\u540d\\u79f0\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.name\\\">{\\u5408\\u540c\\u540d\\u79f0}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5ba2\\u6237\\u540d\\u79f0\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--customer\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"customer.name\\\">{\\u5ba2\\u6237\\u540d\\u79f0}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5408\\u540c\\u603b\\u91d1\\u989d\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.money\\\">{\\u5408\\u540c\\u91d1\\u989d}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u8d1f\\u8d23\\u4eba\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.owner_user_id\\\">{\\u8d1f\\u8d23\\u4eba}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u76f8\\u5173\\u5546\\u673a\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.business_id\\\">{\\u5546\\u673a\\u540d\\u79f0}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u7b7e\\u8ba2\\u65f6\\u95f4\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.order_date\\\">{\\u4e0b\\u5355\\u65f6\\u95f4}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5f00\\u59cb\\u65f6\\u95f4\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.start_time\\\">{\\u5408\\u540c\\u5f00\\u59cb\\u65f6\\u95f4}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u7ed3\\u675f\\u65f6\\u95f4\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.end_time\\\">{\\u5408\\u540c\\u5230\\u671f\\u65f6\\u95f4}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5907\\u6ce8\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--contract\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.remark\\\">{\\u5907\\u6ce8}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>\\u4ea7\\u54c1\\u660e\\u7ec6\\uff1a<\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%;\\\" border=\\\"1\\\" data-wk-table-tag=\\\"table\\\">\\n<tbody>\\n<tr data-wk-table-tr-tag=\\\"header\\\">\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u540d\\u79f0<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u7c7b\\u522b<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5355\\u4f4d<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6807\\u51c6\\u4ef7\\u683c<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u552e\\u4ef7<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6570\\u91cf<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6298\\u6263<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5408\\u8ba1<\\/td>\\n<\\/tr>\\n<tr data-wk-table-tr-tag=\\\"value\\\">\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.name\\\">{\\u4ea7\\u54c1\\u540d\\u79f0}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.category_id\\\">{\\u4ea7\\u54c1\\u7c7b\\u522b}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.unit\\\">{\\u5355\\u4f4d}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.price\\\">{\\u6807\\u51c6\\u4ef7\\u683c}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.sales_price\\\">{\\u552e\\u4ef7}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.count\\\">{\\u6570\\u91cf}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.discount\\\">{\\u6298\\u6263}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"true\\\" data-wk-table-value-tag=\\\"product.subtotal\\\">{\\u5408\\u8ba1}<\\/span><\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p style=\\\"text-align: right;\\\">\\u4ea7\\u54c1\\u603b\\u91d1\\u989d\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"contract.total_price\\\">{\\u4ea7\\u54c1\\u603b\\u91d1\\u989d}<\\/span><\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\"}', 1617869167, 1617869167);
INSERT INTO `5kcrm_admin_printing` VALUES (3, 1, '超级管理员', '商机打印模板', 5, '{\"data\":\"<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">***\\u6709\\u9650\\u516c\\u53f8<\\/span><\\/p>\\n<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">\\u5546\\u673a<\\/span><\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%;\\\" border=\\\"1\\\">\\n<tbody>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%;\\\">\\u5546\\u673a\\u540d\\u79f0\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.name\\\">{\\u5546\\u673a\\u540d\\u79f0}<\\/span><\\/td>\\n<td style=\\\"width: 50%;\\\">\\u5ba2\\u6237\\u540d\\u79f0\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--customer\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"customer.name\\\">{\\u5ba2\\u6237\\u540d\\u79f0}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%;\\\">\\u5546\\u673a\\u72b6\\u6001\\u7ec4\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.type_id\\\">{\\u5546\\u673a\\u72b6\\u6001\\u7ec4}<\\/span><\\/td>\\n<td style=\\\"width: 50%;\\\">\\u5546\\u673a\\u9636\\u6bb5\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.status_id\\\">{\\u5546\\u673a\\u9636\\u6bb5}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%;\\\">\\u9884\\u8ba1\\u6210\\u4ea4\\u65f6\\u95f4\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.deal_date\\\">{\\u9884\\u8ba1\\u6210\\u4ea4\\u65e5\\u671f}<\\/span><\\/td>\\n<td style=\\\"width: 50%;\\\">\\u5546\\u673a\\u91d1\\u989d\\uff08\\u5143\\uff09\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.money\\\">{\\u5546\\u673a\\u91d1\\u989d}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%;\\\">\\u8d1f\\u8d23\\u4eba\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--business\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.owner_user_id\\\">{\\u8d1f\\u8d23\\u4eba}<\\/span><\\/td>\\n<td style=\\\"width: 50%;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p>&nbsp;<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>\\u4ea7\\u54c1\\u660e\\u7ec6\\uff1a<\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%;\\\" border=\\\"1\\\" data-wk-table-tag=\\\"table\\\">\\n<tbody>\\n<tr data-wk-table-tr-tag=\\\"header\\\">\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u540d\\u79f0<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u4ea7\\u54c1\\u7c7b\\u522b<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5355\\u4f4d<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6807\\u51c6\\u4ef7\\u683c<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u552e\\u4ef7<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6570\\u91cf<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u6298\\u6263<\\/td>\\n<td data-wk-table-td-tag=\\\"name\\\">\\u5408\\u8ba1<\\/td>\\n<\\/tr>\\n<tr data-wk-table-tr-tag=\\\"value\\\">\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.name\\\">{\\u4ea7\\u54c1\\u540d\\u79f0}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.category_id\\\">{\\u4ea7\\u54c1\\u7c7b\\u522b}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.unit\\\">{\\u5355\\u4f4d}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.price\\\">{\\u6807\\u51c6\\u4ef7\\u683c}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.sales_price\\\">{\\u552e\\u4ef7}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.count\\\">{\\u6570\\u91cf}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.discount\\\">{\\u6298\\u6263}<\\/span><\\/td>\\n<td data-wk-table-td-tag=\\\"value\\\"><span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-table-value-tag=\\\"product.subtotal\\\">{\\u5408\\u8ba1}<\\/span><\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p>\\u6574\\u70b9\\u6298\\u6263\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.discount_rate\\\">{\\u6574\\u5355\\u6298\\u6263}<\\/span> &nbsp;&nbsp;&nbsp;&nbsp; \\u4ea7\\u54c1\\u603b\\u91d1\\u989d\\uff08\\u5143\\uff09\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--product\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"business.total_price\\\">{\\u4ea7\\u54c1\\u603b\\u91d1\\u989d}<\\/span><\\/p>\\n<p>&nbsp;<\\/p>\"}', 1617869397, 1617869397);
INSERT INTO `5kcrm_admin_printing` VALUES (4, 1, '超级管理员', '回款打印模板', 7, '{\"data\":\"<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">***\\u6709\\u9650\\u516c\\u53f8<\\/span><\\/p>\\n<p style=\\\"text-align: center; line-height: 1; margin-bottom: 15px;\\\"><span style=\\\"font-size: 36px; font-family: simsun, serif;\\\">\\u56de\\u6b3e\\u5355<\\/span><\\/p>\\n<table style=\\\"border-collapse: collapse; width: 100%; height: 95px;\\\" border=\\\"1\\\">\\n<tbody>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u5ba2\\u6237\\u540d\\u79f0\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.customer_id\\\">{\\u5ba2\\u6237\\u540d\\u79f0}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u56de\\u6b3e\\u7f16\\u53f7\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.number\\\">{\\u56de\\u6b3e\\u7f16\\u53f7}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u56de\\u6b3e\\u65e5\\u671f\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.return_time\\\">{\\u56de\\u6b3e\\u65e5\\u671f}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u56de\\u6b3e\\u65b9\\u5f0f\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.return_type\\\">{\\u56de\\u6b3e\\u65b9\\u5f0f}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u56de\\u6b3e\\u671f\\u6570\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.plan_id\\\">{\\u671f\\u6570}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u56de\\u6b3e\\u91d1\\u989d\\uff08\\u5143\\uff09\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"false\\\" data-wk-tag=\\\"receivables.money\\\">{\\u56de\\u6b3e\\u91d1\\u989d}<\\/span><\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\">\\u8d1f\\u8d23\\u4eba\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"receivables.owner_user_id\\\">{\\u8d1f\\u8d23\\u4eba}<\\/span><\\/td>\\n<td style=\\\"width: 50%; height: 19px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 25px;\\\">\\n<td style=\\\"width: 50%; height: 19px;\\\" colspan=\\\"2\\\">\\u5907\\u6ce8\\uff1a<span class=\\\"wk-print-tag-wukong wk-tiny-color--receivables\\\" contenteditable=\\\"true\\\" data-wk-tag=\\\"receivables.remark\\\">{\\u5907\\u6ce8}<\\/span><\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p>&nbsp;<\\/p>\"}', 1617869632, 1617869632);

-- ----------------------------
-- Table structure for 5kcrm_admin_printing_data
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_printing_data`;
CREATE TABLE `5kcrm_admin_printing_data`  (
  `data_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件key',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件内容',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：word、pdf',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '打印文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_printing_data
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_rule
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_rule`;
CREATE TABLE `5kcrm_admin_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `types` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0系统设置1工作台2客户管理3项目管理4人力资源5财务管理6商业智能(客戶)7商业智能(办公)',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '定义',
  `level` tinyint(5) NOT NULL DEFAULT 0 COMMENT '级别。1模块,2控制器,3操作',
  `pid` int(11) NULL DEFAULT 0 COMMENT '父id，默认0',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态，1启用，0禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 240 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_rule
-- ----------------------------
INSERT INTO `5kcrm_admin_rule` VALUES (1, 2, '全部', 'crm', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (2, 2, '线索管理', 'leads', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (3, 2, '新建', 'save', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (4, 2, '编辑', 'update', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (5, 2, '查看列表', 'index', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (6, 2, '查看详情', 'read', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (7, 2, '导入', 'excelImport', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (8, 2, '导出', 'excelExport', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (9, 2, '刪除', 'delete', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (10, 2, '客户管理', 'customer', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (11, 2, '新建', 'save', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (12, 2, '编辑', 'update', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (13, 2, '查看列表', 'index', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (14, 2, '查看详情', 'read', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (15, 2, '导入', 'excelImport', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (16, 2, '导出', 'excelExport', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (17, 2, '刪除', 'delete', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (18, 2, '转移', 'transfer', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (19, 2, '放入公海', 'putInPool', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (20, 2, '锁定/解锁', 'lock', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (21, 2, '编辑团队成员', 'teamSave', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (22, 2, '联系人管理', 'contacts', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (23, 2, '新建', 'save', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (24, 2, '编辑', 'update', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (25, 2, '查看列表', 'index', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (26, 2, '查看详情', 'read', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (27, 2, '刪除', 'delete', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (28, 2, '转移', 'transfer', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (34, 2, '商机管理', 'business', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (35, 2, '新建', 'save', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (36, 2, '编辑', 'update', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (37, 2, '查看列表', 'index', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (38, 2, '查看详情', 'read', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (39, 2, '刪除', 'delete', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (40, 2, '转移', 'transfer', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (41, 2, '编辑团队成员', 'teamSave', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (42, 2, '合同管理', 'contract', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (43, 2, '新建', 'save', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (44, 2, '编辑', 'update', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (45, 2, '查看列表', 'index', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (46, 2, '查看详情', 'read', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (47, 2, '刪除', 'delete', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (48, 2, '转移', 'transfer', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (49, 2, '编辑团队成员', 'teamSave', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (50, 2, '回款管理', 'receivables', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (51, 2, '新建', 'save', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (52, 2, '编辑', 'update', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (53, 2, '查看列表', 'index', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (54, 2, '查看详情', 'read', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (55, 2, '刪除', 'delete', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (56, 2, '产品管理', 'product', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (57, 2, '新建', 'save', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (58, 2, '编辑', 'update', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (59, 2, '查看列表', 'index', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (60, 2, '查看详情', 'read', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (61, 2, '上架/下架', 'status', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (62, 6, '商业智能', 'bi', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (63, 6, '员工客户分析', 'customer', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (64, 6, '查看', 'read', 3, 63, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (65, 6, '销售漏斗分析', 'business', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (66, 6, '查看', 'read', 3, 65, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (67, 6, '回款统计', 'receivables', 2, 62, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (68, 6, '查看', 'read', 3, 67, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (69, 6, '产品分析', 'product', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (70, 6, '查看', 'read', 3, 69, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (71, 6, '业绩目标完成情况', 'achievement', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (72, 6, '查看', 'read', 3, 71, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (73, 2, '转移', 'transfer', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (74, 2, '转化', 'transform', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (75, 6, '员工业绩分析', 'contract', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (76, 6, '查看', 'read', 3, 75, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (77, 6, '客户画像分析', 'portrait', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (78, 6, '查看', 'read', 3, 77, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (79, 6, '排行榜', 'ranking', 2, 62, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (80, 6, '查看', 'read', 3, 79, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (81, 2, '导入', 'excelImport', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (82, 2, '导出', 'excelExport', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (83, 2, '导入', 'excelImport', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (84, 2, '导出', 'excelExport', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (86, 3, '项目管理', 'work', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (87, 3, '项目', 'work', 2, 86, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (88, 3, '任务', 'task', 2, 86, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (89, 3, '项目设置', 'update', 3, 87, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (90, 3, '任务列表', 'taskClass', 2, 86, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (91, 3, '新建任务列表', 'save', 3, 90, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (92, 3, '编辑任务列表', 'update', 3, 90, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (93, 3, '删除任务列表', 'delete', 3, 90, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (94, 3, '创建', 'save', 3, 88, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (95, 7, '办公分析', 'oa', 2, 140, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (96, 7, '查看', 'read', 3, 95, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (104, 2, '成交状态', 'deal_status', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (105, 0, '全部', 'admin', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (106, 0, '企业首页', 'system', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (107, 0, '查看', 'index', 3, 106, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (108, 0, '编辑', 'save', 3, 106, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (109, 0, '应用管理', 'configset', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (110, 0, '查看', 'index', 3, 109, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (111, 0, '停用/启用', 'update', 3, 109, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (112, 0, '员工与部门管理', 'users', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (113, 0, '部门/员工查看', 'index', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (114, 0, '员工新建', 'save', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (115, 0, '员工禁用/激活', 'enables', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (116, 0, '员工操作', 'update', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (117, 0, '部门新建', 'structures_save', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (118, 0, '部门编辑', 'structures_update', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (119, 0, '部门删除', 'structures_delete', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (120, 0, '角色权限管理', 'groups', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (121, 0, '角色权限设置', 'update', 3, 120, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (122, 0, '工作台设置', 'oa', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (123, 0, '办公审批管理', 'examine', 3, 122, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (124, 0, '审批流程管理', 'examine_flow', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (125, 0, '审批流程管理', 'index', 3, 124, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (126, 0, '客户管理设置', 'crm', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (127, 0, '自定义字段设置', 'field', 3, 126, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (128, 0, '客户公海规则', 'pool', 3, 126, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (129, 0, '业务参数设置', 'setting', 3, 126, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (130, 0, '业绩目标设置', 'achievement', 3, 126, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (131, 1, '全部', 'oa', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (132, 1, '通讯录', 'addresslist', 2, 131, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (133, 1, '查看列表', 'index', 3, 132, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (134, 1, '公告', 'announcement', 2, 131, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (135, 1, '新建', 'save', 3, 134, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (136, 1, '编辑', 'update', 3, 134, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (137, 1, '删除', 'delete', 3, 134, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (138, 0, '项目管理设置', 'work', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (139, 0, '项目管理', 'work', 3, 138, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (140, 7, '商业智能', 'bi', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (141, 9, '全部', 'work', 1, 0, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (142, 9, '项目管理', 'work', 2, 141, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (143, 9, '项目创建', 'save', 3, 142, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (145, 2, '查看列表', 'index', 3, 144, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (146, 2, '导出', 'excelExport', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (147, 2, '导出', 'excelExport', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (148, 2, '合同作废', 'cancel', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (149, 2, '删除', 'delete', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (151, 0, '登录日志', 'loginLog', 3, 220, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (153, 2, '转移', 'transfer', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (154, 0, '其他设置', 'other_rule', 2, 105, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (155, 0, '日志欢迎语', 'welcome', 3, 154, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (156, 0, '设置欢迎语', 'setWelcome', 3, 154, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (157, 0, '日志规则', 'workLogRule', 3, 154, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (158, 0, '设置日志规则', 'setWorkLogRule', 3, 154, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (159, 0, '自定义打印模板', 'printing', 3, 126, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (160, 2, '关注', 'star', 3, 2, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (161, 2, '关注', 'star', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (162, 2, '关注', 'star', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (163, 2, '关注', 'star', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (164, 2, '附近客户', 'nearby', 3, 10, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (165, 2, '发票管理', 'invoice', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (166, 2, '列表', 'index', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (167, 2, '创建', 'save', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (168, 2, '详情', 'read', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (169, 2, '编辑', 'update', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (170, 2, '删除', 'delete', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (171, 2, '转移', 'transfer', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (172, 2, '开票', 'setInvoice', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (173, 2, '重置开票状态', 'resetInvoiceStatus', 3, 165, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (174, 2, '跟进记录', 'activity', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (175, 2, '列表', 'index', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (176, 2, '详情', 'read', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (177, 2, '创建', 'save', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (178, 2, '编辑', 'update', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (179, 2, '删除', 'delete', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (180, 3, '项目设置', 'setWork', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (181, 3, '项目导出', 'excelExport', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (182, 3, '新建任务列表', 'saveTaskClass', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (183, 3, '编辑任务列表', 'updateTaskClass', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (184, 3, '移动任务列表', 'updateClassOrder', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (185, 3, '删除任务列表', 'deleteTaskClass', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (186, 3, '新建任务', 'saveTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (187, 3, '完成任务', 'setTaskStatus', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (188, 3, '编辑任务标题', 'setTaskTitle', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (189, 3, '编辑任务描述', 'setTaskDescription', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (190, 3, '分配任务', 'setTaskMainUser', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (191, 3, '设置任务时间', 'setTaskTime', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (192, 3, '设置任务标签', 'setTaskLabel', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (193, 3, '添加任务参与人', 'setTaskOwnerUser', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (194, 3, '设置任务优先级', 'setTaskPriority', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (195, 3, '移动任务', 'setTaskOrder', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (196, 3, '归档任务', 'archiveTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (197, 3, '删除任务', 'deleteTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (198, 3, '彻底删除任务', 'cleanTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (199, 3, '任务添加附件', 'uploadTaskFile', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (200, 3, '任务删除附件', 'deleteTaskFile', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (201, 3, '项目导入', 'excelImport', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (202, 3, '新建子任务', 'addChildTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (203, 3, '编辑子任务', 'updateChildTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (204, 3, '删除子任务', 'deleteChildTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (205, 3, '恢复任务', 'restoreTask', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (206, 3, '关联业务', 'saveTaskRelation', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (207, 3, '完成子任务', 'setChildTaskStatus', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (208, 0, '初始化', 'initialize', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (209, 0, '初始化数据', 'update', 3, 208, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (210, 2, '打印', 'print', 3, 34, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (211, 2, '打印', 'print', 3, 42, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (212, 2, '打印', 'print', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (213, 2, '导出', 'excelexport', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (214, 2, '转移', 'transfer', 3, 56, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (215, 2, '回访管理', 'visit', 2, 1, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (216, 2, '新建', 'save', 3, 215, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (217, 2, '编辑', 'update', 3, 215, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (218, 2, '查看列表', 'index', 3, 215, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (219, 2, '查看详情', 'read', 3, 215, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (220, 0, '系统日志', 'adminLog', 2, 105, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (221, 0, '数据操作日志', 'actionRecord', 3, 220, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (222, 0, '系统操作日志', 'systemLog', 3, 220, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (223, 3, '管理参与人权限', 'manageTaskOwnerUser', 4, 86, 0);
INSERT INTO `5kcrm_admin_rule` VALUES (224, 2, '导入', 'excelImport', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (225, 2, '导出', 'excelExport', 3, 174, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (226, 2, '删除', 'delete', 3, 215, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (228, 0, '角色权限查看', 'ruleList', 3, 112, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (229, 2, '编辑团队成员', 'teamSave', 3, 50, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (230, 2, '编辑团队成员', 'teamSave', 3, 22, 1);
INSERT INTO `5kcrm_admin_rule` VALUES (231, 2, '导出', 'excelExport', 3, 165, 1);

-- ----------------------------
-- Table structure for 5kcrm_admin_scene
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_scene`;
CREATE TABLE `5kcrm_admin_scene`  (
  `scene_id` int(10) NOT NULL AUTO_INCREMENT,
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '场景名称',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `order_id` int(10) NOT NULL DEFAULT 1 COMMENT '排序ID',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '属性值',
  `is_hide` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1隐藏',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1系统0自定义',
  `bydata` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '系统参数',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`scene_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '场景' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_scene
-- ----------------------------
INSERT INTO `5kcrm_admin_scene` VALUES (1, 'crm_customer', '我负责的客户', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (3, 'crm_customer', '下属负责的客户', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (4, 'crm_customer', '全部客户', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (5, 'crm_leads', '我负责的线索', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (6, 'crm_leads', '下属的线索', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (7, 'crm_leads', '全部线索', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (8, 'crm_contacts', '我负责的联系人', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (9, 'crm_contacts', '下属负责的联系人', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (10, 'crm_contacts', '全部联系人', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (11, 'crm_business', '我负责的商机', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (13, 'crm_business', '下属负责的商机', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (14, 'crm_business', '全部商机', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (15, 'crm_contract', '我负责的合同', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (17, 'crm_contract', '下属负责的合同', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (18, 'crm_contract', '全部合同', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (19, 'crm_receivables', '我负责的回款', 0, 0, '', 0, 1, 'me', 1546272000, 1551515457);
INSERT INTO `5kcrm_admin_scene` VALUES (20, 'crm_receivables', '下属负责的回款', 0, 1, '', 0, 1, 'sub', 1546272000, 1551515457);
INSERT INTO `5kcrm_admin_scene` VALUES (21, 'crm_receivables', '全部回款', 0, 2, '', 0, 1, 'all', 1546272000, 1551515457);
INSERT INTO `5kcrm_admin_scene` VALUES (22, 'crm_product', '全部产品', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (23, 'crm_leads', '已转化线索', 0, 0, '', 0, 1, 'is_transform', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (24, 'crm_customer_pool', '今日进入公海的客户', 0, 0, '', 0, 1, 'pool', 1566748800, 1566748800);
INSERT INTO `5kcrm_admin_scene` VALUES (25, 'crm_business', '赢单商机', 0, 0, NULL, 0, 1, 'win_business', 1607072044, 1607072044);
INSERT INTO `5kcrm_admin_scene` VALUES (26, 'crm_business', '输单商机', 0, 0, NULL, 0, 1, 'fail_business', 1607072044, 1607072044);
INSERT INTO `5kcrm_admin_scene` VALUES (27, 'crm_leads', '我关注的线索', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES (28, 'crm_customer', '我关注的客户', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES (29, 'crm_contacts', '我关注的联系人', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES (30, 'crm_business', '我关注的商机', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES (31, 'crm_visit', '全部回访', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (32, 'crm_visit', '我负责的回访', 0, 0, '', 0, 1, 'me', 1546272000, 1551515457);
INSERT INTO `5kcrm_admin_scene` VALUES (33, 'crm_visit', '下属负责的回访', 0, 1, '', 0, 1, 'sub', 1546272000, 1551515457);
INSERT INTO `5kcrm_admin_scene` VALUES (34, 'crm_business', '进行中的商机', 0, 0, NULL, 0, 1, 'go_business', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (35, 'crm_invoice', '全部发票', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (36, 'crm_invoice', '我负责的发票', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (37, 'crm_invoice', '下属负责的发票', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` VALUES (38, 'crm_product', '上架的产品', 0, 0, NULL, 0, 1, 'put_on_shelves', 1623240292, 1623240292);
INSERT INTO `5kcrm_admin_scene` VALUES (39, 'crm_product', '下架的产品', 0, 0, NULL, 0, 1, 'pull_off_shelves', 1623240292, 1623240292);
-- ----------------------------
-- Table structure for 5kcrm_hrm_user_det
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_hrm_user_det`;
CREATE TABLE `5kcrm_hrm_user_det`  (
       `userdet_id` int(9) NOT NULL AUTO_INCREMENT,
       `user_id` int(11) NOT NULL COMMENT '员工id',
       `join_time` int(11) NOT NULL DEFAULT 0 COMMENT '入职时间',
       `type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '工作性质：1全职 2兼职 3实习',
       `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '用户类型：1非系统用户 2系统用户 3待离职 4离职 ',
       `userstatus` tinyint(2) NOT NULL DEFAULT 1 COMMENT '员工状态：1试用 2正式',
       `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
       `sex` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '性别',
       `age` int(3) NOT NULL DEFAULT 0 COMMENT '年龄',
       `job_num` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工号',
       `idtype` tinyint(2) NOT NULL DEFAULT 0 COMMENT '证件类型',
       `idnum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证件号码',
       `birth_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '出生日期',
       `nation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '民族',
       `internship` tinyint(2) NOT NULL DEFAULT 0 COMMENT '试用期（月）',
       `done_time` int(11) NOT NULL DEFAULT 0 COMMENT '转正时间',
       `parroll_id` int(11) NOT NULL DEFAULT 0 COMMENT '工资信息表ID',
       `create_time` int(11) NOT NULL COMMENT '添加时间',
       `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '编辑时间',
       `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
       `political` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '政治面貌',
       `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '户籍地址',
       `leave_time` int(11) NOT NULL DEFAULT 0 COMMENT '离职时间',
       PRIMARY KEY (`userdet_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工档案表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_hrm_user_det
-- ----------------------------
INSERT INTO `5kcrm_hrm_user_det` VALUES (1, 1, 1621234018, 1, 1, 2, '18888888888', '', 0, '', 0, '', '', '0', 0, 0, 0, 1621234018, 1621234018, '', '', '', 0);
