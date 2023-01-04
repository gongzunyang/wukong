<?php
// +----------------------------------------------------------------------
// | Description: 业绩目标设置及完成情况统计
// +----------------------------------------------------------------------
// | Author: yykun  
// +----------------------------------------------------------------------

namespace app\crm\controller;

use app\admin\controller\ApiCommon;
use app\crm\logic\AchievementLogic;
use think\Hook;
use think\Request;

class Achievement extends ApiCommon
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
            'allow'=>['index','indexforuser','save','read','update','delete']
        ];
        Hook::listen('check_auth',$action);
        $request = Request::instance();
        $a = strtolower($request->action());        
        if (!in_array($a, $action['permission'])) {
            parent::_initialize();
        }

        $userInfo = $this->userInfo;
        //权限判断
        $unAction = [''];
        if (!in_array($a, $unAction) && !checkPerByAction('admin', 'crm', 'achievement')) {
            header('Content-Type:application/json; charset=utf-8');
            exit(json_encode(['code'=>102,'error'=>'无权操作']));
        }        
    }

    /**
     * 业绩目标列表
     * @author yykun
     * @return
     */
    public function index(AchievementLogic $achievementLogic)
    {
//        $model = model('Achievement');
//        $param = $this->param;
//        $data  = $model->getDataList($param);
//        return resultArray(['data' => $data]);
        if (empty($this->param['year'])) return resultArray(['error' => '请选择年份！']);
        if (empty($this->param['type'])) return resultArray(['error' => '请选择业绩类型']);
        if (empty($this->param['structure_id'])) return resultArray(['error' => '请选择部门或员工！']);

        $data = $achievementLogic->getDepartmentList($this->param);

        return resultArray(['data' => $data]);
    }
	
	//员工业绩目标列表
	public function indexForuser(AchievementLogic $achievementLogic)
    {
        $model = model('Achievement');
        $param = $this->param;
        $data = $model->getDataListForUser($param);
        # 剔除没有业绩目标的员工
        foreach ($data AS $key => $value) {
            if (empty((int)$value['yeartarget'])) unset($data[(int)$key]);
        }
        return resultArray(['data' => array_values($data)]);
//        if (empty($this->param['year'])) return resultArray(['error' => '请选择年份！']);
//        if (empty($this->param['type'])) return resultArray(['error' => '请选择业绩类型']);
//        if (empty($this->param['structure_id']) && empty($this->param['user_id'])) {
//            return resultArray(['error' => '请选择部门或员工！']);
//        }
//
//        $data = $achievementLogic->getEmployeeList($this->param);
//
//        return resultArray(['data' => $data]);
    }

    /**
     * 添加
     * @author yykun
     * @param  
     * @return
     */
    public function save()
    {  
        $model = model('Achievement');
        $param = $this->param;
        $userInfo = $this->userInfo;
        if ($model->createData($param)) {
            # 系统操作日志
            SystemActionLog($userInfo['id'], 'crm_number_sequence','customer', 1,  'save','业绩目标设置' , '', '','添加了业绩目标');
            return resultArray(['data' => '添加成功']);
        } else {
            return resultArray(['error' => $model->getError()]);
        }
    }

    /**
     * 详情
     * @author yykun
     * @param  
     * @return
     */
    public function read()
    {
        $model = model('Achievement');
        $param = $this->param;
        $data = $model->getDataById($param['id']);
        if (!$data) {
            return resultArray(['error' => $model->getError()]);
        } else {
            return resultArray(['data' => $data]);
        }
    }

    /**
     * 编辑信息
     * @author yykun
     * @param 
     * @return
     */
    public function update()
    {    
        $model = model('Achievement');
        $userInfo = $this->userInfo;
        $param = $this->param;
        if ($model->updateData($param)) {
            # 系统操作日志
            SystemActionLog($userInfo['id'], 'crm_number_sequence','customer', 1, 'update','业绩目标设置' , '', '','设置了业绩目标');
            return resultArray(['data' => '编辑成功']);
        } else {
            return resultArray(['error' => $model->getError()]);
        }      
    }

    /**
     * 删除
     *
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function delete()
    {
        if (empty($this->param['achievement_id'])) return resultArray(['error' => '参数错误！']);

        $model = new \app\crm\model\Achievement();
        $userInfo = $this->userInfo;
        if (!$model->delete($this->param['achievement_id'])) return resultArray(['error' => '操作失败！']);
        # 系统操作日志
        SystemActionLog($userInfo['id'], 'crm_number_sequence','customer', 1, 'update','业绩目标设置' , '', '','删除了业绩目标');
        return resultArray(['data' => '操作成功！']);
    }
}