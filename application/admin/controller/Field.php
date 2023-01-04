<?php
// +----------------------------------------------------------------------
// | Description: 自定义字段
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com 
// +----------------------------------------------------------------------

namespace app\admin\controller;

use app\admin\logic\FieldGrantLogic;
use app\crm\logic\VisitLogic;
use app\crm\model\Business;
use app\crm\model\Contacts;
use app\crm\model\Contract;
use app\crm\model\Customer;
use app\crm\model\InvoiceInfoLogic;
use app\crm\model\Leads;
use app\crm\model\Product;
use app\crm\model\Receivables;
use think\Hook;
use think\Request;
use think\Db;
use app\admin\model\User as UserModel;

class Field extends ApiCommon
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
            'allow'=>['index','getfield','update','read','config','validates','configindex','columnwidth','uniquefield']
        ];
        Hook::listen('check_auth',$action);
        $request = Request::instance();
        $a = strtolower($request->action());        
        if (!in_array($a, $action['permission'])) {
            parent::_initialize();
        }        
    }
    
    /**
     * 自定义字段列表
     */
    public function index()
    {  
        //权限判断
        if (!checkPerByAction('admin', 'crm', 'field')) {
            header('Content-Type:application/json; charset=utf-8');
            exit(json_encode(['code'=>102,'error'=>'无权操作']));
        }         
        $param = $this->param;
        $types_arr = [
            ['types' => 'crm_leads',            'name' => '线索管理'],
            ['types' => 'crm_customer',         'name' => '客户管理'],
            ['types' => 'crm_contacts',         'name' => '联系人管理'],
            ['types' => 'crm_business',         'name' => '商机管理'],
            ['types' => 'crm_contract',         'name' => '合同管理'],
            ['types' => 'crm_receivables',      'name' => '回款管理'],
            ['types' => 'crm_receivables_plan', 'name' => '回款计划管理'],
            ['types' => 'crm_invoice',          'name' => '发票管理'],
            ['types' => 'crm_visit',            'name' => '回访管理'],
            ['types' => 'crm_product',          'name' => '产品管理'],
        ];
        $examine_types_arr = [];    
        switch ($param['type']) {
            case 'crm' : $typesArr = $types_arr; break;
            case 'examine' : $typesArr = $examine_types_arr; break;
            default : $typesArr = $types_arr; break;
        }

        foreach ($typesArr as $k=>$v) {
            $updateTime = db('admin_field')->where(['types' => $v['types']])->max('update_time');

            $typesArr[$k]['update_time'] = !empty($updateTime) ? date('Y-m-d H:i:s', $updateTime) : '';
        }  
        return resultArray(['data' => $typesArr]);
    }    

    /**
     * 自定义字段数据
     */
    public function read()
    {
        $fieldModel = model('Field');
        $param = $this->param;
        $data = $fieldModel->getDataList($param);    
        if ($data === false) {
            return resultArray(['error' => $fieldModel->getError()]);
        }  
        return resultArray(['data' => $data]);
    }

    /**
     * 自定义字段创建
     */
    public function update()
    {
        # 系统审批类型暂不支持编辑
        if ($this->param['types'] == 'oa_examine' && $this->param['types_id'] < 7) {
            return resultArray(['error' => '系统审批类型暂不支持编辑']);
        }
        $userInfo=$this->userInfo;
        $fieldModel = model('Field');

        $param      = $this->param;
        $types      = $param['types'];
        $types_id   = $param['types_id'] ? : 0;

        $data         = $param['data'];
        $saveParam    = []; # 新增数据
        $updateParam  = []; # 编辑数据
        $delParam     = []; # 删除数据
        $fieldIds     = []; # 删除数据（兼容前端11.*.*版本）
        $errorMessage = []; # 错误数据
        $i = 0;
        foreach ($data AS $k => $v) {
            $i++;

            # 必填的字段不可以隐藏
            if (!empty($v['is_null']) && !empty($v['is_hidden'])) {
                $errorMessage = '必填的字段不可以隐藏！';
                break;
            }

            # 验证数字范围
            if (!empty($v['max_num_restrict']) && !empty($v['min_num_restrict']) && $v['min_num_restrict'] > $v['max_num_restrict']) {
                $errorMessage = '数字范围错误！';
                break;
            }

            # 验证百分数小数位
            if ($v['form_type'] == 'percent' && !empty($v['precisions']) && ($v['precisions'] < 1 || $v['precisions'] > 5)) {
                $errorMessage = '百分数字段类型的小数配置错误！';
                break;
            }

            # 验证数字小数位
            if ($v['form_type'] == 'number' && !empty($v['precisions']) && ($v['precisions'] < 1 || $v['precisions'] > 14)) {
                $errorMessage = '数字字段类型的小数配置错误！';
                break;
            }
            # 数组数据转换为字符串保存
            if ($v['form_type'] == 'date_interval') {
               $v['default_value']=trim((string)implode(',',$v['default_value']),'"');
            }
            if( $v['form_type']=='position'){
                    $v['default_value']=json_encode($v['default_value']);
            }
            # 数组数据转换为字符串保存
//            if (!empty($v['fieldExtendList'])) {
//                foreach ($v['fieldExtendList'] as $key=> $value){
//                    if($value['form_type']=='textarea'){
//                        $v['fieldExtendList'][$key]['default_value']=!empty($value['default_value'])?(string)trim("'".$value['default_value']."'",'"'):'';
//                    }
//                }
//            }

            if ($v['field_id']) {
                if (isset($v['is_deleted']) && $v['is_deleted'] == '1') {
                    # 删除
                    $delParam[] = $v['field_id']; //删除
                } else {
                    # 编辑
                    $updateParam[$k] = $v;
                    $updateParam[$k]['order_id'] = $i;
                    # 用来删除自定义字段（兼容前端11.*.*版本）：记录存在的自定义字段ID，取出差集，就是要删的数。
                    $fieldIds[] = $v['field_id'];
                }
            } else {
                # 新增
                $saveParam[$k] = $v;
                $saveParam[$k]['order_id'] = $i;
                $saveParam[$k]['types_id'] = $types_id;
            }
        }
        # 必填的字段不可以隐藏
        if ($errorMessage) return resultArray(['error' => $errorMessage]);

        # 兼容前端11.*.*版本的删除条件处理，通过比较差异，来确定谁被前端给删除了 todo 这段代码需要写在新增上面，不然会把新增的给删除掉
        // $oldFieldIds = Db::name('admin_field')->where('types', $types)->column('field_id');  新增自定义字段时 成交状态被删除
        if($types != 'crm_customer'){
            $oldFieldIds = Db::name('admin_field')->where('types', $types)->column('field_id');
        }else{
            $oldFieldIds = Db::name('admin_field')->where('types', $types)->where(['field'=>['not in', ['deal_status']]])->column('field_id');
        }
        
        $deleteIds   = array_diff($oldFieldIds, $fieldIds);
        foreach ($deleteIds AS $key => $value) {
            if (!in_array($value, $delParam)) $delParam[] = $value;
        }
        # 新增
        if (!empty($saveParam)) {
            if (!$data = $fieldModel->createData($types, $saveParam)) {
                $errorMessage[] = $fieldModel->getError();
            }
        }
        # 编辑
        if (!empty($updateParam)) {
            if (!$data = $fieldModel->updateDataById($updateParam, $types)) {
                $errorMessage[] = $fieldModel->getError();
            }
        }

        # 删除
        if (!empty($delParam)) {
            if (!$data = $fieldModel->delDataById($delParam, $types)) {
                $errorMessage[] = $fieldModel->getError();
            }
        }

        # 自定义字段变更后，同步更新字段授权表
        (new FieldGrantLogic())->fieldGrantDiyHandle($types);
        
        if ($errorMessage) {
            return resultArray(['error' => $errorMessage]);
        } else {
            # 系统操作记录
            $recordModules = [
                'crm_leads'       => '线索',
                'crm_customer'    => '客户',
                'crm_pool'        => '客户公海',
                'crm_contacts'    => '联系人',
                'crm_product'     => '产品',
                'crm_business'    => '商机',
                'crm_contract'    => '合同',
                'crm_receivables' => '回款',
                'crm_visit'       => '回访',
                'crm_invoice'     => '回款',
                'oa_log'          => '办公日志',
                'oa_examine'      => '办公审批',
            ];
            if ($types !== 'oa_examine') {
                $systemModules = 'customer';
            } else {
                $systemModules = 'approval';
            }
            SystemActionLog($userInfo['id'], $types,$systemModules, 1,  'update', $recordModules[$types], '','','编辑了自定义字段：'.$recordModules[$types]);
            return resultArray(['data' => '修改成功']);
        }
    }

    /**
     * 自定义字段数据获取
     *
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getField()
    {
        $fieldModel = model('Field');
        $userModel = model('User');
        $param = $this->param;
        $module = trim($param['module']);
        $controller = trim($param['controller']);
        $action = trim($param['action']);
        $system = !empty($param['system']) ? $param['system'] : 0;
        $format = !empty($param['format']) ? $param['format'] : 1; // 设置返回数据的格式类型：1 还是之前的二维数组格式，兼容移动端、 2 三维数组，新版自定义字段的分组排序。
        unset($param['system']);
        
        if (!$module || !$controller || !$action) {
            return resultArray(['error' => '参数错误']);
        }
        //判断权限
        $userInfo = $this->userInfo;
        $user_id = $userInfo['id'];
        $types = $param['types'];
        $types_id = $param['types_id'] ? : '';
        $dataInfo = [];
        if ($action == 'read' || $action == 'update') {
            //获取详情数据
            if (($param['action'] == 'update' || $param['action'] == 'read') && $param['action_id']) {
                $model='';
                if($param['action'] == 'update'){
                    $model='update';
                }
                switch ($param['types']) {
                    case 'crm_customer' : 
                        $customerModel = new \app\crm\model\Customer();
                        $dataInfo = $customerModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'customer', $param['action']);
                        //读写权限
                        $roPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'read');
                        $rwPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'update');
                        //判断是否客户池数据
                        $wherePool = $customerModel->getWhereByPool();
                        $resPool = db('crm_customer')->alias('customer')->where(['customer_id' => $param['action_id']])->where($wherePool)->find();
                        if (!$resPool && !in_array($dataInfo['owner_user_id'],$auth_user_ids) && !$roPre && !$rwPre) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_leads' : 
                        $leadsModel = new \app\crm\model\Leads();
                        $dataInfo = $leadsModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'leads', $param['action']);

                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids)) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }                        
                        break;  
                    case 'crm_contacts' : 
                        $contactsModel = new \app\crm\model\Contacts();
                        $dataInfo = $contactsModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'contacts', $param['action']);
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids)) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }                          
                        break;
                    case 'crm_business' :
                        $businessModel = new \app\crm\model\Business();
                        $dataInfo = $businessModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'business', $param['action']);
                        //读写权限
                        $roPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'read');
                        $rwPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'update');
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids) && !$roPre && !$rwPre) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_contract' : 
                        $contractModel = new \app\crm\model\Contract();
                        $dataInfo = $contractModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'contract', $param['action']);
                        //读写权限
                        $roPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'read');
                        $rwPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'update');
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids) && !$roPre && !$rwPre) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_product' : 
                        $productModel = new \app\crm\model\Product();
                        $dataInfo = $productModel->getDataById($param['action_id'],'',$model);

                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'product', $param['action']);
                        if (!in_array($dataInfo['owner_user_id'], $auth_user_ids)) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_receivables' : 
                        $receivablesModel = new \app\crm\model\Receivables();
                        $dataInfo = $receivablesModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'receivables', $param['action']);
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids)) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_receivables_plan' : 
                        $receivablesPlanModel = new \app\crm\model\ReceivablesPlan();
                        $dataInfo = $receivablesPlanModel->getDataById($param['action_id'],'',$model);
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'receivables_plan', $param['action']);
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids)) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break; 
                    case 'oa_examine' :
                        $examineModel = new \app\oa\model\Examine();  
                        $examineFlowModel = new \app\admin\model\ExamineFlow();  
                        $dataInfo = $examineModel->getDataById(intval($param['action_id']));
                        # 前端没有传types_id,这里需要指定一下types_id
                        if (!empty($dataInfo['category_id'])) $param['types_id'] = $dataInfo['category_id'];
                        $adminIds = $userModel->getAdminId(); //管理员
                        $checkUserIds = $examineFlowModel->getUserByFlow($dataInfo['flow_id'], $dataInfo['create_user_id'], $dataInfo['check_user_id']);
                        if (((int)$dataInfo['create_user_id'] != $user_id && !in_array($user_id,$adminIds) && !in_array($user_id,$checkUserIds))) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }                        
                        break;
                    case 'crm_visit' :
                        $visit = new \app\crm\model\Visit();
                        $dataInfo = $visit->getDataById($param['action_id'],'',$model);
                        $fieldModel = new \app\admin\model\Field();
                        $datetimeField = $fieldModel->getFieldByFormType('crm_visit', 'datetime'); //日期时间类型
                        foreach ($datetimeField as $key => $val) {
                            $dataInfo[$val] = !empty($dataInfo[$val]) ? date('Y-m-d H:i:s', $dataInfo[$val]) : null;
                        }
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'visit', $param['action']);
                        //读写权限
                        $roPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'read');
                        $rwPre = $userModel->rwPre($user_id, $dataInfo['ro_user_id'], $dataInfo['rw_user_id'], 'update');
                        if (!in_array($dataInfo['owner_user_id'],$auth_user_ids) && !$roPre && !$rwPre) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                    case 'crm_invoice' :
                        $Invoice = new \app\crm\model\Invoice();
                        $dataInfo = $Invoice->getDataById($param['action_id'],'',$model);
                        $fieldModel = new \app\admin\model\Field();
                        $datetimeField = $fieldModel->getFieldByFormType('crm_invoice', 'datetime'); //日期时间类型
                        foreach ($datetimeField as $key => $val) {
                            $dataInfo[$val] = !empty($dataInfo[$val]) ? date('Y-m-d H:i:s', $dataInfo[$val]) : null;
                        }
                        //判断权限
                        $auth_user_ids = $userModel->getUserByPer('crm', 'invoice', $param['action']);
                       
                        if (!in_array($user_id, stringToArray($dataInfo['owner_user_id'])) && !in_array($user_id,$auth_user_ids) ) {
                            header('Content-Type:application/json; charset=utf-8');
                            exit(json_encode(['code'=>102,'error'=>'无权操作']));
                        }
                        break;
                } 
            }
        }
        $param['user_id'] = $user_id;
        $action_id = $param['action_id'] ? : '';
        $data = $fieldModel->field($param, $dataInfo) ? : [];
        # 多公海数据详情
        if (!empty($param['pool_id']) && $param['action'] == 'read') {
            $data = $this->setPoolDetailData($data, $param['pool_id'], $param['action_id']);
        }

        # 回访模块下，负责人名称变更为回访人
        if ($param['types'] == 'crm_visit') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'owner_user_id') {
                    $data[$key]['name'] = '回访人';
                    break;
                }
            }
        }
        # 去掉客户模块下的成交信息
        if ($param['types'] == 'crm_customer' && $param['action'] == 'read') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'deal_status') {
                    unset($data[(int)$key]);
                    break;
                }
            }
        }
        # 合同回款 基本信息审核状态
        if(in_array($param['types'], ['crm_receivables', 'crm_contract']) && $param['action'] == 'read'){
            $check=['0'=>'待审核','1'=>'审核中','2'=>'审核通过','3'=>'审核未通过','4'=>'撤销','5'=>'草稿(未提交)','6'=>'作废'];
            $data[] = [
                'field'       => 'check_status',
                'name'        => '审核状态',
                'form_type'   => 'text',
                'writeStatus' => 0,
                'fieldName'   => 'check_status',
                'value'     => $check[$dataInfo['check_status']],
            ];
        }
        # 合同自动编号设置
        if ($param['types'] == 'crm_contract') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'num') {
                    if ($this->getAutoNumberStatus(1)) {
                        $data[$key]['is_null']   = 0;
                        $data[$key]['is_unique'] = 0;
                    }
                    $data[$key]['autoGeneNumber'] = $this->getAutoNumberStatus(1) ? 1 : 0;
                }
            }
        }
        # 回款自动编号设置
        if ($param['types'] == 'crm_receivables') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'number') {
                    if ($this->getAutoNumberStatus(2)) {
                        $data[$key]['is_null']   = 0;
                        $data[$key]['is_unique'] = 0;
                    }
                    $data[$key]['autoGeneNumber'] = $this->getAutoNumberStatus(2) ? 1 : 0;
                }
            }
        }
        # 回访自动编号设置
        if ($param['types'] == 'crm_visit') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'number') {
                    if ($this->getAutoNumberStatus(3)) {
                        $data[$key]['is_null']   = 0;
                        $data[$key]['is_unique'] = 0;
                    }
                    $data[$key]['autoGeneNumber'] = $this->getAutoNumberStatus(3) ? 1 : 0;
                }
            }
        }
        # 发票自动编号设置
        if ($param['types'] == 'crm_invoice') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'invoice_apple_number') {
                    if ($this->getAutoNumberStatus(4)) {
                        $data[$key]['is_null']   = 0;
                        $data[$key]['is_unique'] = 0;
                    }
                    $data[$key]['autoGeneNumber'] = $this->getAutoNumberStatus(4) ? 1 : 0;
                }
            }
        }

        # 隐藏回款计划中的附件
        if ($param['types'] == 'crm_receivables_plan') {
            foreach ($data AS $key => $value) {
                if ($value['field'] == 'file') {
                    unset($data[(int)$key]);
                }
            }
        }
        
        if (!empty($system) && $system == 1) {
            # 商机和合同排除产品字段
            if (in_array($param['types'], ['crm_business', 'crm_contract'])) {
                foreach ($data AS $key => $value) {
                    if ($value['field'] == 'product' && $value['name'] == '产品') {
                        unset($data[(int)$key]);
                        break;
                    }
                }
            }
            $data = array_values($data);

            # 系统信息
            switch ($types) {
                case 'crm_leads' :
                    $leadsModel = new Leads();
                    $leadsData  = $leadsModel->getSystemInfo($action_id);
                    $leadsArray = ['create_user_id' => '创建人' ,'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间', 'last_time' => '最后跟进时间'];

                    foreach ($leadsData AS $key => $value) {
                        if (empty($leadsArray[$key]) ) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $leadsArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_customer' :
                    $customerModel = new Customer();
                    $customerData  = $customerModel->getSystemInfo($action_id);
                    $customerArray = ['obtain_time' => '负责人获取客户时间', 'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_user_id' => '创建人', 'create_time' => '创建时间', 'update_time' => '更新时间', 'last_time' => '最后跟进时间', 'last_record' => '最后跟进记录', 'deal_status' => '成交状态'];
                    foreach ($customerData AS $key => $value) {
                        if (empty($customerArray[$key]) || (!empty($param['pool_id']) && in_array($key, ['obtain_time', 'owner_user_id']))) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $customerArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_contacts' :
                    $contactsModel = new Contacts();
                    $contactsData  = $contactsModel->getSystemInfo($action_id);
                    $contactsArray = ['create_user_id' => '创建人' ,'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间', 'last_time' => '最后跟进时间'];

                    foreach ($contactsData AS $key => $value) {
                        if (empty($contactsArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $contactsArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_business' :
                    $businessModel = new Business();
                    $businessData  = $businessModel->getSystemInfo($action_id);
                    $businessArray = ['create_user_id' => '创建人' ,'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间', 'last_time' => '最后跟进时间'];

                    foreach ($businessData AS $key => $value) {
                        if (empty($businessArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $businessArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_contract' :
                    $contractModel = new Contract();
                    $contractData  = $contractModel->getSystemInfo($action_id);
                    $contractArray = ['create_user_id' => '创建人','owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间', 'last_time' => '最后跟进时间', 'done_money' => '已收款金额', 'un_money' => '未收款金额'];

                    foreach ($contractData AS $key => $value) {
                        if (empty($contractArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $contractArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_receivables' :
                    $receivablesModel = new Receivables();
                    $receivablesData  = $receivablesModel->getSystemInfo($action_id);
                    $receivablesArray = ['create_user_id' => '创建人','owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间'];

                    foreach ($receivablesData AS $key => $value) {
                        if (empty($receivablesArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $receivablesArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_product' :
                    $productModel = new Product();
                    $productData  = $productModel->getSystemInfo($action_id);
                    $productArray = ['create_user_id' => '创建人' ,'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间'];

                    foreach ($productData AS $key => $value) {
                        if (empty($productArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $productArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_visit' :
                    $visitLogic = new VisitLogic();
                    $visitData  = $visitLogic->getSystemInfo($action_id);
                    $visitArray = ['create_user_id' => '创建人' ,'owner_user_id' => '负责人', 'owner_user_structure_name' => '所属部门', 'create_time' => '创建时间', 'update_time' => '更新时间'];

                    foreach ($visitData AS $key => $value) {
                        if (empty($visitArray[$key])) continue;

                        $data[] = [
                            'field'     => $key,
                            'name'      => $visitArray[$key],
                            'form_type' => strpos($key, 'time') ? 'datetime' : 'text',
                            'value'     => $value,
                            'system'    => 1
                        ];
                    }
                    break;
                case 'crm_invoice' :
                    $invoiceData = db('crm_invoice')->field(['create_user_id', 'owner_user_id', 'create_time', 'update_time'])->where('invoice_id', $action_id)->find();
                    
                    $createUserName = db('admin_user')->where('id', $invoiceData['create_user_id'])->value('realname');
                    $data[] = ['field' => 'create_user_id', 'name' => '创建人', 'form_type' => 'user', 'value' => $createUserName, 'system' => 1];
                    $data[] = ['field' => 'create_time', 'name' => '创建时间', 'form_type' => 'datetime', 'value' => date('Y-m-d H:i:s', $invoiceData['create_time']), 'system' => 1];
                    $data[] = ['field' => 'update_time', 'name' => '更新时间', 'form_type' => 'datetime', 'value' => date('Y-m-d H:i:s', $invoiceData['update_time']), 'system' => 1];
                    
                    # zjf   20210726
                    $userModel   = new \app\admin\model\User();
                    $ownerUserInfo = $userModel->getUserById($invoiceData['owner_user_id']);
                    $data[] = ['field' => 'owner_user_id', 'name' => '负责人', 'form_type' => 'user', 'value' => $ownerUserInfo['realname'], 'system' => 1];
                    $data[] = ['field' => 'owner_user_structure_name', 'name' => '所属部门', 'form_type' => 'text', 'value' => $ownerUserInfo['structure_name'], 'system' => 1];
                    
            }
        }

        # 处理自定义字段别名、权限
        $data = $fieldModel->resetField($user_id, $param['types'], $param['action'], $data);
        # 处理自定义字段分组排序
        if (in_array($param['action'], ['save', 'update', 'relative']) && $format == 2) $data = getFieldGroupOrderData($data);

        return resultArray(['data' => array_values($data)]);
    }

    /**
     * 自定义字段数据验重
     *
     * @return \think\response\Json
     */
    public function validates()
    {
        $param = $this->param;
        $fieldModel = model('Field');
        $res = $fieldModel->getValidate(trim($param['field']), $param['val'], intval($param['id']), trim($param['types']));
        if (!$res) {
            return resultArray(['error' => $fieldModel->getError()]);
        }
        return resultArray(['data' => '验证通过']);
    }

    /**
     * 自定义字段列表设置（排序、展示、列宽度）
     * @param types 分类
     * @param value 值
     */
    public function config()
    {
        $param = $this->param;
        $userInfo = $this->userInfo;
        $param['user_id'] = $userInfo['id'];
        $userFieldModel = model('UserField');
        $res = $userFieldModel->updateConfig($param['types'], $param);
        if (!$res) {
            return resultArray(['error' => $userFieldModel->getError()]);
        }
        return resultArray(['data' => '设置成功']);
    } 

    /**
     * 自定义字段列宽度设置
     * @param types 分类
     * @param field 字段名
     * @param width 列宽度
     */
    public function columnWidth()
    {
        $param = $this->param;
        $userInfo = $this->userInfo;
        $userFieldModel = model('UserField');
        $width = $param['width'] > 10 ? $param['width'] : '';
        $unField = array('pool_day','owner_user_name','is_lock','create_user_name','owner_user_structure_name');
        switch ($param['field']) {
        	case 'status_id_info' : $param['field'] = 'status_id';
        		break;
        }
        if (!in_array($param['field'],$unField)) {
            $res = $userFieldModel->setColumnWidth($param['types'], $param['field'], $width, $userInfo['id']);
            if (!$res) {
                return resultArray(['error' => $userFieldModel->getError()]);
            }            
        }
        return resultArray(['data' => '设置成功']);
    }

    /**
     * 自定义字段列表设置数据
     * @param types 分类
     * @param value 值
     */
    public function configIndex()
    {
        $param = $this->param;
        $userInfo = $this->userInfo;
        $userFieldModel = model('UserField');
        $res = $userFieldModel->getDataList($param['types'], $userInfo['id']);
        if (!$res) {
            return resultArray(['error' => $userFieldModel->getError()]);
        }
        return resultArray(['data' => $res]);
    }

    /**
     * 自定义验重字段
     * @param types 分类
     * @param
     */
    public function uniqueField()
    {
        $param = $this->param;
        if ($param['types'] == 'crm_user') {
            $list = array_filter(UserModel::$import_field_list, function ($val) {
                return $val['is_unique'] == 1;
            });
            $list = array_column($list, 'name');
        } else {
            $list = db('admin_field')->where(['types' => $param['types'],'is_unique' => 1])->column('name');
        }
        $list = $list ? implode(',',$list) : '无';
        return resultArray(['data' => $list]);
    }

    /**
     * 获取自动编号状态
     *
     * @param $type
     * @return int|mixed|string|null
     */
    private function getAutoNumberStatus($type)
    {
        return Db::name('crm_number_sequence')->where('number_type', $type)->where('status', 0)->value('number_sequence_id');
    }

    /**
     * 处理公海详情数据
     *
     * @param $data array 公海数据
     * @param $poolId int 公海ID
     * @param $actionId int  数据ID
     * @author fanqi
     * @since 2021-06-21
     * @return array
     */
    private function setPoolDetailData($data, $poolId, $actionId)
    {
        $poolData = [];

        $poolList = db('crm_customer_pool_field_setting')->field(['field_name', 'is_hidden'])->where('pool_id', $poolId)->select();

        // 组装字段数据
        foreach ($poolList AS $key => $value) {
            $poolData[$value['field_name']] = $value['is_hidden'];
        }

        // 处理公海数据
        foreach ($data AS $key => $value) {
            if (!empty($poolData[$value['field']]) || $value['field'] == 'owner_user_id') {
                unset($data[(int)$key]);

                continue;
            }
        }

        // 前负责人
        $beforeUser = db('crm_customer')->alias('customer')
            ->join('__ADMIN_USER__ user', 'user.id = customer.before_owner_user_id', 'left')
            ->field(['user.id', 'user.username', 'user.realname', 'user.thumb_img'])
            ->where('customer_id', $actionId)
            ->find();
        if (!empty($beforeUser['thumb_img'])) $beforeUser['thumb_img'] = getFullPath($beforeUser['thumb_img']);

        $data[] = [
            'field'         => 'before_owner_user_id',
            'name'          => '前负责人',
            'form_type'     => 'user',
            'writeStatus'   => 0,
            'fieldName'     => 'before_owner_user_id',
            'value'         => [$beforeUser],
            'setting'       => [],
            'default_value' => [],
            'options'       => '',
            'optionsData'   => ''
        ];

        return array_values($data);
    }
}
