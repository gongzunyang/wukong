<?php

namespace app\crm\logic;

use app\admin\controller\ApiCommon;
use app\admin\model\Common;
use app\admin\traits\FieldVerificationTrait;
use app\crm\model\Visit;
use think\Db;

class VisitLogic extends Common
{
    use FieldVerificationTrait;

    /**
     * 获取回访列表
     * @param $param
     */
    public function getDataList($request)
    {
        $userModel = new \app\admin\model\User();
        $structureModel = new \app\admin\model\Structure();
        $fieldModel = new \app\admin\model\Field();
        $user_id = $request['user_id'];
        //场景id
        $scene_id = (int)$request['scene_id'];
        $order_field = $request['order_field'];
        $order_type = $request['order_type'];
        unset($request['search']);
        unset($request['scene_id']);
        unset($request['user_id']);
        unset($request['order_field']);
        unset($request['order_type']);
        $request = $this->fmtRequest($request);
        $requestMap = $request['map'] ?: [];
        $sceneModel = new \app\admin\model\Scene();
        if ($scene_id) {
            //自定义场景
            $sceneMap = $sceneModel->getDataById($scene_id, $user_id, 'crm_visit') ?: [];
        } else {
            //默认场景
            $sceneMap = $sceneModel->getDefaultData('crm_visit', $user_id) ?: [];
        }

        $partMap = [];
        //优先级：普通筛选>高级筛选>场景添加
        if ($sceneMap['visit.ro_user_id'] && $sceneMap['visit.rw_user_id']) {
            //相关团队查询
            $map = $requestMap;
            $partMap = function ($query) use ($sceneMap) {
                $query->where('visit.ro_user_id', array('like', '%,' . $sceneMap['ro_user_id'] . ',%'))
                    ->whereOr('visit.rw_user_id', array('like', '%,' . $sceneMap['rw_user_id'] . ',%'));
            };
        } else {
            $map = $requestMap ? array_merge($sceneMap, $requestMap) : $sceneMap;
        }

        //高级筛选
        $map = advancedQuery($map, 'crm', 'visit', 'index');

        $authMap = [];
        if (!$partMap) {
            $a = 'index';
            $auth_user_ids = $userModel->getUserByPer('crm', 'visit', $a);
            if (isset($map['visit.owner_user_id']) && $map['visit.owner_user_id'][0] != 'like') {
                if (!is_array($map['visit.owner_user_id'][1])) {
                    $map['visit.owner_user_id'][1] = [$map['visit.owner_user_id'][1]];
                }
                if (in_array($map['visit.owner_user_id'][0], ['neq', 'notin'])) {
                    $auth_user_ids = array_diff($auth_user_ids, $map['visit.owner_user_id'][1]) ?: [];    //取差集
                } else {
                    $auth_user_ids = array_intersect($map['visit.owner_user_id'][1], $auth_user_ids) ?: [];    //取交集
                }
                $auth_user_ids = array_merge(array_unique(array_filter($auth_user_ids))) ?: ['-1'];
                $authMap['visit.owner_user_id'] = array('in', $auth_user_ids);
                unset($map['visit.owner_user_id']);
            } else {
                $authMapData = [];
                $authMapData['auth_user_ids'] = $auth_user_ids;
                $authMapData['user_id'] = $user_id;
                $authMap = function ($query) use ($authMapData) {
                    $query->where('visit.owner_user_id', ['in', $authMapData['auth_user_ids']])
                        ->whereOr('visit.ro_user_id', array('like', '%,' . $authMapData['user_id'] . ',%'))
                        ->whereOr('visit.rw_user_id', array('like', '%,' . $authMapData['user_id'] . ',%'));
                };
            }
        }

        //列表展示字段
        $indexField = $fieldModel->getIndexField('crm_visit', $user_id, 1) ?: array('name');
        foreach ($indexField as $key => $value) {
            if ($value == 'visit.customer_name') unset($indexField[(int)$key]);
        }
        //人员类型
        $userField = $fieldModel->getFieldByFormType('crm_visit', 'user'); //人员类型
        $structureField = $fieldModel->getFieldByFormType('crm_visit', 'structure');  //部门类型
        $datetimeField = $fieldModel->getFieldByFormType('crm_visit', 'datetime'); //日期时间类型
        $booleanField = $fieldModel->getFieldByFormType('crm_visit', 'boolean_value'); //布尔值
        $dateIntervalField = $fieldModel->getFieldByFormType('crm_visit', 'date_interval'); // 日期区间类型字段
        $positionField = $fieldModel->getFieldByFormType('crm_visit', 'position'); // 地址类型字段
        $handwritingField = $fieldModel->getFieldByFormType('crm_visit', 'handwriting_sign'); // 手写签名类型字段
        $locationField = $fieldModel->getFieldByFormType('crm_visit', 'location'); // 定位类型字段
        $boxField = $fieldModel->getFieldByFormType('crm_customer', 'checkbox'); // 多选类型字段
        $floatField = $fieldModel->getFieldByFormType('crm_visit', 'floatnumber'); // 货币类型字段
        //        $fieldGrant = db('admin_field_mask')->where('types', 'visit')->select();
        # 处理人员和部门类型的排序报错问题(前端传来的是包含_name的别名字段)
        $temporaryField = str_replace('_name', '', $order_field);
        if (in_array($temporaryField, $userField) || in_array($temporaryField, $structureField)) {
            $order_field = $temporaryField;
        }
        //排序
        if ($order_type && $order_field) {
            $order = $fieldModel->getOrderByFormtype('crm_visit', 'visit', $order_field, $order_type);
        } else {
            $order = 'visit.update_time desc';
        }
        foreach ($indexField AS $kk => $vv) {
            if ($vv == 'visit.contract_number') unset($indexField[(int)$kk]);
        }
        $readAuthIds = $userModel->getUserByPer('crm', 'visit', 'read');
        $updateAuthIds = $userModel->getUserByPer('crm', 'visit', 'update');
        $deleteAuthIds = $userModel->getUserByPer('crm', 'visit', 'delete');
        $list = db('crm_visit')
            ->alias('visit')
            ->join('__CRM_CUSTOMER__ customer', 'visit.customer_id=customer.customer_id', 'LEFT')
            ->join('__CRM_CONTRACT__ contract', 'visit.contract_id=contract.contract_id', 'LEFT')
            ->join('__CRM_CONTACTS__ contacts', 'visit.contacts_id=contacts.contacts_id', 'LEFT')
            ->where($map)
            ->where($partMap)
            ->where($authMap)
            ->limit($request['offset'], $request['length'])
            ->field('visit.*,
                contract.num as contract_number,
                customer.name as customer_name,
                contacts.name as contacts_name'
            )
            ->orderRaw($order)
            ->group('visit.visit_id')
            ->select();
        $dataCount = db('crm_visit')
            ->alias('visit')
            ->join('__CRM_CUSTOMER__ customer', 'visit.create_user_id=customer.customer_id', 'LEFT')
            ->join('__CRM_CONTRACT__ contract', 'visit.contract_id=contract.contract_id', 'LEFT')
            ->join('__CRM_CONTACTS__ contacts', 'visit.contacts_id=contacts.contacts_id', 'LEFT')
            ->where($map)->where($partMap)->where($authMap)->group('visit.visit_id')->count('visit.visit_id');
        # 扩展数据
        $extraData = [];
        $visit_id_list = !empty($list) ? array_column($list, 'visit_id') : [];
        $extraList = db('crm_visit_data')->whereIn('visit_id', $visit_id_list)->select();
        foreach ($extraList AS $key => $value) {
            $extraData[$value['visit_id']][$value['field']] = $value['content'];
        }
        $grantData = getFieldGrantData($user_id);
        foreach ($grantData['crm_visit_'] as $key => $value) {
            foreach ($value as $ke => $va) {
                if($va['maskType']!=0){
                    $fieldGrant[$ke]['maskType'] = $va['maskType'];
                    $fieldGrant[$ke]['form_type'] = $va['form_type'];
                    $fieldGrant[$ke]['field'] = $va['field'];
                }
            }
        }
        foreach ($list as $k => $v) {
            $list[$k]['contract_num'] = $v['contract_number'];
            $list[$k]['create_user_id_info'] = isset($v['create_user_id']) ? $userModel->getUserById($v['create_user_id']) : [];
            $list[$k]['owner_user_id_info'] = isset($v['owner_user_id']) ? $userModel->getUserById($v['owner_user_id']) : [];
            $list[$k]['create_user_name'] = !empty($list[$k]['create_user_id_info']['realname']) ? $list[$k]['create_user_id_info']['realname'] : '';
            $list[$k]['owner_user_name'] = !empty($list[$k]['owner_user_id_info']['realname']) ? $list[$k]['owner_user_id_info']['realname'] : '';

            # 系统字段  负责人部门   zjf  20210726
            $list[$k]['owner_user_structure_name'] = $list[$k]['owner_user_id_info']['structure_name'];

            foreach ($userField as $k => $val) {
                $usernameField  = !empty($v[$val]) ? db('admin_user')->whereIn('id', stringToArray($v[$val]))->column('realname') : [];
                $list[$k][$val] = implode($usernameField, ',');
            }
            foreach ($structureField as $k => $val) {
                $structureNameField = !empty($v[$val]) ? db('admin_structure')->whereIn('id', stringToArray($v[$val]))->column('name') : [];
                $list[$k][$val] = implode($structureNameField, ',');
            }
            foreach ($datetimeField as $k => $val) {
                $list[$k][$val] = !empty($v[$val]) ? date('Y-m-d H:i:s', $v[$val]) : null;
            }
            foreach ($booleanField as $k => $val) {
                $list[$k][$val] = !empty($v[$val]) ? (string)$v[$val] : '0';
            }
            // 处理日期区间类型字段的格式
            foreach ($dateIntervalField AS $k => $val) {
                $list[$k][$val] = !empty($extraData[$v['visit_id']][$val]) ? json_decode($extraData[$v['visit_id']][$val], true) : null;
            }
            // 处理地址类型字段的格式
            foreach ($positionField AS $k => $val) {
                $list[$k][$val] = !empty($extraData[$v['visit_id']][$val]) ? json_decode($extraData[$v['visit_id']][$val], true) : null;
            }
            // 手写签名类型字段
            foreach ($handwritingField AS $k => $val) {
                $handwritingData = !empty($v[$val]) ? db('admin_file')->where('file_id', $v[$val])->value('file_path') : null;
                $list[$k][$val] = ['url' => !empty($handwritingData) ? getFullPath($handwritingData) : null];
            }
            // 定位类型字段
            foreach ($locationField AS $k => $val) {
                $list[$k][$val] = !empty($extraData[$v['visit_id']][$val]) ? json_decode($extraData[$v['visit_id']][$val], true) : null;
            }
            // 多选框类型字段
            foreach ($boxField AS $k => $val) {
                $list[$k][$val] = !empty($v[$val]) ? trim($v[$val], ',') : null;
            }
            // 货币类型字段
            foreach ($floatField AS $k => $val) {
                $list[$k][$val] = $v[$val]!='0.00' ? (string)$v[$val] : null;
            }
            //掩码相关类型字段
            foreach ($fieldGrant AS $key => $val){
                //掩码相关类型字段
                if ($val['maskType']!=0 && $val['form_type'] == 'mobile') {
                    $pattern = "/(1[3458]{1}[0-9])[0-9]{4}([0-9]{4})/i";
                    $rs = preg_replace($pattern, "$1****$2", $v[$val['field']]);
                    $list[$k][$val['field']] = !empty($v[$val['field']]) ? (string)$rs : null;
                } elseif ($val['maskType']!=0 && $val['form_type'] == 'email') {
                    $email_array = explode("@", $v[$val['field']]);
                    $prevfix = (strlen($email_array[0]) < 4) ? "" : substr($v[$val['field']], 0, 2); //邮箱前缀
                    $str = preg_replace('/([\d\w+_-]{0,100})@/', "***@", $v[$val['field']], -1, $count);
                    $rs = $prevfix . $str;
                    $list[$k][$val['field']] = !empty($v[$val['field']]) ?$rs: null;
                } elseif ($val['maskType']!=0 && in_array($val['form_type'],['position','floatnumber'])) {
                    $list[$k][$val['field']] = !empty($v[$val['field']]) ? (string)substr_replace($v[$val['field']], '*****',0,strlen($v[$val['field']])) : null;
                }
            }
            $list[$k]['contract_id_info']['contract_id'] = $v['contract_id'];
            $list[$k]['contract_id_info']['name'] = $v['contract_name'];
            $list[$k]['customer_id_info']['customer_id'] = $v['create_user_id'];
            $list[$k]['customer_id_info']['name'] = $v['customer_name'];
            $list[$k]['customer_name'] = !empty($list[$k]['customer_id_info']['name']) ? $list[$k]['customer_id_info']['name'] : '';
            $list[$k]['contacts_id_info']['contacts_id'] = $v['contacts_id'];
            $list[$k]['contacts_id_info']['name'] = $v['contacts_name'];
            $list[$k]['contacts_name'] = !empty($list[$k]['contacts_id_info']['name']) ? $list[$k]['contacts_id_info']['name'] : '';
            //权限
            $roPre = $userModel->rwPre($user_id, $v['ro_user_id'], $v['rw_user_id'], 'read');
            $rwPre = $userModel->rwPre($user_id, $v['ro_user_id'], $v['rw_user_id'], 'update');
            $permission = [];
            $is_read = 0;
            $is_update = 0;
            $is_delete = 0;
            if (in_array($v['owner_user_id'], $readAuthIds) || $roPre || $rwPre) $is_read = 1;
            if (in_array($v['owner_user_id'], $updateAuthIds)  || $rwPre) $is_update = 1;
            if (in_array($v['owner_user_id'], $deleteAuthIds)) $is_delete = 1;
            $permission['is_read'] = $is_read;
            $permission['is_update'] = $is_update;
            $permission['is_delete'] = $is_delete;
            $list[$k]['permission'] = $permission;
            # 日期
            $list[$k]['create_time'] = !empty($v['create_time']) ? date('Y-m-d H:i:s', $v['create_time']) : null;
            $list[$k]['update_time'] = !empty($v['update_time']) ? date('Y-m-d H:i:s', $v['update_time']) : null;
        }
        $data = [];
        $data['list'] = $list ?: [];
        $data['dataCount'] = $dataCount ?: 0;
        return $data;
    }

    /**
     * 回访详情
     */
    public function getDataById($id = '', $userId = 0)
    {
        $dataInfo = db('crm_visit')->where('visit_id', $id)->find();
        if (!$dataInfo) {
            $this->error = '暂无此数据';
            return false;
        }
        $grantData = getFieldGrantData($userId);
        foreach ($grantData['crm_leads'] as $key => $value) {
            foreach ($value as $ke => $va) {
                if($va['maskType']!=0){
                    $fieldGrant[$ke]['maskType'] = $va['maskType'];
                    $fieldGrant[$ke]['form_type'] = $va['form_type'];
                    $fieldGrant[$ke]['field'] = $va['field'];
                }
            }
        }
        foreach ($fieldGrant AS $key => $val){
            //掩码相关类型字段
            if ($val['maskType']!=0 && $val['form_type'] == 'mobile') {
                $pattern = "/(1[3458]{1}[0-9])[0-9]{4}([0-9]{4})/i";
                $rs = preg_replace($pattern, "$1****$2", $dataInfo[$val['field']]);
                $dataInfo[$val['field']] = !empty($dataInfo[$val['field']]) ? (string)$rs : null;
            } elseif ($val['maskType']!=0 && $val['form_type'] == 'email') {
                $email_array = explode("@", $dataInfo[$val['field']]);
                $prevfix = (strlen($email_array[0]) < 4) ? "" : substr($dataInfo[$val['field']], 0, 2); //邮箱前缀
                $str = preg_replace('/([\d\w+_-]{0,100})@/', "***@", $dataInfo[$val['field']], -1, $count);
                $rs = $prevfix . $str;
                $dataInfo[$val['field']] = !empty($dataInfo[$val['field']]) ?$rs: null;
            } elseif ($val['maskType']!=0 && in_array($val['form_type'],['position','floatnumber'])) {
                $dataInfo[$val['field']] = !empty($dataInfo[$val['field']]) ? (string)substr_replace($dataInfo[$val['field']], '*****',0,strlen($v[$val['field']])) : null;
            }
        }
        $userModel = new \app\admin\model\User();
        $dataInfo['create_user_id_info'] = isset($dataInfo['create_user_id']) ? $userModel->getUserById($dataInfo['create_user_id']) : [];
        $dataInfo['owner_user_id_info'] = isset($dataInfo['owner_user_id']) ? $userModel->getUserById($dataInfo['owner_user_id']) : [];
        $dataInfo['create_user_name'] = !empty($dataInfo['create_user_id_info']['realname']) ? $dataInfo['create_user_id_info']['realname'] : '';
        $dataInfo['owner_user_name'] = !empty($dataInfo['owner_user_id_info']['realname']) ? $dataInfo['owner_user_id_info']['realname'] : '';
        $dataInfo['customer_id_info'] = db('crm_customer')->where(['customer_id' => $dataInfo['customer_id']])->field('customer_id,name')->find();
        $dataInfo['customer_name'] = !empty($dataInfo['customer_id_info']['name']) ? $dataInfo['customer_id_info']['name'] : '';
        $dataInfo['contract_id_info'] = db('crm_contract')->where(['contract_id' => $dataInfo['contract_id']])->field('contract_id,name')->find();
        $dataInfo['contacts_id_info'] = db('crm_contacts')->where(['contacts_id' => $dataInfo['contacts_id']])->field('contacts_id,name')->find();
        $dataInfo['contacts_name'] = !empty($dataInfo['contacts_id_info']['name']) ? $dataInfo['contacts_id_info']['name'] : '';
        # 处理日期格式
        $fieldModel = new \app\admin\model\Field();
        $datetimeField = $fieldModel->getFieldByFormType('crm_visit', 'datetime'); //日期时间类型
        foreach ($datetimeField as $key => $val) {
            $dataInfo[$val] = !empty($dataInfo[$val]) ? date('Y-m-d H:i:s', $dataInfo[$val]) : null;
        }
        $dataInfo['create_time'] = !empty($dataInfo['create_time']) ? date('Y-m-d H:i:s', $dataInfo['create_time']) : null;
        $dataInfo['update_time'] = !empty($dataInfo['update_time']) ? date('Y-m-d H:i:s', $dataInfo['update_time']) : null;
        // 字段授权
        if (!empty($userId)) {
            $grantData = getFieldGrantData($userId);
            $userLevel = isSuperAdministrators($userId);
            foreach ($dataInfo AS $key => $value) {
                if (!$userLevel && !empty($grantData['crm_visit'])) {
                    $status = getFieldGrantStatus($key, $grantData['crm_visit']);

                    # 查看权限
                    if ($status['read'] == 0) unset($dataInfo[$key]);
                }
            }
        }
        return $dataInfo;
    }

    /**
     * 创建回访信息
     */
    public function createData($param)
    {
        // 回访扩展表数据
        $visitData = [];

        $fieldModel = new \app\admin\model\Field();

        // 数据验证
        $validateResult = $this->fieldDataValidate($param, 'crm_visit', $param['create_user_id']);
        if (!empty($validateResult)) {
            $this->error = $validateResult;
            return false;
        }

        if (!$param['customer_id']) {
            $this->error = '请选择相关客户';
            return false;
        }
        # 处理合同的回访
        if ($param['contract_id']) {
            Db::name('crm_contract')->where('contract_id', $param['contract_id'])->update(['is_visit' => 1]);
        }
        // 处理部门、员工、附件、多选类型字段
        $arrFieldAtt = $fieldModel->getArrayField('crm_visit');
        foreach ($arrFieldAtt as $k => $v) {
            if ($v == 'visit_user_id') continue;
            $param[$v] = arrayToString($param[$v]);
        }
        // 处理日期（date）类型
        $dateField = $fieldModel->getFieldByFormType('crm_visit', 'date');
        if (!empty($dateField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $dateField) && empty($value)) $param[$key] = null;
            }
        }
        // 处理手写签名类型
        $handwritingField = $fieldModel->getFieldByFormType('crm_visit', 'handwriting_sign');
        if (!empty($handwritingField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $handwritingField)) {
                    $param[$key] = !empty($value['file_id']) ? $value['file_id'] : '';
                }
            }
        }
        // 处理地址、定位、日期区间、明细表格类型字段
        $positionField     = $fieldModel->getFieldByFormType('crm_visit', 'position');
        $locationField     = $fieldModel->getFieldByFormType('crm_visit', 'location');
        $dateIntervalField = $fieldModel->getFieldByFormType('crm_visit', 'date_interval');
        $detailTableField  = $fieldModel->getFieldByFormType('crm_visit', 'detail_table');
        foreach ($param AS $key => $value) {
            // 处理地址类型字段数据
            if (in_array($key, $positionField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $positionNames = array_column($value, 'name');
                    $param[$key] = implode(',', $positionNames);
                } else {
                    $param[$key] = '';
                }
            }
            // 处理定位类型字段数据
            if (in_array($key, $locationField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = $value['address'];
                } else {
                    $param[$key] = '';
                }
            }
            // 处理日期区间类型字段数据
            if (in_array($key, $dateIntervalField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = implode('_', $value);
                } else {
                    $param[$key] = '';
                }
            }
            // 处理明细表格类型字段数据
            if (in_array($key, $detailTableField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = $key;
                } else {
                    $param[$key] = '';
                }
            }
        }

        $visitModel = new Visit();
        if ($visitModel->data($param)->allowField(true)->save()) {
            $visit_id = $visitModel->visit_id;
            $data['visit_id'] = $visit_id;
            updateActionLog($param['create_user_id'], 'crm_visit', $visitModel->visit_id, '', '', '创建了客户回访');
            RecordActionLog($param['create_user_id'],'crm_visit','save',$param['number'],'','','新增了客户回访'.$param['number']);
            // 添加回访扩展数据
            array_walk($visitData, function (&$val) use ($data) {
                $val['visit_id'] = $data['visit_id'];
            });
            db('crm_visit_data')->insertAll($visitData);

            return $data;
        } else {
            $this->error = '添加失败';
            return false;
        }
    }

    /**
     * 编辑回访信息
     */
    public function updateDataById($param, $visit_id = '')
    {
        // 回访扩展表数据
        $visitData = [];

        $Visit = model('Visit');
        $productModel = new \app\crm\model\Product();
        $dataInfo = $this->getDataById($visit_id);
        if (!$dataInfo) {
            $this->error = '数据不存在或已删除';
            return false;
        }
        $param['visit_id'] = $visit_id;
        //过滤不能修改的字段
        $unUpdateField = ['create_user_id', 'visit_time'];
        foreach ($unUpdateField as $v) {
            unset($param[$v]);
        }

        $fieldModel = new \app\admin\model\Field();

        // 数据验证
        $validateResult = $this->fieldDataValidate($param, 'crm_visit', $param['user_id'], $param['visit_id']);
        if (!empty($validateResult)) {
            $this->error = $validateResult;
            return false;
        }

        // 处理部门、员工、附件、多选类型字段
        $arrFieldAtt = $fieldModel->getArrayField('crm_visit');
        foreach ($arrFieldAtt as $k => $v) {
            if ($v == 'visit_user_id') continue;
            if (isset($param[$v])) $param[$v] = arrayToString($param[$v]);
        }
        // 处理日期（date）类型
        $dateField = $fieldModel->getFieldByFormType('crm_visit', 'date');
        if (!empty($dateField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $dateField) && empty($value)) $param[$key] = null;
            }
        }
        // 处理手写签名类型
        $handwritingField = $fieldModel->getFieldByFormType('crm_visit', 'handwriting_sign');
        if (!empty($handwritingField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $handwritingField)) {
                    $param[$key] = !empty($value['file_id']) ? $value['file_id'] : '';
                }
            }
        }
        // 处理地址、定位、日期区间、明细表格类型字段
        $positionField     = $fieldModel->getFieldByFormType('crm_visit', 'position');
        $locationField     = $fieldModel->getFieldByFormType('crm_visit', 'location');
        $dateIntervalField = $fieldModel->getFieldByFormType('crm_visit', 'date_interval');
        $detailTableField  = $fieldModel->getFieldByFormType('crm_visit', 'detail_table');
        foreach ($param AS $key => $value) {
            // 处理地址类型字段数据
            if (in_array($key, $positionField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $positionNames = array_column($value, 'name');
                    $param[$key] = implode(',', $positionNames);
                } else {
                    $param[$key] = '';
                }
            }
            // 处理定位类型字段数据
            if (in_array($key, $locationField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = $value['address'];
                } else {
                    $param[$key] = '';
                }
            }
            // 处理日期区间类型字段数据
            if (in_array($key, $dateIntervalField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = implode('_', $value);
                } else {
                    $param[$key] = '';
                }
            }
            // 处理明细表格类型字段数据
            if (in_array($key, $detailTableField)) {
                if (!empty($value)) {
                    $visitData[] = [
                        'field'       => $key,
                        'content'     => json_encode($value, JSON_NUMERIC_CHECK),
                        'create_time' => time()
                    ];
                    $param[$key] = $key;
                } else {
                    $param[$key] = '';
                }
            }
        }

        if ($Visit->update($param, ['visit_id' => $visit_id], true)) {
            $data['visit_id'] = $visit_id;
            //修改记录           
            updateActionLog($param['user_id'], 'crm_visit', $visit_id, $dataInfo, $param);
            RecordActionLog($param['user_id'], 'crm_visit', 'update',$dataInfo['number'], $dataInfo, $param);
            // 添加回访扩展数据
            db('crm_visit_data')->where('visit_id', $visit_id)->delete();
            array_walk($visitData, function (&$val) use ($visit_id) {
                $val['visit_id'] = $visit_id;
            });
            db('crm_visit_data')->insertAll($visitData);

            return $data;
        } else {
            $this->rollback();
            $this->error = '编辑失败';
            return false;
        }
    }

    /**
     * @param 删除
     * @return
     */
    public function del($visit_id)
    {
        $Visit = model('Visit');
        $fileModel = new \app\admin\model\File();
        $actionRecordModel = new \app\admin\model\ActionRecord();
        $userModel = new \app\admin\model\User();
        $delIds = [];
        $errorMessage = [];
        //数据权限判断
        $auth_user_ids = $userModel->getUserByPer('crm', 'visit', 'delete');
        foreach ($visit_id as $k => $v) {
            $isDel = true;
            //数据详情
            $data = $this->getDataById($v);
            if (!$data) {
                $isDel = false;
                $errorMessage[] = 'id为' . $v . '的客户回访删除失败,错误原因：' . $this->getError();
            }
            if (!in_array($data['owner_user_id'], $auth_user_ids)) {
                $isDel = false;
                $errorMessage[] = '名称为' . $data['name'] . '的客户回访删除失败,错误原因：无权操作';
            }
            if ($isDel) {
                $delIds[] = $v;
            }
        }
        $dataInfo = $Visit->where('visit_id',['in',$delIds])->select();
        if ($delIds) {
            $data = $Visit->delDatas($delIds);
            if (!$data) {
                return resultArray(['error' => $this->getError()]);
            }
            // 删除回访扩展数据
            db('crm_visit_data')->whereIn('visit_id', $delIds)->delete();
            //删除关联附件
            $fileModel->delRFileByModule('crm_visit', $delIds);
            //删除关联操作记录
            $actionRecordModel->delDataById(['types' => 'crm_visit', 'visit_id' => $delIds]);
            $user=new ApiCommon();
            $userInfo = $user->userInfo;
            foreach ($dataInfo as $k => $v) {
                RecordActionLog($userInfo['id'], 'crm_contacts', 'delete', $v['name'], '', '', '删除了客户回访：' . $v['name']);
            }
        }
        return $errorMessage;
    }

    /**
     * 获取系统信息
     *
     * @param $id
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getSystemInfo($id)
    {
        # 回访
        $visit = Db::name('crm_visit')->field(['create_user_id', 'owner_user_id', 'create_time', 'update_time'])->where('visit_id', $id)->find();
        # 创建人
        $realname = Db::name('admin_user')->where('id', $visit['create_user_id'])->value('realname');
        
        # zjf   20210726
        $userModel   = new \app\admin\model\User();
        $ownerUserInfo = $userModel->getUserById($visit['owner_user_id']);
        # 负责人部门
        $ownerStructureName = $ownerUserInfo['structure_name'];

        # 负责人
        $ownerUserName = $ownerUserInfo['realname'];
        
        return [
            'create_user_id' => $realname,
            'owner_user_id' => $ownerUserName,
            'create_time' => date('Y-m-d H:i:s', $visit['create_time']),
            'update_time' => date('Y-m-d H:i:s', $visit['update_time']),
            'owner_user_structure_name' => $ownerStructureName
        ];
    }
}