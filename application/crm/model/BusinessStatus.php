<?php
// +----------------------------------------------------------------------
// | Description: 商机组
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com
// +----------------------------------------------------------------------
namespace app\crm\model;

use app\admin\controller\ApiCommon;
use think\Db;
use app\admin\model\Common;
use think\Request;
use think\Validate;

class BusinessStatus extends Common
{
	/**
     * 为了数据库的整洁，同时又不影响Model和Controller的名称
     * 我们约定每个模块的数据表都加上相同的前缀，比如CRM模块用crm作为数据表前缀
     */
	protected $name = 'crm_business_status';

	/**
     * [getDataList 商机状态list]
     * @author Michael_xu
     * @param  type_id  商机组ID
     * @return 
     */		
	public function getDataList($type_id, $type = 0)
    {  	
    	if ($type == 1) {
    		$list = $this->where(['type_id' => $type_id])->whereOr(['type_id' => 0])->select();
    	} else {
    		$list = $this->where(['type_id' => $type_id])->select();
    	}
        return $list ? : [];
    }

	/**
     * [getTypeList 商机组list]
     * @author Michael_xu
     * @param     [string]                   $map [查询条件]
     * @param     [number]                   $page     [当前页数]
     * @param     [number]                   $limit    [每页数量]
     * @return    [array]                    [description]
     */		
	public function getTypeList($request)
    {
        # H5不传page和limit（查全部），商机组不会有太多，把limit设置大一些就行。
        if (empty($request['limit'])) $request['limit'] = 100;
        if (empty($request['page']))  $request['page'] = 1;

    	$userModel = new \app\admin\model\User();
    	$structureModel = new \app\admin\model\Structure();
        $request = $this->fmtRequest( $request );
        $map = $request['map'] ? : [];
        if (isset($map['search']) && $map['search']) {
			//普通筛选
			$map['name'] = ['like', '%'.$map['search'].'%'];
		}

        $map['is_display'] = ['eq', 1];
		unset($map['search']);
		$list = db('crm_business_type')
				->where($map)
        		->page($request['page'], $request['limit'])
        		->select();

        $dataCount = db('crm_business_type')->where($map)->count('type_id');
        foreach ($list as $k=>$v) {
        	$list[$k]['create_user_id_info'] = $userModel->getUserById($v['create_user_id']); 
        	$list[$k]['structure_id_info'] = $structureModel->getListByStr($v['structure_id']) ? : [];
        	$list[$k]['create_time'] = !empty($v['create_time']) ? date('Y-m-d H:i:s', $v['create_time']) : null;
            $list[$k]['update_time'] = !empty($v['update_time']) ? date('Y-m-d H:i:s', $v['update_time']) : null;
            $list[$k]['status_list'] = db('crm_business_status')->where('type_id', $v['type_id'])->order('order_id', 'asc')->select();
        }    
        $data = [];
        $data['list'] = $list;
        $data['dataCount'] = $dataCount ? : 0;

        return $data;
    }    

	/**
	 * 创建商机组
	 * @author Michael_xu
	 * @param  
	 * @return                            
	 */	
	public function createData($param)
	{
		if (!$param['name']) {
			$this->error = '请填写商机组名称';
			return false;
		}
		if (!$param['status']) {
			$this->error = '请至少配置一个商机阶段';
			return false;			
		}
		$data = [];
		$data['name'] = $param['name'];
		$data['update_time'] = time();
		$data['create_time'] = time();
		$data['create_user_id'] = $param['create_user_id'];
		$data['structure_id'] = arrayToString($param['structure_id']);
		if ($type_id = db('crm_business_type')->insertGetId($data)) {
			$statusData = [];
			$i = 1;
			foreach ($param['status'] as $k=>$v) {
				//$v = json_decode($v,true);
				$statusData[$k]['name'] = $v['name'];
				$statusData[$k]['rate'] = $v['rate'];
				$statusData[$k]['type_id'] = $type_id;
				$statusData[$k]['order_id'] = $i;
				if (empty($v['name']) && empty($v['rate'])) {
	    			unset($statusData[$k]);
	    		} else {
	    			$i++;
	    		}
			}
			db('crm_business_status')->insertAll($statusData);
			# 系统操作日志
            SystemActionLog($param['create_user_id'], 'crm_business','customer', $type_id, 'save',$param['name'] , '', '','添加了商机组：'.$param['name']);
            return true;
		} else {
			$this->error = '添加失败';
			return false;
		} 			
	}

	/**
	 * 编辑商机组信息
	 * @author Michael_xu
	 * @param  type_id 商机组类型ID
	 * @return                            
	 */	
	public function updateDataById($param, $type_id = '')
	{
		$dataInfo = db('crm_business_type')->where(['type_id' => $type_id])->find();
		if (!$dataInfo) {
			$this->error = '数据不存在或已删除';
			return false;
		}
		//过滤不能修改的字段
		$unUpdateField = ['create_user_id'];
		foreach ($unUpdateField as $v) {
			unset($param[$v]);
		}
		
		if (!$param['name']) {
			$this->error = '请填写商机组名称';
			return false;
		}
		if (!$param['status']) {
			$this->error = '请至少配置一个商机阶段';
			return false;			
		}

		$data = [];
		$data['name'] = $param['name'];
		$data['structure_id'] = arrayToString($param['structure_id']);

		$newIds = []; //编辑ID
		$statusData = [];
		$resData = true;

		// 启动事务
		Db::startTrans();
		try {
			db('crm_business_type')->where(['type_id' => $type_id])->update($data);
			$i = 1;
			foreach ($param['status'] as $k=>$v) {
				$statusData[$k]['name'] = $v['name'];
				$statusData[$k]['rate'] = $v['rate'];
				$statusData[$k]['type_id'] = $type_id;
				$statusData[$k]['order_id'] = $i;

				if ($v['status_id']) {
	    			//编辑
	    			$newIds[] = $v['status_id'];
	    			$statusData[$k]['status_id'] = $v['status_id'];
	    			$this->isUpdate()->saveAll($statusData);
	    			unset($statusData[$k]);
	    		}
	    		if (empty($v['name']) && empty($v['rate'])) {
	    			unset($statusData[$k]);
	    		} else {
	    			$i++;
	    		}
			}
			//删除
	    	$oldIds = $this->where(['type_id' => $type_id])->column('status_id'); //原ID
	    	$delIds = array_diff($oldIds, $newIds); //数组差集
	    	if ($delIds) {
	    		db('crm_business_status')->where(['status_id' => ['in',$delIds]])->delete();
	    	}
			//新增
			db('crm_business_status')->insertAll($statusData);
			// 提交事务
    		Db::commit();
    		# 系统操作日志
            SystemActionLog($param['user_id'], 'crm_business','customer', $type_id, 'update',$dataInfo['name'] , '', '','编辑了商机组：'.$dataInfo['name']);
            return true;
		} catch (\Exception $e) {
			$this->error = '编辑失败';
			// 回滚事务
		    Db::rollback();					
    		return false;   				    
		}				
	}

	/**
     * 商机组数据
     * @param  $status_id 商机组ID
     * @return 
     */	
   	public function getDataById($type_id = '')
   	{
		if (!$data = db('crm_business_type')->where(['type_id' => $type_id])->find()) {
			$this->error = '数据不存在或已删除';
			return false;
		}
		$status = $this->getDataList($type_id);
        $data['structure_id'] = !empty($data['structure_id']) ? stringToArray($data['structure_id']) : [];
		$data['status'] = $status ? : [];
		return $data;
   	}

	/**
	 * [delDataById 根据id删除数据]
	 * @param     string                   $param['id']     [主键]
	 * @param     boolean                  $delSon [是否删除子孙数据]
	 * @return    [type]                           [description]
	 */
	public function delDataById($param = '', $delSon = false)
	{
		if (!$param['id']) {
			$this->error = '删除失败';
			return false;
		}
		//状态组已被使用，则不能删除
		$resDel = true;
//		if (db('crm_business')->where(['type_id' => $id])->find()) {
//			$this->error = '状态组已被使用，不能删除';
//			return false;
//		}
		//启动事务
		Db::startTrans();
		try {
            db('crm_business_type')->where(['type_id' => $param['id']])->update(['is_display' => 0]);
			// 提交事务
    		Db::commit();
            # 系统操作日志
            $data=db('crm_business_type')->where(['type_id' => $param['id']])->find();
            SystemActionLog($param['user_id'], 'crm_business','customer', $param['id'],  'update',$data['name'] , '', '','删除了商机组：'.$data['name']);
            
            return true;
		} catch(\Exception $e) {
			$this->error = '删除失败';
			// 回滚事务
			Db::rollback();	
			return false;
		}		
	}	   	
}