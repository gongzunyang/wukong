<?php
// +----------------------------------------------------------------------
// | Description: 组织架构
// +----------------------------------------------------------------------
// | Author:  
// +----------------------------------------------------------------------

namespace app\admin\model;

use app\admin\controller\ApiCommon;
use app\admin\model\Common;
use think\Db;

class Structure extends Common 
{

    /**
     * 为了数据库的整洁，同时又不影响Model和Controller的名称
     * 我们约定每个模块的数据表都加上相同的前缀，比如CRM模块用crm作为数据表前缀
     */
	protected $name = 'admin_structure';

	/**
	 * [getDataList 获取列表]
	 * @return    [array]                         
	 */
	public function getDataList($type='')
	{	
		$cat = new \com\Category('admin_structure', array('id', 'pid', 'name', 'title'));
		$data = $cat->getList('', 0, 'id');
        foreach ($data as $k=>$v){
            $data[$k]['owner_user_name']=foreachData('admin_structure',$v['owner_user_id'])?:null;
            //选择部门传入当前部门权限范围内的员工
            $data[$k]['user_id']=$this->getSubUserByStructrue($v['id']);
        }
		// 若type为tree，则返回树状结构
		if ($type == 'tree') {
			$tree = new \com\Tree();
			$data = $tree->list_to_tree($data, 'id', 'pid', 'child', 0, true, array(''));
		}
		return $data;
	}
    //获取部门下权限范围内员工
    public function getSubUserByStructrue($param)
    {
        $userModel = model('User');
        $structureList = $userModel->getSubUserByStr($param, 1);
        if ($param) {
            $where['id'] = ['in', $structureList];
        }
        $list = Db::name('AdminUser')->field('id,realname')->where($where)->select();
        $list = $list ?: array();
        return $list;
    }
	/*
	*根据字符串展示参与部门 use by work
	*add by yykun
	*/
	public function getDataByStr($idstr)
	{
		$isArr = stringToArray($idstr);
		if (!$isArr) {
			return false;
		}
		$list = $this->field('id as structure_id,name')->where(['id' => ['in',$isArr]])->select();
		return $list;
	}
	
	/*
	*根据部门ID获取信息 use by work 
	*add by yykun
	*/
	public function getDataByID( $id ='')
	{
		$det = Db::name('AdminStructure')->where('id ='.$id)->find();
		return $det;
	}

	public function delStrById($id,$userId)
	{
		if (!$id) {
			$this->error = '删除失败';
			return false;
		}
		$dataInfo = $this->getDataByID($id);
		if (empty($dataInfo['pid'])) {
			$this->error = '删除失败';
			return false;			
		}
		//部门是否被使用
		$allStrIds = [];
		$allStrIds[] = $id;
		$allSubStrIds = $this->getAllChild($id);
		$allStrIds = array_merge($allStrIds, $allSubStrIds); //全部关联部门（包含下属部门）
		$resUser = db('AdminUser')->where(['structure_id' => ['in',$allStrIds]])->find();
		if ($resUser) {
			$this->error = '该部门或其下属部门已存在员工，不能删除';
			return false;
		}
		$resDel = $this->delDataById($id, true);
		if (!$resDel) {
			$this->error = '删除失败';
			return false;
		} else {
		    $content='删除了部门：'.$dataInfo['name'];
            # 添加记录
            SystemActionLog($userId, 'admin_structure','structures', $id,'delete', $dataInfo['name'], '', '', $content);
            return true;
		}	
	}

	/**
	 * [getStructureNameByArr 根据主键获取详情]
	 * @param     string     $id [主键]
	 * @return    [array]
	 */
	public function getStructureNameByArr($ids = [])
	{
		if (!is_array($ids)) {
			$idArr[] = $ids;
		} else {
			$idArr = $ids;
		}		
		$data = $this->where(['id' => array('in', $idArr)])->column('name');
		return $data ? : [];
	}

	/*
	*根据字符串展示参与部门 use by work
	*add by yykun
	*/
	public function getListByStr($str)
	{
		$idArr = stringToArray($str);
		$list = $this->field('id,name')->where(['id' => ['in',$idArr]])->select();
		return $list;
	}
}