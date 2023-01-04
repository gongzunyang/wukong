INSERT INTO`5kcrm_admin_rule` (`types`, `title`, `name`, `level`, `pid`, `status`) VALUES ('2', '编辑团队成员', 'teamSave', '3', '50', '1');
INSERT INTO`5kcrm_admin_rule` (`types`, `title`, `name`, `level`, `pid`, `status`) VALUES ('2', '编辑团队成员', 'teamSave', '3', '22', '1');
ALTER TABLE `5kcrm_crm_receivables` ADD COLUMN `ro_user_id` varchar(500) NOT NULL DEFAULT '' COMMENT '只读权限';
ALTER TABLE `5kcrm_crm_receivables` ADD COLUMN `rw_user_id` varchar(500) NOT NULL DEFAULT '' COMMENT '读写权限';
ALTER TABLE `5kcrm_admin_system_log` MODIFY COLUMN `target_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '被操作对象的名称' AFTER `log_id`;
ALTER TABLE `5kcrm_admin_operation_log` MODIFY COLUMN `target_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '被操作对象' AFTER `log_id`;
ALTER TABLE `5kcrm_admin_operation_log` MODIFY COLUMN `action_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作';
ALTER TABLE `5kcrm_admin_action_log` MODIFY COLUMN `target_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '被操作对象';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `style_percent` tinyint(4) unsigned NOT NULL DEFAULT 100 COMMENT '字段宽度百分比：25、50、75、100';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `form_position` varchar(20) NULL COMMENT '字段位置 0:2，第一个数字表示列，第二个数字表示行';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `precisions` tinyint(4) unsigned NULL COMMENT '1、小数的精度，允许的最大小数位数，默认为null，表示不启用小数。2、也包含其他数据选项，如：明细表格的显示方式';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `max_num_restrict` varchar(30) NULL COMMENT '数字类字段的最大数，所填写的数字不能大于这个字段的值，默认为null';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `min_num_restrict` varchar(30) NULL COMMENT '数字类字段的最小数，所填写的数字不能小于这个字段的值，默认为null';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `remark` varchar(64) NULL COMMENT '字段说明';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `options` longtext NULL COMMENT '如果类型是选项，此处不能为空，多个选项以，隔开，此处的数据是用于控制其他字段是否显示的逻辑表单';
ALTER TABLE `5kcrm_admin_field` ADD COLUMN `formAssistId` int(10) null COMMENT '逻辑表单相关，由前端生成';
ALTER TABLE `5kcrm_oa_examine_data` MODIFY COLUMN `value` longtext DEFAULT NULL COMMENT '字段内容';
CREATE TABLE `5kcrm_admin_field_extend` (
    `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `types` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块：crm_leads、crm_customer、crm_contacts、crm_business、crm_contract、crm_receivables、crm_product、crm_receivables_plan、crm_visit、oa_examine',
    `field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名称',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '生成时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `field_types`(`field`, `types`) USING BTREE,
    UNIQUE INDEX `field`(`field`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义字段扩展表' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_leads_data`  (
    `leads_id` int(10) UNSIGNED NOT NULL COMMENT '线索表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '线索表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_customer_data`  (
    `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_contacts_data`  (
    `contacts_id` int(10) UNSIGNED NOT NULL COMMENT '联系人表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '联系人表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_business_data`  (
    `business_id` int(10) UNSIGNED NOT NULL COMMENT '商机表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商机表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_contract_data`  (
    `contract_id` int(10) UNSIGNED NOT NULL COMMENT '合同表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_receivables_data`  (
    `receivables_id` int(10) UNSIGNED NOT NULL COMMENT '回款表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_visit_data`  (
    `visit_id` int(10) UNSIGNED NOT NULL COMMENT '回访表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回访表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_product_data`  (
    `product_id` int(10) UNSIGNED NOT NULL COMMENT '产品表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_invoice_data`  (
    `invoice_id` int(10) UNSIGNED NOT NULL COMMENT '发票表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '发票表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_crm_receivables_plan_data`  (
    `plan_id` int(10) UNSIGNED NOT NULL COMMENT '发票表ID',
    `field` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名',
    `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
    `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款计划表扩展字段数据' ROW_FORMAT = Dynamic;
CREATE TABLE `5kcrm_oa_log_favour`  (
    `favour_id` int(11) NOT NULL AUTO_INCREMENT,
    `log_id` int(11) NOT NULL,
    `user_id` int(11) NULL DEFAULT NULL COMMENT '点赞人id',
    `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态 0禁用 1显示',
    PRIMARY KEY (`favour_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '点赞记录表' ROW_FORMAT = Dynamic;
INSERT INTO `5kcrm_admin_scene` (`types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time`) VALUES ('crm_product', '上架的产品', 0, 0, NULL, 0, 1, 'put_on_shelves', 1623240292, 1623240292);
INSERT INTO `5kcrm_admin_scene` (`types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time`) VALUES ('crm_product', '下架的产品', 0, 0, NULL, 0, 1, 'pull_off_shelves', 1623240292, 1623240292);
DELETE FROM `5kcrm_admin_scene` WHERE `name` like '我参与%';
ALTER TABLE `5kcrm_crm_contract` MODIFY COLUMN `expire_remind` tinyint(1) NOT NULL DEFAULT 1  COMMENT '是否提醒合同到期：1提醒；0提醒';
ALTER TABLE `5kcrm_crm_business` MODIFY COLUMN `expire_remind` tinyint(1) NOT NULL DEFAULT 1  COMMENT '是否提醒：1提醒；0提醒';
DELETE FROM `5kcrm_admin_field` WHERE `types` = 'crm_receivables_plan' AND `field` = 'file';
ALTER TABLE `5kcrm_crm_customer_pool_field_setting` ADD COLUMN `is_null` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填：1必填，0不是必填';
ALTER TABLE `5kcrm_crm_customer_pool_field_setting` ADD COLUMN `is_unique` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否唯一：1唯一，0不唯一';
UPDATE `5kcrm_crm_customer_pool_field_setting` SET `is_null` = 1, `is_unique` = 1 WHERE `field_name` = 'name' AND `name` = '客户名称';
CREATE TABLE `5kcrm_app_navigation`  (
    `p_id` int(11) NOT NULL AUTO_INCREMENT,
    `data` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据集',
    `create_user_id` int(11) NOT NULL COMMENT '创建人',
    PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '手机端导航数据表' ROW_FORMAT = Dynamic;
INSERT INTO `5kcrm_admin_field`(`types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ('crm_invoice', 0, 'invoice_apple_number', '发票申请编号', 'text', '', 0, 1, 1, '', '', 0, 1, 1553788800, 1553788800, 0, NULL, 0, 100, '0,0', null, null, null, null, null, 1001);
INSERT INTO `5kcrm_admin_field`( `types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'customer_id', '客户名称', 'customer', '', 0, 0, 1, '', '', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '1,0', null, null, null, null, null, 1002);
INSERT INTO `5kcrm_admin_field`(`types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'contract_id', '合同编号', 'contract', '', 0, 0, 1, '', '', 0, 1, 1553788800, 1553788800, 0, NULL, 0, 100, '2,0', null, null, null, null, null, 1003);
INSERT INTO `5kcrm_admin_field`( `types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'contract_money', '合同金额', 'floatnumber', '', 0, 0, 1, '元', '', 0, 1, 1553788800, 1553788800, 0, NULL, 0, 100, '3,0', null, null, null, null, null, 1004);
INSERT INTO `5kcrm_admin_field`( `types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'invoice_date', '开票日期', 'date', '', 0, 0, 0, '', '', 0, 1, 1553788800, 1553788800, 0, NULL, 0, 100, '4,0', null, null, null, null, null, 1005);
INSERT INTO `5kcrm_admin_field`( `types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'invoice_money', '开票金额', 'floatnumber', '', 0, 0, 1, '元', '', 0, 1, 1553788800, 1553788800, 0, NULL, 0, 100, '5,0', null, null, null, null, null, 1006);
INSERT INTO `5kcrm_admin_field`(`types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ( 'crm_invoice', 0, 'invoice_type', '开票类型', 'select', '', 0, 0, 1, '', '增值税专用发票\n增值税普通发票\n国税通用机打发票\n地税通用机打发票\n收据', 0, 3, 1553788800, 1553788800, 0, NULL, 0, 100, '6,0', null, null, null, null, null, 1007);
INSERT INTO `5kcrm_admin_field`( `types`, `types_id`, `field`, `name`, `form_type`, `default_value`, `max_length`, `is_unique`, `is_null`, `input_tips`, `setting`, `order_id`, `operating`, `create_time`, `update_time`, `type`, `relevant`, `is_hidden`, `style_percent`, `form_position`, `precisions`, `max_num_restrict`, `min_num_restrict`, `remark`, `options`, `formAssistId`)
VALUES ('crm_invoice', 0, 'remark', '备注', 'textarea', '', 0, 0, 0, '', NULL, 1, 1, 1620874670, 1620874670, 0, NULL, 0, 100, '7,0', null, null, null, null, null, 1008);
INSERT INTO `5kcrm_admin_scene`( `types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time`) VALUES ( 'crm_business', '进行中的商机', 0, 0, NULL, 0, 1, 'go_business', 1546272000, 1546272000);
INSERT INTO `5kcrm_admin_scene` ( `types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time` )VALUES( 'crm_invoice', '全部发票', 0, 0, '', 0, 1, 'all', 1546272000, 1546272000 );
INSERT INTO `5kcrm_admin_scene` ( `types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time` )VALUES( 'crm_invoice', '我负责的发票', 0, 0, '', 0, 1, 'me', 1546272000, 1546272000 );
INSERT INTO `5kcrm_admin_scene` ( `types`, `name`, `user_id`, `order_id`, `data`, `is_hide`, `type`, `bydata`, `create_time`, `update_time` )VALUES( 'crm_invoice', '下属负责的发票', 0, 0, '', 0, 1, 'sub', 1546272000, 1546272000 );
CREATE TABLE `5kcrm_crm_team`  (
    `team_id` int(11) NOT NULL AUTO_INCREMENT,
    `types` tinyint(4) NOT NULL COMMENT '模块 1 客户 2联系人 3商机 4合同 5回款 ',
    `target_id` int(11) NOT NULL COMMENT '团队成员所属对象id',
    `target_time` int(11) NULL DEFAULT NULL COMMENT '截止到期时间',
    `team_user_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '团队用户id',
    `auth` tinyint(2) NOT NULL COMMENT '1 只读权限 2读写权限',
    PRIMARY KEY (`team_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '团队成员截止时间' ROW_FORMAT = Dynamic;
INSERT INTO `5kcrm_admin_rule` (`types`, `title`, `name`, `level`, `pid`, `status`) VALUES ('0', '角色权限查看', 'ruleList', '3', '112', '1');
CREATE TABLE `5kcrm_admin_group_auth` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `group_id` int(11) NOT NULL COMMENT '角色id',
    `auth_group_id` varchar(100) NOT NULL COMMENT '角色授权的 角色id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色权限查看配置表';
ALTER TABLE `5kcrm_admin_field` MODIFY COLUMN `operating` int(10) NOT NULL DEFAULT '0' COMMENT '0改删，1改，2删，3无';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_leads';
UPDATE `5kcrm_admin_field` SET `operating` = '189', `formAssistId` = 1001 WHERE `types` = 'crm_leads' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1002 WHERE `types` = 'crm_leads' AND `field` = 'source';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1003 WHERE `types` = 'crm_leads' AND `field` = 'industry';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1004 WHERE `types` = 'crm_leads' AND `field` = 'level';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1005 WHERE `types` = 'crm_leads' AND `field` = 'telephone';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1006 WHERE `types` = 'crm_leads' AND `field` = 'mobile';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_leads' AND `field` = 'email';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_leads' AND `field` = 'detail_address';
UPDATE `5kcrm_admin_field` SET `operating` = '63', `formAssistId` = 1009 WHERE `types` = 'crm_leads' AND `field` = 'next_time';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1010 WHERE `types` = 'crm_leads' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_customer';
UPDATE `5kcrm_admin_field` SET `operating` = '189', `formAssistId` = 1001 WHERE `types` = 'crm_customer' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1002 WHERE `types` = 'crm_customer' AND `field` = 'industry';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1003 WHERE `types` = 'crm_customer' AND `field` = 'level';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1004 WHERE `types` = 'crm_customer' AND `field` = 'source';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1005 WHERE `types` = 'crm_customer' AND `field` = 'telephone';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1006 WHERE `types` = 'crm_customer' AND `field` = 'mobile';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_customer' AND `field` = 'email';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_customer' AND `field` = 'website';
UPDATE `5kcrm_admin_field` SET `operating` = '63', `formAssistId` = 1009 WHERE `types` = 'crm_customer' AND `field` = 'next_time';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1010 WHERE `types` = 'crm_customer' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1011 WHERE `types` = 'crm_customer' AND `field` = 'deal_status';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_contacts';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1001 WHERE `types` = 'crm_contacts' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1002 WHERE `types` = 'crm_contacts' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1003 WHERE `types` = 'crm_contacts' AND `field` = 'mobile';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1004 WHERE `types` = 'crm_contacts' AND `field` = 'telephone';
UPDATE `5kcrm_admin_field` SET `operating` = '190', `formAssistId` = 1005 WHERE `types` = 'crm_contacts' AND `field` = 'decision';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1006 WHERE `types` = 'crm_contacts' AND `field` = 'post';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_contacts' AND `field` = 'email';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_contacts' AND `field` = 'detail_address';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1009 WHERE `types` = 'crm_contacts' AND `field` = 'sex';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1010 WHERE `types` = 'crm_contacts' AND `field` = 'next_time';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1011 WHERE `types` = 'crm_contacts' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_business';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1001 WHERE `types` = 'crm_business' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1002 WHERE `types` = 'crm_business' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '19', `formAssistId` = 1003 WHERE `types` = 'crm_business' AND `field` = 'type_id';
UPDATE `5kcrm_admin_field` SET `operating` = '19', `formAssistId` = 1004 WHERE `types` = 'crm_business' AND `field` = 'status_id';
UPDATE `5kcrm_admin_field` SET `operating` = '189', `formAssistId` = 1005 WHERE `types` = 'crm_business' AND `field` = 'money';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1006 WHERE `types` = 'crm_business' AND `field` = 'deal_date';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_business' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_contract';
UPDATE `5kcrm_admin_field` SET `operating` = '177', `formAssistId` = 1001 WHERE `types` = 'crm_contract' AND `field` = 'num';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1002 WHERE `types` = 'crm_contract' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '149', `formAssistId` = 1003 WHERE `types` = 'crm_contract' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1004 WHERE `types` = 'crm_contract' AND `field` = 'business_id';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1006 WHERE `types` = 'crm_contract' AND `field` = 'order_date';
UPDATE `5kcrm_admin_field` SET `operating` = '189', `formAssistId` = 1006 WHERE `types` = 'crm_contract' AND `field` = 'money';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_contract' AND `field` = 'start_time';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_contract' AND `field` = 'end_time';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1009 WHERE `types` = 'crm_contract' AND `field` = 'contacts_id';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1010 WHERE `types` = 'crm_contract' AND `field` = 'order_user_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1011 WHERE `types` = 'crm_contract' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_receivables';
UPDATE `5kcrm_admin_field` SET `operating` = '177', `formAssistId` = 1001 WHERE `types` = 'crm_receivables' AND `field` = 'number';
UPDATE `5kcrm_admin_field` SET `operating` = '153', `formAssistId` = 1002 WHERE `types` = 'crm_receivables' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1003 WHERE `types` = 'crm_receivables' AND `field` = 'contract_id';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1004 WHERE `types` = 'crm_receivables' AND `field` = 'return_time';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1005 WHERE `types` = 'crm_receivables' AND `field` = 'return_type';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1006 WHERE `types` = 'crm_receivables' AND `field` = 'money';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_receivables' AND `field` = 'plan_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_receivables' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_receivables_plan';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1001 WHERE `types` = 'crm_receivables_plan' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1002 WHERE `types` = 'crm_receivables_plan' AND `field` = 'contract_id';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1003 WHERE `types` = 'crm_receivables_plan' AND `field` = 'money';
UPDATE `5kcrm_admin_field` SET `operating` = '183', `formAssistId` = 1004 WHERE `types` = 'crm_receivables_plan' AND `field` = 'return_date';
UPDATE `5kcrm_admin_field` SET `operating` = '0', `formAssistId` = 1005 WHERE `types` = 'crm_receivables_plan' AND `field` = 'return_type';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1006 WHERE `types` = 'crm_receivables_plan' AND `field` = 'remind';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_receivables_plan' AND `field` = 'remark';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_visit';
UPDATE `5kcrm_admin_field` SET `operating` = '177', `formAssistId` = 1001 WHERE `types` = 'crm_visit' AND `field` = 'number';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1002 WHERE `types` = 'crm_visit' AND `field` = 'visit_time';
UPDATE `5kcrm_admin_field` SET `operating` = '149', `formAssistId` = 1003 WHERE `types` = 'crm_visit' AND `field` = 'owner_user_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1004 WHERE `types` = 'crm_visit' AND `field` = 'shape';
UPDATE `5kcrm_admin_field` SET `operating` = '149', `formAssistId` = 1005 WHERE `types` = 'crm_visit' AND `field` = 'customer_id';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1006 WHERE `types` = 'crm_visit' AND `field` = 'contacts_id';
UPDATE `5kcrm_admin_field` SET `operating` = '159', `formAssistId` = 1007 WHERE `types` = 'crm_visit' AND `field` = 'contract_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1008 WHERE `types` = 'crm_visit' AND `field` = 'satisfaction';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1009 WHERE `types` = 'crm_visit' AND `field` = 'feedback';
UPDATE `5kcrm_admin_field` SET `operating` = '255' WHERE `types` = 'crm_product';
UPDATE `5kcrm_admin_field` SET `operating` = '177', `formAssistId` = 1001 WHERE `types` = 'crm_product' AND `field` = 'name';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1002 WHERE `types` = 'crm_product' AND `field` = 'category_id';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1003 WHERE `types` = 'crm_product' AND `field` = 'num';
UPDATE `5kcrm_admin_field` SET `operating` = '144', `formAssistId` = 1004 WHERE `types` = 'crm_product' AND `field` = 'status';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1005 WHERE `types` = 'crm_product' AND `field` = 'unit';
UPDATE `5kcrm_admin_field` SET `operating` = '181', `formAssistId` = 1006 WHERE `types` = 'crm_product' AND `field` = 'price';
UPDATE `5kcrm_admin_field` SET `operating` = '191', `formAssistId` = 1007 WHERE `types` = 'crm_product' AND `field` = 'description';
UPDATE `5kcrm_admin_field` SET `operating` = '0' WHERE `types` = 'oa_examine';
DELETE FROM `5kcrm_admin_field` WHERE `field` = 'deal_status' AND `types` = 'crm_customer';
ALTER TABLE `5kcrm_crm_invoice` ADD COLUMN `contract_money` decimal(18,2) DEFAULT '0.00' COMMENT '合同金额';
INSERT INTO `5kcrm_admin_group` (`pid`, `title`, `rules`, `remark`, `status`, `type`, `types`, `system`) VALUES (9, '管理项目', ',141,142,143,', '', 1, 0, 0, 0);