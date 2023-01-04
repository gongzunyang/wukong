CREATE TABLE `5kcrm_admin_printing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '预留字段：用户ID',
  `user_name` varchar(32) NOT NULL COMMENT '显示字段：用户名称',
  `name` varchar(32) NOT NULL COMMENT '打印模板名称',
  `type` tinyint(1) NOT NULL COMMENT '打印类型：1商机；2合同；3回款',
  `content` mediumtext NOT NULL COMMENT '打印内容',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='打印模板表';



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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日报规则表' ROW_FORMAT = Dynamic;

INSERT INTO `5kcrm_admin_oalog_rule` VALUES (1, 4, NULL, NULL, NULL, NULL, 1, 'a:2:{i:0;s:27:\"每一天都是崭新的！\";i:1;s:60:\"蓝天是宁静的，空气是清新的，阳光是明媚的\";}');
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (2, 1, '3,4', '1,2,3,4,5', '10:00', '20:00', 1, NULL);
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (3, 2, '3,4', NULL, '1', '2', 1, NULL);
INSERT INTO `5kcrm_admin_oalog_rule` VALUES (4, 3, '1,3,4', NULL, '1', '5', 1, NULL);



ALTER TABLE `5kcrm_crm_business_type` ADD COLUMN `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '软删除：1显示0不显示';

INSERT INTO `5kcrm_admin_scene` VALUES ('crm_leads', '我的关注', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES ('crm_customer', '我的关注', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES ('crm_contacts', '我的关注', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);
INSERT INTO `5kcrm_admin_scene` VALUES ('crm_business', '我的关注', 0, 0, NULL, 0, 1, 'star', 1607158834, 1607158834);