CREATE TABLE `5kcrm_admin_field_grant` (
  `grant_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `module` varchar(32) NOT NULL COMMENT '模块：crm、oa、bi等',
  `column` varchar(32) NOT NULL COMMENT '栏目：leads、customer、contacts等',
  `content` text NOT NULL COMMENT '授权内容',
  `update_time` int(10) NOT NULL COMMENT '修改日期',
  `create_time` int(10) NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`grant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限管理-字段授权';