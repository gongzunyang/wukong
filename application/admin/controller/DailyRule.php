<?php
/**
 * 日志规则控制器
 *
 * @author qifan
 * @date 2020-12-03
 */

namespace app\admin\controller;

use app\admin\logic\DailyRuleLogic;
use think\Hook;
use think\Request;

class DailyRule extends ApiCommon
{
    /**
     * 用于判断权限
     * @permission 无限制
     * @allow 登录用户可访问
     * @other 其他根据系统设置
     **/
    public function _initialize()
    {
        $action = [
            'permission'=>[''],
            'allow'=>['welcome', 'setwelcome', 'worklogrule', 'setworklogrule','schedulelist','addschedule','setschedule','delschedule']
        ];
        Hook::listen('check_auth',$action);
        $request = Request::instance();
        $a = strtolower($request->action());
        if (!in_array($a, $action['permission'])) {
            parent::_initialize();
        }
    }

    /**
     * 获取欢迎语
     *
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     */
    public function welcome(DailyRuleLogic $dailyRuleLogic)
    {
        $data = $dailyRuleLogic->welcome();

        return resultArray(['data' => $data]);
    }

    /**
     * 添加欢迎语
     *
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function setWelcome(DailyRuleLogic $dailyRuleLogic)
    {
        $mark = $this->param['welcome'];
        $userInfo=$this->userInfo;
        if (empty($mark)) return resultArray(['error' => '缺少日志欢迎语！']);

        if (!$dailyRuleLogic->setWelcome($mark)) return resultArray(['error' => '添加失败！']);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'admin_oalog_rule','work_task','1','update','日志欢迎语' , '', '','设置了日志欢迎语');
        return resultArray(['data' => '添加成功！']);
    }

    /**
     * 获取日志规则
     *
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function workLogRule(DailyRuleLogic $dailyRuleLogic)
    {
        $data = $dailyRuleLogic->workLogRule();

        return resultArray(['data' => $data]);
    }

    /**
     * 设置日志规则
     *
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function setWorkLogRule(DailyRuleLogic $dailyRuleLogic)
    {
        if (empty($this->param['rule'])) return resultArray(['error' => '缺少规则参数！']);
        $userInfo=$this->userInfo;
        $dailyRuleLogic->setWorkLogRule($this->param['rule']);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'admin_oalog_rule','work_task', 1, 'update','日志规则' , '', '','设置了日志规则');
        return resultArray(['data' => '设置成功！']);
    }

    /**
     * 获取日程规则
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function scheduleList(DailyRuleLogic $dailyRuleLogic){
        $data = $dailyRuleLogic->schedule();
        return resultArray(['data' => $data]);
    }

    /**
     * 设置日程自定义规则
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function  setSchedule(DailyRuleLogic $dailyRuleLogic){
        $userInfo=$this->userInfo;
        if(empty($this->param['id'])) return resultArray(['error'=>'缺少参数']);
          $dailyRuleLogic->setSchedule($this->param);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'admin_oalog_rule','work_task', 1, 'update','日程类型' , '', '','设置了日程类型');
        return resultArray(['data' => '设置成功！']);

    }

    /**
     * 添加日程自定义规则
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     */
    public function addSchedule(DailyRuleLogic $dailyRuleLogic){
        $userInfo=$this->userInfo;
        if(empty($this->param['name'])) return resultArray(['error'=>'缺少参数']);
        $dailyRuleLogic->addSchedule($this->param);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'admin_oalog_rule','work_task', 1, 'save','日程类型' , '', '','新增了日程类型');
        return resultArray(['data' => '添加成功！']);

    }

    /**
     * 删除日程自定义规则
     * @param DailyRuleLogic $dailyRuleLogic
     * @return \think\response\Json
     */
    public function delSchedule(DailyRuleLogic $dailyRuleLogic){
        $userInfo=$this->userInfo;
        if(empty($this->param['id'])) return resultArray(['error'=>'缺少参数']);
        $dailyRuleLogic->delSchedule($this->param['id']);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'admin_oalog_rule','work_task', 1, 'update','日程类型' , '', '','删除了日程类型');
        return resultArray(['data' => '删除成功！']);
    }

}