--
--回款计划
--
ALTER TABLE `5kcrm_crm_receivables_plan` ADD `real_money` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '实际回款金额';
ALTER TABLE `5kcrm_crm_receivables_plan` ADD `real_data` date DEFAULT NULL COMMENT '实际回款日期';
ALTER TABLE `5kcrm_crm_receivables_plan` ADD `un_money` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '未回金额';
DELETE `5kcrm_admin_field` where `types` = 'crm_customer' AND`field` = 'deal_status';
INSERT INTO `5kcrm_admin_field` VALUES (18, 'crm_customer', 0, 'deal_status', '成交状态', 'select', '未成交', 0, 0, 1, '', '未成交\n已成交', 0, 191, 1553788800, 1553788800, 0, NULL, 0, 100, '', NULL, NULL, NULL, NULL, NULL, NULL);

