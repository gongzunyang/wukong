CREATE TABLE `5kcrm_admin_system_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `client_ip` varchar(20) NOT NULL COMMENT '用户IP',
  `module_name` varchar(20) NOT NULL COMMENT '模块名',
  `controller_name` varchar(20) NOT NULL COMMENT '控制器',
  `action_name` varchar(20) NOT NULL COMMENT '方法',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作ID',
  `target_name` varchar(50) NOT NULL COMMENT '被操作对象的名称',
  `action_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为删除操作',
  `content` text NOT NULL COMMENT '内容',
  `create_time` int(10) NOT NULL COMMENT '时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统操作日志表';

ALTER TABLE `5kcrm_admin_action_log` ADD `target_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '被操作对象的名称' AFTER `action_id`;