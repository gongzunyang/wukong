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
-- Table structure for 5kcrm_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_access`;
CREATE TABLE `5kcrm_admin_access`  (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_access
-- ----------------------------
INSERT INTO `5kcrm_admin_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for 5kcrm_admin_action_log
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_action_log`;
CREATE TABLE `5kcrm_admin_action_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '操作人ID',
  `module_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块',
  `controller_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `action_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `action_id` int(10) NOT NULL COMMENT '操作ID',
  `target_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被操作对象的名称',
  `action_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1为删除操作',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `create_time` int(11) NOT NULL COMMENT '操作时间',
  `join_user_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '抄送人IDs',
  `structure_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '抄送部门IDs',
  `client_ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_action_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_action_record`;
CREATE TABLE `5kcrm_admin_action_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `types` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `action_id` int(11) NOT NULL COMMENT '操作ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字段操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_action_record
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_comment
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_comment`;
CREATE TABLE `5kcrm_admin_comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论表',
  `user_id` int(11) NOT NULL COMMENT '评论人ID',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容(答案)',
  `reply_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回复内容（问题）',
  `create_time` int(11) NOT NULL COMMENT '新建时间',
  `isreply` tinyint(2) NULL DEFAULT 0 COMMENT '是否是回复 1 是 0 否',
  `reply_user_id` int(11) NOT NULL DEFAULT 0,
  `reply_id` int(11) NULL DEFAULT 0 COMMENT '回复对象ID',
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '状态 ',
  `type_id` int(11) NULL DEFAULT 0 COMMENT '评论项目任务ID 或评论其他模块ID',
  `favour` int(7) NULL DEFAULT 0 COMMENT '赞',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类 ',
  `reply_fid` int(11) NOT NULL DEFAULT 0 COMMENT '回复最上级ID',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_comment
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_config
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_config`;
CREATE TABLE `5kcrm_admin_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名字',
  `status` tinyint(2) NOT NULL COMMENT '状态',
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模型',
  `controller` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控制器',
  `type` tinyint(2) NOT NULL COMMENT '类型：1已发布，2未发布，3增值',
  `pid` tinyint(4) NOT NULL COMMENT '父级ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_config
-- ----------------------------
INSERT INTO `5kcrm_admin_config` VALUES (1, '任务审批', 1, 'taskExamine', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (2, '客户管理', 1, 'crm', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (3, '项目管理', 1, 'work', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (4, '人力资源管理', 1, 'hrm', '', 2, 0);
INSERT INTO `5kcrm_admin_config` VALUES (5, '进销存管理', 1, 'jxc', '', 2, 0);
INSERT INTO `5kcrm_admin_config` VALUES (6, '呼叫中心功能', 1, 'call', '', 3, 0);
INSERT INTO `5kcrm_admin_config` VALUES (7, '日志', 1, 'log', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (8, '通讯录', 1, 'book', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (9, '日历', 1, 'calendar', '', 1, 0);
INSERT INTO `5kcrm_admin_config` VALUES (10, '邮箱', 1, 'email', '', 2, 0);
INSERT INTO `5kcrm_admin_config` VALUES (11, '知识库', 1, 'knowledge', '', 2, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_examine_flow
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_examine_flow`;
CREATE TABLE `5kcrm_admin_examine_flow`  (
  `flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审批流名称',
  `config` tinyint(4) NOT NULL COMMENT '1固定审批0授权审批',
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联对象',
  `types_id` tinyint(4) NOT NULL DEFAULT 0 COMMENT '对象ID（如审批类型ID）',
  `structure_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门ID（0为全部）',
  `user_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '员工ID',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流程说明',
  `update_user_id` int(11) NOT NULL COMMENT '修改人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态 1启用，0禁用',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态 1删除',
  `delete_time` int(11) NOT NULL DEFAULT 0 COMMENT '删除时间',
  `delete_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '删除人ID',
  PRIMARY KEY (`flow_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批流程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_examine_flow
-- ----------------------------
INSERT INTO `5kcrm_admin_examine_flow` VALUES (1, '普通审批流程', 0, 'oa_examine', 1, '', '', '', 1, 1548835446, 1548835446, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (2, '请假审批流程', 0, 'oa_examine', 2, '', '', '', 1, 1548835717, 1548835717, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (3, '出差审批流程', 0, 'oa_examine', 3, '', '', '', 1, 1549959653, 1549959653, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (4, '加班审批流程', 0, 'oa_examine', 4, '', '', '', 1, 1549959653, 1549959653, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (5, '差旅审批流程', 0, 'oa_examine', 5, '', '', '', 1, 1549959653, 1549959653, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (6, '借款审批流程', 0, 'oa_examine', 6, '', '', '', 1, 1549959653, 1549959653, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (10, '发票审批流程', 0, 'crm_invoice', 0, '', '', '', 1, 1620610740, 1620610740, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (11, '合同审批流程', 0, 'crm_contract', 0, '', '', '', 1, 1620610745, 1620610745, 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_examine_flow` VALUES (12, '回款审批流程', 0, 'crm_receivables', 0, '', '', '', 1, 1620610748, 1620610748, 1, 0, 0, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_examine_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_examine_record`;
CREATE TABLE `5kcrm_admin_examine_record`  (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `types_id` int(11) NOT NULL DEFAULT 0 COMMENT '类型ID',
  `flow_id` int(11) NOT NULL DEFAULT 0 COMMENT '审批流程ID',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT '审批排序ID',
  `check_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '审批人ID',
  `check_time` int(11) NOT NULL COMMENT '审批时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1审核通过0审核失败2撤销',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审核意见',
  `is_end` tinyint(1) NOT NULL DEFAULT 0 COMMENT '审批失效（1标记为无效）',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_examine_record
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_examine_step
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_examine_step`;
CREATE TABLE `5kcrm_admin_examine_step`  (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_id` int(11) NOT NULL COMMENT '审批流程ID',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1负责人主管，2指定用户（任意一人），3指定用户（多人会签），4上一级审批人主管',
  `user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审批人ID (使用逗号隔开) ,1,2,',
  `order_id` tinyint(4) NOT NULL DEFAULT 1 COMMENT '排序ID',
  `relation` tinyint(1) NOT NULL DEFAULT 1 COMMENT '审批流程关系（1并2或）',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`step_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批步骤表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_examine_step
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_field
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_field`;
CREATE TABLE `5kcrm_admin_field`  (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类',
  `types_id` int(11) NOT NULL DEFAULT 0 COMMENT '分类ID（审批等）',
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
  `operating` int(10) NOT NULL DEFAULT 0 COMMENT '0改删，1改，2删，3无',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `type` int(2) NOT NULL DEFAULT 0 COMMENT '薪资管理 1固定 2增加 3减少',
  `relevant` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关字段名',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否隐藏：1隐藏；0不隐藏',
  `style_percent` tinyint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '字段宽度百分比：25、50、75、100',
  `form_position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '坐标，第一个数字表示坐标x，第二个数字表示坐标y',
  `precisions` tinyint(4) UNSIGNED NULL DEFAULT NULL COMMENT '1、小数的精度，允许的最大小数位数，默认为null，表示不启用小数。2、也包含其他数据选项，如：明细表格的显示方式',
  `max_num_restrict` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数字类字段的最大数，所填写的数字不能大于这个字段的值，默认为null',
  `min_num_restrict` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数字类字段的最小数，所填写的数字不能小于这个字段的值，默认为null',
  `remark` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段说明',
  `options` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '如果类型是选项，此处不能为空，多个选项以，隔开，此处的数据是用于控制其他字段是否显示的逻辑表单',
  `formAssistId` int(10) NULL DEFAULT NULL COMMENT '逻辑表单相关，由前端生成',
  PRIMARY KEY (`field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 950 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义字段表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_field
-- ----------------------------
INSERT INTO `5kcrm_admin_field` VALUES (1, '', 0, 'create_user_id', '创建人', 'user', '', 0, 0, 0, '', '', 99, 0, 1553788800, 1553788800, 0, NULL, 0, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (2, '', 0, 'update_time', '更新时间', 'datetime', '', 0, 0, 0, '', '', 100, 0, 1553788800, 1553788800, 0, NULL, 0, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (3, '', 0, 'create_time', '创建时间', 'datetime', '', 0, 0, 0, '', '', 101, 0, 1553788800, 1553788800, 0, NULL, 0, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (4, '', 0, 'owner_user_id', '负责人', 'user', '', 0, 0, 0, '', '', 102, 0, 1553788800, 1553788800, 0, NULL, 0, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (5, 'crm_leads', 0, 'name', '线索名称', 'text', '', 0, 1, 1, '', '', 1, 189, 1553788800, 1624438964, 1, '', 0, 100, '0,0', 0, '', '', '', '', 0);
INSERT INTO `5kcrm_admin_field` VALUES (6, 'crm_leads', 0, 'source', '线索来源', 'select', '', 0, 0, 0, '', '促销活动\n搜索引擎\n广告\n转介绍\n线上注册\n线上询价\n预约上门\n陌拜\n招商资源\n公司资源\n展会资源\n个人资源\n电话咨询\n邮件咨询', 4, 191, 1553788800, 1624438964, 3, '', 0, 50, '2,0', 2, '', '', '', '促销活动,搜索引擎,广告,转介绍,线上注册,线上询价,预约上门,陌拜,招商资源,公司资源,展会资源,个人资源,电话咨询,邮件咨询', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (7, 'crm_leads', 0, 'telephone', '电话', 'text', '', 0, 0, 0, '', '', 6, 191, 1553788800, 1624438964, 1, '', 0, 50, '3,0', 0, '', '', '', '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (8, 'crm_leads', 0, 'mobile', '手机', 'mobile', '', 0, 1, 0, '', '', 7, 191, 1553788800, 1624438964, 7, '', 0, 50, '3,1', 0, '', '', '', '', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (9, 'crm_leads', 0, 'industry', '客户行业', 'select', '', 0, 0, 0, '', 'IT/通信/电子/互联网\n金融业\n房地产\n商业服务\n贸易\n生产\n运输/物流\n服务业\n文化传媒\n政府', 2, 191, 1553788800, 1624438964, 3, '', 0, 50, '1,0', 2, '', '', 'options_type', '{\"IT/通信/电子/互联网\":[],\"金融业\":[],\"房地产\":[],\"商业服务\":[],\"贸易\":[],\"生产\":[],\"运输/物流\":[],\"服务业\":[],\"文化传媒\":[],\"政府\":[]}', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (10, 'crm_leads', 0, 'level', '客户级别', 'select', '', 0, 0, 0, '', 'A（重点客户）\nB（普通客户）\nC（非优先客户）\n其他', 3, 191, 1553788800, 1624438964, 3, '', 0, 50, '1,1', 2, '', '', '', 'A（重点客户）,B（普通客户）,C（非优先客户）,其他', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (11, 'crm_leads', 0, 'detail_address', '地址', 'text', '', 0, 0, 0, '', '', 9, 191, 1553788800, 1624438964, 1, '', 0, 50, '4,1', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (12, 'crm_leads', 0, 'next_time', '下次联系时间', 'datetime', '', 0, 0, 0, '', '', 5, 63, 1553788800, 1624438964, 13, '', 0, 50, '2,1', 0, '', '', '', '', 1008);
INSERT INTO `5kcrm_admin_field` VALUES (13, 'crm_leads', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 10, 191, 1553788800, 1624438964, 2, '', 0, 100, '5,0', 0, '', '', '', '', 1009);
INSERT INTO `5kcrm_admin_field` VALUES (14, 'crm_customer', 0, 'name', '客户名称', 'text', '', 0, 1, 1, '', '', 1, 189, 1553788800, 1624439031, 1, '', 0, 50, '0,0', 0, '', '', '', '', 0);
INSERT INTO `5kcrm_admin_field` VALUES (15, 'crm_customer', 0, 'level', '客户级别', 'select', '', 0, 0, 0, '', 'A（重点客户）\nB（普通客户）\nC（非优先客户）', 3, 191, 1553788800, 1624439032, 3, '', 0, 50, '1,0', 2, '', '', '', 'A（重点客户）,B（普通客户）,C（非优先客户）', 0);
INSERT INTO `5kcrm_admin_field` VALUES (16, 'crm_customer', 0, 'industry', '客户行业', 'select', '', 0, 0, 0, '', 'IT/通信/电子/互联网\n金融业\n房地产\n商业服务\n贸易\n生产\n运输/物流\n服务业\n文化传媒\n政府', 2, 191, 1553788800, 1624439031, 3, '', 0, 50, '0,1', 2, '', '', '', 'IT/通信/电子/互联网,金融业,房地产,商业服务,贸易,生产,运输/物流,服务业,文化传媒,政府', 1025);
INSERT INTO `5kcrm_admin_field` VALUES (17, 'crm_customer', 0, 'source', '客户来源', 'select', '', 0, 0, 0, '', '促销活动\n搜索引擎\n广告\n转介绍\n线上注册\n线上询价\n预约上门\n陌拜\n招商资源\n公司资源\n展会资源\n个人资源\n电话咨询\n邮件咨询', 4, 191, 1553788800, 1624439032, 3, '', 0, 50, '1,1', 2, '', '', '', '促销活动,搜索引擎,广告,转介绍,线上注册,线上询价,预约上门,陌拜,招商资源,公司资源,展会资源,个人资源,电话咨询,邮件咨询', 1026);
INSERT INTO `5kcrm_admin_field` VALUES (18, 'crm_customer', 0, 'deal_status', '成交状态', 'select', '未成交', 0, 0, 1, '', '未成交\n已成交', 0, 191, 1553788800, 1553788800, 0, NULL, 0, 100, '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (19, 'crm_customer', 0, 'telephone', '电话', 'text', '', 0, 0, 0, '', '', 5, 191, 1553788800, 1624439032, 1, '', 0, 50, '2,0', 0, '', '', '', '', 1027);
INSERT INTO `5kcrm_admin_field` VALUES (20, 'crm_customer', 0, 'website', '网址', 'text', '', 0, 0, 0, '', '', 8, 191, 1553788800, 1624439032, 1, '', 0, 50, '3,1', 0, '', '', '', '', 1028);
INSERT INTO `5kcrm_admin_field` VALUES (21, 'crm_customer', 0, 'next_time', '下次联系时间', 'datetime', '', 0, 0, 0, '', '', 9, 63, 1553788800, 1624439032, 13, '', 0, 50, '4,0', 0, '', '', '', '', 1029);
INSERT INTO `5kcrm_admin_field` VALUES (22, 'crm_customer', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 10, 191, 1553788800, 1624439032, 2, '', 0, 50, '4,1', 0, '', '', '', '', 1030);
INSERT INTO `5kcrm_admin_field` VALUES (23, 'crm_contacts', 0, 'name', '姓名', 'text', '', 0, 1, 1, '', '', 1, 181, 1553788800, 1624439123, 1, '', 0, 50, '0,0', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (24, 'crm_contacts', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 2, 191, 1553788800, 1624439123, 15, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (25, 'crm_contacts', 0, 'mobile', '手机', 'mobile', '', 0, 0, 0, '', '', 3, 191, 1553788800, 1624439123, 7, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (26, 'crm_contacts', 0, 'telephone', '电话', 'text', '', 0, 0, 0, '', '', 4, 191, 1553788800, 1624439123, 1, '', 0, 50, '1,1', 0, '', '', '', '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (27, 'crm_contacts', 0, 'email', '电子邮箱', 'email', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439123, 14, '', 0, 50, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (28, 'crm_contacts', 0, 'decision', '是否关键决策人', 'select', '', 0, 0, 0, '', '是\n否', 5, 190, 1553788800, 1624439123, 3, '', 0, 50, '2,0', 2, '', '', '', '\"\"', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (29, 'crm_contacts', 0, 'post', '职务', 'text', '', 0, 0, 0, '', '', 6, 191, 1553788800, 1624439123, 1, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (30, 'crm_contacts', 0, 'sex', '性别', 'select', '', 0, 0, 0, '', '男\n女', 9, 191, 1553788800, 1624439123, 3, '', 0, 50, '4,0', 2, '', '', '', '\"\"', 1009);
INSERT INTO `5kcrm_admin_field` VALUES (31, 'crm_contacts', 0, 'detail_address', '地址', 'text', '', 0, 0, 0, '', '', 8, 191, 1553788800, 1624439123, 1, '', 0, 50, '3,1', 0, '', '', '', '', 1008);
INSERT INTO `5kcrm_admin_field` VALUES (32, 'crm_contacts', 0, 'next_time', '下次联系时间', 'datetime', '', 0, 0, 0, '', '', 10, 191, 1553788800, 1624439123, 13, '', 0, 50, '4,1', 0, '', '', '', '', 1010);
INSERT INTO `5kcrm_admin_field` VALUES (33, 'crm_contacts', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 11, 191, 1553788800, 1624439123, 2, '', 0, 100, '5,0', 0, '', '', '', '', 1011);
INSERT INTO `5kcrm_admin_field` VALUES (34, 'crm_business', 0, 'name', '商机名称', 'text', '', 0, 0, 1, '', '', 1, 181, 1553788800, 1624439203, 1, '', 0, 50, '0,0', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (35, 'crm_business', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 2, 181, 1553788800, 1624439203, 15, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (36, 'crm_business', 0, 'type_id', '商机状态组', 'business_type', '', 0, 0, 1, '', '', 3, 19, 1553788800, 1624439203, 0, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (37, 'crm_business', 0, 'status_id', '商机阶段', 'business_status', '', 0, 0, 1, '', '', 4, 19, 1553788800, 1624439203, 0, '', 0, 50, '1,1', 0, '', '', '', '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (38, 'crm_business', 0, 'money', '商机金额', 'floatnumber', '', 0, 0, 0, '元', '', 5, 189, 1553788800, 1624439203, 6, '', 0, 50, '2,0', 0, '', '', '', '', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (39, 'crm_business', 0, 'deal_date', '预计成交日期', 'date', '', 0, 0, 1, '', '', 6, 191, 1553788800, 1624439203, 4, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (40, 'crm_business', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439203, 2, '', 0, 100, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (41, 'crm_contract', 0, 'num', '合同编号', 'text', '', 0, 1, 1, '', '', 1, 177, 1553788800, 1624439278, 1, '', 0, 50, '0,0', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (42, 'crm_contract', 0, 'name', '合同名称', 'text', '', 0, 0, 1, '', '', 2, 191, 1553788800, 1624439278, 1, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (43, 'crm_contract', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 3, 149, 1553788800, 1624439278, 15, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (44, 'crm_contract', 0, 'business_id', '商机名称', 'business', '', 0, 0, 0, '', '', 4, 159, 1553788800, 1624439278, 16, '', 0, 50, '1,1', 0, '', '', '', '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (45, 'crm_contract', 0, 'order_date', '下单时间', 'date', '', 0, 0, 0, '', '', 5, 181, 1553788800, 1624439278, 4, '', 0, 50, '2,0', 0, '', '', '', '', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (46, 'crm_contract', 0, 'money', '合同金额', 'floatnumber', '', 0, 0, 1, '元', '', 6, 189, 1553788800, 1624439278, 6, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (47, 'crm_contract', 0, 'start_time', '合同开始时间', 'date', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439278, 4, '', 0, 50, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (48, 'crm_contract', 0, 'end_time', '合同到期时间', 'date', '', 0, 0, 0, '', '', 8, 191, 1553788800, 1624439278, 4, '', 0, 50, '3,1', 0, '', '', '', '', 1008);
INSERT INTO `5kcrm_admin_field` VALUES (49, 'crm_contract', 0, 'contacts_id', '客户签约人', 'contacts', '', 0, 0, 0, '', '', 9, 159, 1553788800, 1624439279, 17, '', 0, 50, '4,0', 0, '', '', '', '', 1009);
INSERT INTO `5kcrm_admin_field` VALUES (50, 'crm_contract', 0, 'order_user_id', '公司签约人', 'user', '', 0, 0, 0, '', '', 10, 159, 1553788800, 1624439279, 10, '', 0, 50, '4,1', 0, '', '', '', '', 1010);
INSERT INTO `5kcrm_admin_field` VALUES (51, 'crm_contract', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 11, 191, 1553788800, 1624439279, 2, '', 0, 100, '5,0', 0, '', '', '', '', 1011);
INSERT INTO `5kcrm_admin_field` VALUES (52, 'crm_receivables', 0, 'number', '回款编号', 'text', '', 0, 1, 1, '', '', 1, 177, 1553788800, 1624439355, 1, '', 0, 50, '0,0', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (53, 'crm_receivables', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 2, 153, 1553788800, 1624439355, 15, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (54, 'crm_receivables', 0, 'contract_id', '合同编号', 'contract', '', 0, 0, 1, '', '', 3, 159, 1553788800, 1624439355, 20, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (55, 'crm_receivables', 0, 'return_time', '回款日期', 'date', '', 0, 0, 1, '', '', 4, 181, 1553788800, 1624439355, 4, '', 0, 50, '1,1', 0, '', '', '', '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (56, 'crm_receivables', 0, 'return_type', '回款方式', 'select', '', 0, 0, 1, '', '支票\n现金\n邮政汇款\n电汇\n网上转账\n支付宝\n微信支付\n其他', 5, 191, 1553788800, 1624439355, 3, '', 0, 50, '2,0', 2, '', '', '', '\"\"', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (57, 'crm_receivables', 0, 'money', '回款金额', 'floatnumber', '', 0, 0, 1, '元', '', 6, 181, 1553788800, 1624439355, 6, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (58, 'crm_receivables', 0, 'plan_id', '期数', 'receivables_plan', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439355, 21, '', 0, 50, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (59, 'crm_receivables', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 8, 191, 1553788800, 1624439355, 2, '', 0, 50, '3,1', 0, '', '', '', '', 1008);
INSERT INTO `5kcrm_admin_field` VALUES (60, 'crm_product', 0, 'name', '产品名称', 'text', '', 0, 0, 1, '', '', 1, 177, 1553788800, 1624440436, 1, '', 0, 50, '0,0', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (61, 'crm_product', 0, 'category_id', '产品类别', 'category', '', 0, 0, 1, '', '', 2, 191, 1553788800, 1624440436, 19, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (62, 'crm_product', 0, 'num', '产品编码', 'text', '', 0, 0, 1, '', '', 3, 191, 1553788800, 1624440436, 1, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (63, 'crm_product', 0, 'status', '是否上架', 'select', '上架', 0, 0, 1, '', '上架\n下架', 4, 144, 1553788800, 1624440436, 3, '', 0, 50, '1,1', 2, '', '', '', '\"\"', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (64, 'crm_product', 0, 'unit', '单位', 'select', '', 0, 0, 1, '', '个\n块\n只\n把\n枚\n瓶\n盒\n台\n吨\n千克\n米\n箱', 5, 191, 1553788800, 1624440436, 3, '', 0, 50, '2,0', 2, '', '', '', '\"\"', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (65, 'crm_product', 0, 'price', '标准价格', 'floatnumber', '', 0, 0, 1, '元', '', 6, 181, 1553788800, 1624440436, 6, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (66, 'crm_product', 0, 'description', '产品描述', 'text', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624440436, 1, '', 0, 100, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (67, 'oa_examine', 1, 'content', '审批内容', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (68, 'oa_examine', 1, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (69, 'oa_examine', 2, 'type_id', '请假类型', 'select', '', 0, 0, 1, '', '年假\n事假\n病假\n产假\n调休\n婚假\n丧假\n其他', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (70, 'oa_examine', 2, 'content', '审批内容', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (71, 'oa_examine', 2, 'start_time', '开始时间', 'datetime', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (72, 'oa_examine', 2, 'end_time', '结束时间', 'datetime', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (73, 'oa_examine', 2, 'duration', '时长(天)', 'floatnumber', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (74, 'oa_examine', 2, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (75, 'oa_examine', 3, 'content', '出差事由', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (76, 'oa_examine', 3, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '1,0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (77, 'oa_examine', 3, 'cause', '行程明细', 'business_cause', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '2,0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (78, 'oa_examine', 3, 'duration', '出差总天数', 'floatnumber', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '3,0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (79, 'oa_examine', 4, 'content', '加班原因', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (80, 'oa_examine', 4, 'start_time', '开始时间', 'datetime', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (81, 'oa_examine', 4, 'end_time', '结束时间', 'datetime', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (82, 'oa_examine', 4, 'duration', '加班总天数', 'floatnumber', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (83, 'oa_examine', 4, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (84, 'oa_examine', 5, 'content', '差旅事由', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (85, 'oa_examine', 5, 'cause', '费用明细', 'examine_cause', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (86, 'oa_examine', 5, 'money', '报销总金额', 'floatnumber', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (87, 'oa_examine', 5, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (88, 'oa_examine', 6, 'content', '借款事由', 'text', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (89, 'oa_examine', 6, 'money', '借款金额（元）', 'floatnumber', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (90, 'oa_examine', 6, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '0,3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `5kcrm_admin_field` VALUES (91, 'crm_receivables_plan', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 1, 181, 1553788800, 1624439466, 0, NULL, 0, 50, '0,0', NULL, NULL, NULL, NULL, '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (92, 'crm_receivables_plan', 0, 'contract_id', '合同编号', 'contract', '', 0, 0, 1, '', '', 2, 181, 1553788800, 1624439466, 0, NULL, 0, 50, '0,1', NULL, NULL, NULL, NULL, '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (93, 'crm_receivables_plan', 0, 'money', '计划回款金额', 'floatnumber', '', 0, 0, 1, '', '', 3, 181, 1553788800, 1624439466, 6, NULL, 0, 50, '1,0', NULL, NULL, NULL, NULL, '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (94, 'crm_receivables_plan', 0, 'return_date', '计划回款日期', 'date', '', 0, 0, 1, '', '', 4, 183, 1553788800, 1624439466, 4, NULL, 0, 50, '1,1', NULL, NULL, NULL, NULL, '', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (95, 'crm_receivables_plan', 0, 'return_type', '计划回款方式', 'select', '', 0, 0, 1, '', '支票\n现金\n邮政汇款\n电汇\n网上转账\n支付宝\n微信支付\n其他\n在线支付\n线下支付\n预存款\n返利\n预存款+返利', 5, 191, 1553788800, 1624439466, 3, NULL, 0, 50, '2,0', 2, NULL, NULL, NULL, '支票\n现金\n邮政汇款\n电汇\n网上转账\n支付宝\n微信支付\n其他\n在线支付\n线下支付\n预存款\n返利\n预存款+返利', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (96, 'crm_receivables_plan', 0, 'remind', '提前几日提醒', 'number', '', 0, 0, 0, '', '', 6, 191, 1553788800, 1624439466, 5, NULL, 0, 50, '2,1', NULL, NULL, NULL, NULL, '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (97, 'crm_receivables_plan', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439466, 2, NULL, 0, 100, '3,0', NULL, NULL, NULL, NULL, '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (99, 'crm_customer', 0, 'mobile', '手机', 'mobile', '', 0, 0, 0, '', '', 6, 191, 1553788800, 1624439032, 7, '', 0, 50, '2,1', 0, '', '', '', '', 1031);
INSERT INTO `5kcrm_admin_field` VALUES (100, 'crm_customer', 0, 'email', '邮箱', 'email', '', 0, 0, 0, '', '', 7, 191, 1553788800, 1624439032, 14, '', 0, 50, '3,0', 0, '', '', '', '', 1032);
INSERT INTO `5kcrm_admin_field` VALUES (101, 'crm_visit', 0, 'number', '回访编号', 'text', '', 0, 0, 1, '', NULL, 1, 177, 1553788800, 1624439600, 1, '', 0, 50, '0,0', 0, '', '', '', NULL, 1001);
INSERT INTO `5kcrm_admin_field` VALUES (102, 'crm_visit', 0, 'visit_time', '回访时间', 'date', '', 0, 0, 1, '', '', 2, 181, 1553788800, 1624439600, 4, '', 0, 50, '0,1', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (103, 'crm_visit', 0, 'owner_user_id', '回访人', 'single_user', '', 0, 0, 1, '', '', 3, 149, 1553788800, 1624439600, 28, '', 0, 50, '1,0', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (104, 'crm_visit', 0, 'shape', '回访形式', 'select', '', 0, 0, 0, '', '见面拜访\r\n电话\r\n短信\r\n邮件\r\n微信', 4, 191, 1553788800, 1624439600, 3, '', 0, 50, '1,1', 2, '', '', '', '\"\"', 1004);
INSERT INTO `5kcrm_admin_field` VALUES (105, 'crm_visit', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 5, 149, 1553788800, 1624439600, 15, '', 0, 50, '2,0', 0, '', '', '', '', 1005);
INSERT INTO `5kcrm_admin_field` VALUES (106, 'crm_visit', 0, 'contacts_id', '联系人', 'contacts', '', 0, 0, 0, '', '', 6, 159, 1553788800, 1624439600, 17, '', 0, 50, '2,1', 0, '', '', '', '', 1006);
INSERT INTO `5kcrm_admin_field` VALUES (107, 'crm_visit', 0, 'contract_id', '合同编号', 'contract', '', 0, 0, 1, '', '', 7, 159, 1553788800, 1624439600, 20, '', 0, 50, '3,0', 0, '', '', '', '', 1007);
INSERT INTO `5kcrm_admin_field` VALUES (108, 'crm_visit', 0, 'satisfaction', '客户满意度', 'select', '', 0, 0, 0, '', '很满意\r\n满意\r\n一般\r\n不满意\r\n很不满意', 8, 191, 1553788800, 1624439600, 3, '', 0, 50, '3,1', 2, '', '', '', '\"\"', 1008);
INSERT INTO `5kcrm_admin_field` VALUES (109, 'crm_visit', 0, 'feedback', '客户反馈', 'textarea', '', 0, 0, 0, '', '', 9, 191, 1553788800, 1624439600, 2, '', 0, 100, '4,0', 0, '', '', '', '', 1009);
INSERT INTO `5kcrm_admin_field` VALUES (110, 'crm_leads', 0, 'email', '电子邮箱', 'email', '', 0, 0, 0, '', NULL, 8, 191, 1616464748, 1624438964, 14, '', 0, 50, '4,0', 0, '', '', '', NULL, 1006);
INSERT INTO `5kcrm_admin_field` VALUES (111, 'crm_invoice', 0, 'invoice_apple_number', '发票申请编号', 'text', '', 0, 0, 0, '', '', 1, 177, 1553788800, 1624439529, 1, '', 0, 50, '0,0', 0, '', '', '', '', 0);
INSERT INTO `5kcrm_admin_field` VALUES (112, 'crm_invoice', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 2, 149, 1553788800, 1624439529, 0, '', 0, 50, '0,1', 0, '', '', '', '', 1001);
INSERT INTO `5kcrm_admin_field` VALUES (113, 'crm_invoice', 0, 'contract_id', '合同编号', 'contract', '', 0, 0, 1, '', '', 3, 149, 1553788800, 1624439529, 0, '', 0, 50, '1,0', 0, '', '', '', '', 1002);
INSERT INTO `5kcrm_admin_field` VALUES (114, 'crm_invoice', 0, 'contract_money', '合同金额', 'floatnumber', '', 0, 0, 1, '元', '', 4, 145, 1553788800, 1624439529, 6, '', 0, 50, '1,1', 0, '', '', '', '', 1003);
INSERT INTO `5kcrm_admin_field` VALUES (115, 'crm_invoice', 0, 'invoice_date', '开票日期', 'date', '', 0, 0, 0, '', '', 5, 191, 1553788800, 1624439529, 4, '', 0, 50, '2,0', 0, '', '', '', '', 0);
INSERT INTO `5kcrm_admin_field` VALUES (116, 'crm_invoice', 0, 'invoice_money', '开票金额', 'floatnumber', '', 0, 0, 1, '元', '', 6, 149, 1553788800, 1624439529, 6, '', 0, 50, '2,1', 0, '', '', '', '', 0);
INSERT INTO `5kcrm_admin_field` VALUES (117, 'crm_invoice', 0, 'invoice_type', '开票类型', 'select', '', 0, 0, 1, '', '增值税专用发票\n增值税普通发票\n国税通用机打发票\n地税通用机打发票\n收据', 7, 159, 1553788800, 1624439529, 3, '', 0, 50, '3,0', 2, '', '', '', '增值税专用发票\n增值税普通发票\n国税通用机打发票\n地税通用机打发票\n收据', 0);
INSERT INTO `5kcrm_admin_field` VALUES (118, 'crm_invoice', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', NULL, 8, 191, 1620874670, 1624439529, 2, '', 0, 50, '3,1', 0, '', '', '', NULL, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_field_extend
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_field_extend`;
CREATE TABLE `5kcrm_admin_field_extend`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块：crm_leads、crm_customer、crm_contacts、crm_business、crm_contract、crm_receivables、crm_product、crm_receivables_plan、crm_visit、oa_examine',
  `field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名称',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细内容',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '生成时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `field_types`(`field`, `types`) USING BTREE,
  UNIQUE INDEX `field`(`field`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义字段扩展表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_field_extend
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_field_grant
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_field_grant`;
CREATE TABLE `5kcrm_admin_field_grant`  (
  `grant_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `module` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块：crm、oa、bi等',
  `column` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栏目：leads、customer、contacts等',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '授权内容',
  `update_time` int(10) NOT NULL COMMENT '修改日期',
  `create_time` int(10) NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`grant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限管理-字段授权' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_field_grant
-- ----------------------------
INSERT INTO `5kcrm_admin_field_grant` VALUES (1, 10, 'crm', 'leads', 'a:16:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"线索名称\";}i:1;a:7:{s:5:\"field\";s:5:\"email\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"邮箱\";}i:2;a:7:{s:5:\"field\";s:6:\"source\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"线索来源\";}i:3;a:7:{s:5:\"field\";s:6:\"mobile\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"手机\";}i:4;a:7:{s:5:\"field\";s:9:\"telephone\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"电话\";}i:5;a:7:{s:5:\"field\";s:14:\"detail_address\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"地址\";}i:6;a:7:{s:5:\"field\";s:8:\"industry\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户行业\";}i:7;a:7:{s:5:\"field\";s:5:\"level\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户级别\";}i:8;a:7:{s:5:\"field\";s:9:\"next_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"下次联系时间\";}i:9;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:10;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:11;a:7:{s:5:\"field\";s:11:\"last_record\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进记录\";}i:12;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:13;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:14;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"跟新时间\";}i:15;a:7:{s:5:\"field\";s:9:\"last_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进时间\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (2, 10, 'crm', 'customer', 'a:20:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:1;a:7:{s:5:\"field\";s:6:\"source\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户来源\";}i:2;a:7:{s:5:\"field\";s:6:\"mobile\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"手机\";}i:3;a:7:{s:5:\"field\";s:9:\"telephone\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"电话\";}i:4;a:7:{s:5:\"field\";s:7:\"website\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"网址\";}i:5;a:7:{s:5:\"field\";s:8:\"industry\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户行业\";}i:6;a:7:{s:5:\"field\";s:5:\"level\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户级别\";}i:7;a:7:{s:5:\"field\";s:9:\"next_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"下次联系时间\";}i:8;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:9;a:7:{s:5:\"field\";s:5:\"email\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"邮箱\";}i:10;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:11;a:7:{s:5:\"field\";s:11:\"last_record\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进记录\";}i:12;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:13;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:14;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}i:15;a:7:{s:5:\"field\";s:9:\"last_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进时间\";}i:16;a:7:{s:5:\"field\";s:11:\"obtain_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:27:\"负责人获取客户时间\";}i:17;a:7:{s:5:\"field\";s:11:\"deal_status\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"成交状态\";}i:18;a:7:{s:5:\"field\";s:7:\"is_lock\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"锁定状态\";}i:19;a:7:{s:5:\"field\";s:8:\"pool_day\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:21:\"距进入公海天数\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (3, 10, 'crm', 'contacts', 'a:17:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"姓名\";}i:1;a:7:{s:5:\"field\";s:11:\"customer_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:2;a:7:{s:5:\"field\";s:6:\"mobile\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"手机\";}i:3;a:7:{s:5:\"field\";s:9:\"telephone\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"电话\";}i:4;a:7:{s:5:\"field\";s:5:\"email\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"邮箱\";}i:5;a:7:{s:5:\"field\";s:4:\"post\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"职务\";}i:6;a:7:{s:5:\"field\";s:8:\"decision\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:21:\"是否关键决策人\";}i:7;a:7:{s:5:\"field\";s:14:\"detail_address\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"地址\";}i:8;a:7:{s:5:\"field\";s:9:\"next_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"下次联系时间\";}i:9;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:10;a:7:{s:5:\"field\";s:3:\"sex\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"性别\";}i:11;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:12;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:13;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:14;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}i:15;a:7:{s:5:\"field\";s:9:\"last_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进时间\";}i:16;a:7:{s:5:\"field\";s:11:\"last_record\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进记录\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (4, 10, 'crm', 'business', 'a:13:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"商机名称\";}i:1;a:7:{s:5:\"field\";s:11:\"customer_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:2;a:7:{s:5:\"field\";s:5:\"money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"商机金额\";}i:3;a:7:{s:5:\"field\";s:9:\"deal_date\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"预计成交日期\";}i:4;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:5;a:7:{s:5:\"field\";s:9:\"status_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"商机阶段\";}i:6;a:7:{s:5:\"field\";s:7:\"type_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"商机状态组\";}i:7;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:8;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:9;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:10;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}i:11;a:7:{s:5:\"field\";s:9:\"last_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进时间\";}i:12;a:7:{s:5:\"field\";s:11:\"last_record\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进记录\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (5, 10, 'crm', 'contract', 'a:20:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同名称\";}i:1;a:7:{s:5:\"field\";s:3:\"num\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同编号\";}i:2;a:7:{s:5:\"field\";s:11:\"customer_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:3;a:7:{s:5:\"field\";s:11:\"business_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"商机名称\";}i:4;a:7:{s:5:\"field\";s:5:\"money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同金额\";}i:5;a:7:{s:5:\"field\";s:10:\"order_date\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"下单时间\";}i:6;a:7:{s:5:\"field\";s:10:\"start_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"合同开始时间\";}i:7;a:7:{s:5:\"field\";s:8:\"end_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"合同结束时间\";}i:8;a:7:{s:5:\"field\";s:11:\"contacts_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"客户签约人\";}i:9;a:7:{s:5:\"field\";s:13:\"order_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"公司签约人\";}i:10;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:11;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:12;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:13;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:14;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}i:15;a:7:{s:5:\"field\";s:9:\"last_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进时间\";}i:16;a:7:{s:5:\"field\";s:11:\"last_record\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:18:\"最后跟进记录\";}i:17;a:7:{s:5:\"field\";s:10:\"done_money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"已收款金额\";}i:18;a:7:{s:5:\"field\";s:8:\"un_money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"未收款金额\";}i:19;a:7:{s:5:\"field\";s:12:\"check_status\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"审核状态\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (6, 10, 'crm', 'receivables', 'a:16:{i:0;a:7:{s:5:\"field\";s:6:\"number\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回款编号\";}i:1;a:7:{s:5:\"field\";s:11:\"customer_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:2;a:7:{s:5:\"field\";s:11:\"contract_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同编号\";}i:3;a:7:{s:5:\"field\";s:7:\"plan_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"期数\";}i:4;a:7:{s:5:\"field\";s:11:\"return_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回款日期\";}i:5;a:7:{s:5:\"field\";s:5:\"money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回款金额\";}i:6;a:7:{s:5:\"field\";s:11:\"return_type\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回款方式\";}i:7;a:7:{s:5:\"field\";s:6:\"remark\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"备注\";}i:8;a:7:{s:5:\"field\";s:14:\"contract_money\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同金额\";}i:9;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:10;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:11;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:12;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}i:13;a:7:{s:5:\"field\";s:12:\"check_status\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"审核状态\";}i:14;a:7:{s:4:\"name\";s:18:\"计划回款日期\";s:5:\"field\";s:11:\"return_date\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:1;}i:15;a:7:{s:4:\"name\";s:18:\"提前几日提醒\";s:5:\"field\";s:6:\"remind\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:1;}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (7, 10, 'crm', 'product', 'a:11:{i:0;a:7:{s:5:\"field\";s:4:\"name\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"产品名称\";}i:1;a:7:{s:5:\"field\";s:11:\"category_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"产品类型\";}i:2;a:7:{s:5:\"field\";s:4:\"unit\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"产品单位\";}i:3;a:7:{s:5:\"field\";s:3:\"num\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"产品编码\";}i:4;a:7:{s:5:\"field\";s:5:\"price\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:6:\"价格\";}i:5;a:7:{s:5:\"field\";s:11:\"description\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"产品描述\";}i:6;a:7:{s:5:\"field\";s:6:\"status\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"是否上下架\";}i:7;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"负责人\";}i:8;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:9;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:10;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (8, 10, 'crm', 'visit', 'a:12:{i:0;a:7:{s:5:\"field\";s:6:\"number\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回访编号\";}i:1;a:7:{s:5:\"field\";s:10:\"visit_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回访时间\";}i:2;a:7:{s:5:\"field\";s:13:\"owner_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"回访人\";}i:3;a:7:{s:5:\"field\";s:5:\"shape\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"回访形式\";}i:4;a:7:{s:5:\"field\";s:11:\"customer_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户名称\";}i:5;a:7:{s:5:\"field\";s:11:\"contacts_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"联系人\";}i:6;a:7:{s:5:\"field\";s:11:\"contract_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:0;s:5:\"write\";i:1;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"合同编号\";}i:7;a:7:{s:5:\"field\";s:12:\"satisfaction\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:15:\"客户满意度\";}i:8;a:7:{s:5:\"field\";s:8:\"feedback\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:1;s:15:\"write_operation\";i:1;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"客户反馈\";}i:9;a:7:{s:5:\"field\";s:14:\"create_user_id\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:9:\"创建人\";}i:10;a:7:{s:5:\"field\";s:11:\"create_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"创建时间\";}i:11;a:7:{s:5:\"field\";s:11:\"update_time\";s:4:\"read\";i:1;s:14:\"read_operation\";i:1;s:5:\"write\";i:0;s:15:\"write_operation\";i:0;s:6:\"is_diy\";i:0;s:4:\"name\";s:12:\"更新时间\";}}', 1617340207, 1617340207);
INSERT INTO `5kcrm_admin_field_grant` VALUES (9, 10, 'crm', 'invoice', 'a:8:{i:0;a:7:{s:5:"field";s:20:"invoice_apple_number";s:4:"read";i:1;s:14:"read_operation";i:1;s:5:"write";i:1;s:15:"write_operation";i:1;s:6:"is_diy";i:0;s:4:"name";s:18:"发票申请编号";}i:1;a:7:{s:5:"field";s:11:"customer_id";s:4:"read";i:1;s:14:"read_operation";i:0;s:5:"write";i:1;s:15:"write_operation";i:0;s:6:"is_diy";i:0;s:4:"name";s:12:"客户名称";}i:2;a:7:{s:5:"field";s:11:"contract_id";s:4:"read";i:1;s:14:"read_operation";i:0;s:5:"write";i:1;s:15:"write_operation";i:0;s:6:"is_diy";i:0;s:4:"name";s:12:"合同编号";}i:3;a:7:{s:5:"field";s:14:"contract_money";s:4:"read";i:1;s:14:"read_operation";i:0;s:5:"write";i:1;s:15:"write_operation";i:0;s:6:"is_diy";i:0;s:4:"name";s:12:"合同金额";}i:4;a:7:{s:5:"field";s:13:"invoice_money";s:4:"read";i:1;s:14:"read_operation";i:1;s:5:"write";i:1;s:15:"write_operation";i:1;s:6:"is_diy";i:0;s:4:"name";s:12:"开票金额";}i:5;a:7:{s:5:"field";s:12:"invoice_date";s:4:"read";i:1;s:14:"read_operation";i:1;s:5:"write";i:1;s:15:"write_operation";i:1;s:6:"is_diy";i:0;s:4:"name";s:12:"开票日期";}i:6;a:7:{s:5:"field";s:12:"invoice_type";s:4:"read";i:1;s:14:"read_operation";i:1;s:5:"write";i:1;s:15:"write_operation";i:1;s:6:"is_diy";i:0;s:4:"name";s:12:"开票类型";}i:7;a:7:{s:5:"field";s:6:"remark";s:4:"read";i:1;s:14:"read_operation";i:1;s:5:"write";i:1;s:15:"write_operation";i:1;s:6:"is_diy";i:0;s:4:"name";s:6:"备注";}}', 1617340207, 1617340207);

-- ----------------------------
-- Table structure for 5kcrm_admin_file
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_file`;
CREATE TABLE `5kcrm_admin_file`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型（file、img）',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '附件名称',
  `save_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '保存路径名称',
  `size` int(10) NOT NULL COMMENT '附件大小（字节）',
  `create_user_id` int(10) NOT NULL COMMENT '创建人ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `file_path_thumb` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件路径(图片缩略图)',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_file
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_group`;
CREATE TABLE `5kcrm_admin_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` tinyint(4) NOT NULL COMMENT '分类：0客户自定义角色,1系统默认管理角色,2客户管理角色,3人力资源管理角色,4财务管理角色,5项目管理角色,6办公管理角色',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `rules` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '1启用0禁用',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1本人，2本人及下属，3本部门，4本部门及下属部门，5全部 ',
  `types` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1超级管理员2系统设置管理员3部门与员工管理员4审批流管理员5工作台管理员6客户管理员7项目管理员8公告管理员',
  `system` tinyint(4) NOT NULL DEFAULT 0 COMMENT '系统角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_group
-- ----------------------------
INSERT INTO `5kcrm_admin_group` VALUES (1, 1, '超级管理员角色', '', '超级管理员角色', 1, 1, 1, 0);
INSERT INTO `5kcrm_admin_group` VALUES (2, 1, '系统设置管理员', ',105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,159,138,139,208,209,220,151,221,222,', '系统设置管理员', 1, 0, 2, 0);
INSERT INTO `5kcrm_admin_group` VALUES (3, 1, '部门与员工管理员', ',112,113,114,115,116,117,118,119,105,', '部门与员工管理员', 1, 1, 3, 0);
INSERT INTO `5kcrm_admin_group` VALUES (4, 1, '审批流管理员', ',124,125,105,', '审批流管理员', 1, 1, 4, 0);
INSERT INTO `5kcrm_admin_group` VALUES (5, 1, '工作台管理员', ',122,123,105,', '工作台管理员', 1, 1, 5, 0);
INSERT INTO `5kcrm_admin_group` VALUES (6, 1, '客户管理员', ',126,127,128,129,130,105,', '客户管理员', 1, 1, 6, 0);
INSERT INTO `5kcrm_admin_group` VALUES (7, 1, '公告管理员', '', '公告管理员', 1, 1, 8, 0);
INSERT INTO `5kcrm_admin_group` VALUES (10, 2, '销售经理角色', ',1,2,3,4,5,6,7,8,9,73,74,160,10,11,12,13,14,15,16,17,18,19,20,21,104,161,164,22,23,24,25,26,27,28,81,82,162,230,34,35,36,37,38,39,40,41,146,163,210,42,43,44,45,46,47,48,49,147,148,211,50,51,52,53,54,55,153,212,213,229,56,57,58,59,60,61,83,84,149,214,165,166,167,168,169,170,171,172,173,231,174,175,176,177,178,179,224,225,215,216,217,218,219,226,233,234,235,236,237,238,239,62,63,64,65,66,69,70,71,72,75,76,77,78,79,80,', '', 1, 2, 0, 0);
INSERT INTO `5kcrm_admin_group` VALUES (11, 1, '项目管理员', ',141,142,143,', '项目管理员', 1, 1, 7, 0);
INSERT INTO `5kcrm_admin_group` VALUES (12, 5, '编辑', ',0,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,223', '成员初始加入时默认享有的权限：默认只有新建任务，查看任务权限', 1, 0, 7, 1);
INSERT INTO `5kcrm_admin_group` VALUES (13, 5, '只读', '', '项目只读角色', 1, 0, 0, 0);
INSERT INTO `5kcrm_admin_group` VALUES (14, 6, '办公管理员', '', '', 1, 1, 0, 0);
INSERT INTO `5kcrm_admin_group` VALUES (15, 9, '管理项目', ',141,142,143,', '', 1, 0, 0, 0);

-- ----------------------------
-- Table structure for 5kcrm_admin_group_auth
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_group_auth`;
CREATE TABLE `5kcrm_admin_group_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL COMMENT '角色id',
  `auth_group_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色授权的 角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限查看配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of 5kcrm_admin_group_auth
-- ----------------------------

-- ----------------------------
-- Table structure for 5kcrm_admin_import_record
-- ----------------------------
DROP TABLE IF EXISTS `5kcrm_admin_import_record`;
CREATE TABLE `5kcrm_admin_import_record`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '导入模块',
  `total` int(10) NOT NULL DEFAULT 0 COMMENT '总数',
  `done` int(10) NOT NULL DEFAULT 0 COMMENT '已导入数',
  `cover` int(10) NOT NULL DEFAULT 0 COMMENT '覆盖数',
  `error` int(10) NOT NULL DEFAULT 0 COMMENT '错误数',
  `error_data_file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '错误数据文件路径',
  `create_time` int(10) NOT NULL DEFAULT 0,
  `user_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导入数据记录表' ROW_FORMAT = DYNAMIC;
