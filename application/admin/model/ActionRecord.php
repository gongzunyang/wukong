<?php
// +----------------------------------------------------------------------
// | Description: 字段修改记录
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com 
// +----------------------------------------------------------------------

namespace app\admin\model;

use app\admin\model\Common;

class ActionRecord extends Common 
{
    /**
     * 为了数据库的整洁，同时又不影响Model和Controller的名称
     * 我们约定每个模块的数据表都加上相同的前缀，比如CRM模块用crm作为数据表前缀
     */
	protected $name = 'admin_action_record';
	public $typesArr = ['crm_leads','crm_customer','crm_contacts','crm_product','crm_business','crm_contract','crm_receivables','crm_visit','jxc_product','jxc_supplier','jxc_purchase','jxc_retreat','jxc_sale','jxc_salereturn','jxc_receipt','jxc_outbound','jxc_payment','jxc_collection','jxc_inventory','jxc_allocation'];

	/**
	 * [getDataList 获取列表]
	 * @return    [array]                         
	 */
	public function getDataList($request)
	{
		$types = trim($request['types']);
		$action_id = intval($request['action_id']);
		//判断权限
		if (!$this->checkData($types, $action_id, $request['user_id'])) {
			return [];
		}
		$dataList = db('admin_action_record')->where(['types' => $types,'action_id' => $action_id])->order('id','desc')->select();
		if($types == 'crm_customer') {
			$leads_id = db('crm_leads')->where(['customer_id' => $action_id, 'is_transform' => 1])->value('leads_id');
			if($leads_id){
				$leads_dataList = db('admin_action_record')->where(['types' => 'crm_leads','action_id' => $leads_id])->order('id','desc')->select();
				$dataList = array_merge($leads_dataList, $dataList);
                # 对线索和客户的合并数据进行排序
                $sortData = array_column($dataList, 'create_time');
                array_multisort($sortData,SORT_DESC , $dataList);
			}
		}
		$userModel = model('User');
		foreach ($dataList as $k=>$v) {
			$dataList[$k]['user_id_info'] = $v['user_id']!=0 ? $userModel->getUserById($v['user_id']) : '系统';
			$dataList[$k]['content'] = explode('.|.', $v['content']);
		}
		return $dataList;
	}

	/**
	 * [checkData 权限判断]
	 * @return    [array]                         
	 */	
	public function checkData($types, $action_id, $user_id)
	{
		if (!in_array($types, $this->typesArr)) {
			return false;
		}
		if (!$action_id) {
			return false;
		}
		$adminTypes = adminGroupTypes($user_id);
        if (in_array(1,$adminTypes)) {
            return true;
        }

		$checkRes = false;
		switch ($types) {
			case 'crm_leads' :
				$checkRes = checkPerByAction('crm', 'leads', 'read');
				break;			
			case 'crm_customer' :
				$checkRes = checkPerByAction('crm', 'customer', 'read');
				break;
			case 'crm_contacts' :
				$checkRes = checkPerByAction('crm', 'contacts', 'read');
				break;
			case 'crm_product' :
				$checkRes = checkPerByAction('crm', 'product', 'read');
				break;
			case 'crm_business' :
				$checkRes = checkPerByAction('crm', 'business', 'read');
				break;			
			case 'crm_contract' :
				$checkRes = checkPerByAction('crm', 'contract', 'read');
				break;	
			case 'crm_receivables' :
				$checkRes = checkPerByAction('crm', 'receivables', 'read');
				break;	
			case 'crm_visit' :
				$checkRes = checkPerByAction('crm', 'visit', 'read');
				break;
			case 'jxc_product': $checkRes = checkPerByAction('jxc', 'product', 'read'); break;
            case 'jxc_supplier': $checkRes = checkPerByAction('jxc', 'supplier', 'read'); break;
            case 'jxc_purchase': $checkRes = checkPerByAction('jxc', 'purchase', 'read'); break;
            case 'jxc_retreat': $checkRes = checkPerByAction('jxc', 'retreat', 'read'); break;
            case 'jxc_sale': $checkRes = checkPerByAction('jxc', 'sale', 'read'); break;
            case 'jxc_salereturn': $checkRes = checkPerByAction('jxc', 'salereturn', 'read'); break;
            case 'jxc_receipt': $checkRes = checkPerByAction('jxc', 'receipt', 'read'); break;
            case 'jxc_outbound': $checkRes = checkPerByAction('jxc', 'outbound', 'read'); break;
            case 'jxc_payment': $checkRes = checkPerByAction('jxc', 'payment', 'read'); break;
            case 'jxc_collection': $checkRes = checkPerByAction('jxc', 'collection', 'read'); break;
            case 'jxc_inventory': $checkRes = checkPerByAction('jxc', 'inventory', 'read'); break;
            case 'jxc_allocation': $checkRes = checkPerByAction('jxc', 'allocation', 'read'); break;							
		}
		if ($checkRes !== false) {
			return true;
		}
	}

	/**
     * 删除字段修改记录
     * @param 
     * @return
     */
	public function delDataById($request)
	{
		$types = trim($request['types']);
		$action_id = $request['action_id'];
		if ($types && $action_id) {
			$res = db('admin_action_record')->where(['types' => $types,'action_id' => ['in',$action_id]])->delete();
		}
	}    	
}