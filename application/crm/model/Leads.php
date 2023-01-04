<?php
// +----------------------------------------------------------------------
// | Description: 线索
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com
// +----------------------------------------------------------------------
namespace app\crm\model;

use app\admin\traits\FieldVerificationTrait;
use think\Db;
use app\admin\model\Common;

class Leads extends Common
{
    use FieldVerificationTrait;

    /**
     * 为了数据库的整洁，同时又不影响Model和Controller的名称
     * 我们约定每个模块的数据表都加上相同的前缀，比如CRM模块用crm作为数据表前缀
     */
    protected $name = 'crm_leads';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
    protected $autoWriteTimestamp = true;

    /**
     * [getDataList 线索list]
     * @param     [string]                   $map [查询条件]
     * @param     [number]                   $page     [当前页数]
     * @param     [number]                   $limit    [每页数量]
     * @return    [array]                    [description]
     * @author Michael_xu
     */
    public function getDataList($request)
    {
        $userModel = new \app\admin\model\User();
        $structureModel = new \app\admin\model\Structure();
        $fieldModel = new \app\admin\model\Field();
        $search = $request['search'];
        $user_id = $request['user_id'];
        $scene_id = (int)$request['scene_id'];
        $is_excel = $request['is_excel']; //导出
        $order_field = $request['order_field'];
        $order_type = $request['order_type'];
        $getCount = $request['getCount'];
        $overdue = $request['overdue']; // 待办事项下需联系线索(逾期)
        unset($request['scene_id']);
        unset($request['search']);
        unset($request['user_id']);
        unset($request['is_excel']);
        unset($request['order_field']);
        unset($request['order_type']);
        unset($request['getCount']);
        unset($request['overdue']);

        $request = $this->fmtRequest($request);
        $requestMap = $request['map'] ?: [];

        $sceneModel = new \app\admin\model\Scene();
        # getCount是代办事项传来的参数，代办事项不需要使用场景
        $sceneMap = [];
        if (empty($getCount)) {
            if ($scene_id) {
                //自定义场景
                $sceneMap = $sceneModel->getDataById($scene_id, $user_id, 'leads') ?: [];
            } else {
                //默认场景
                $sceneMap = $sceneModel->getDefaultData('crm_leads', $user_id) ?: [];
            }
        }
        $searchMap = [];
        if ($search || $search == '0') {
            //普通筛选
            $searchMap = function ($query) use ($search) {
                $query->where('leads.name', array('like', '%' . $search . '%'))
                    ->whereOr('leads.mobile', array('like', '%' . $search . '%'))
                    ->whereOr('leads.telephone', array('like', '%' . $search . '%'));
            };
        }
        //优先级：普通筛选>高级筛选>场景

        $map = $requestMap ? array_merge($sceneMap, $requestMap) : $sceneMap;
        //高级筛选
        $map = advancedQuery($map, 'crm', 'leads', 'index');
//        $map = where_arr($map, 'crm', 'leads', 'index');
        //权限
        $a = 'index';
        if ($is_excel) $a = 'excelExport';
        $auth_user_ids = $userModel->getUserByPer('crm', 'leads', $a);
        //过滤权限
        if (isset($map['leads.owner_user_id']) && $map['leads.owner_user_id'][0] != 'like') {
            if (!is_array($map['leads.owner_user_id'][1])) {
                $map['leads.owner_user_id'][1] = [$map['leads.owner_user_id'][1]];
            }
            if (in_array($map['leads.owner_user_id'][0], ['neq', 'notin'])) {
                $auth_user_ids = array_diff($auth_user_ids, $map['leads.owner_user_id'][1]) ?: [];    //取差集
            } else {
                $auth_user_ids = array_intersect($map['leads.owner_user_id'][1], $auth_user_ids) ?: [];    //取交集
            }
            unset($map['leads.owner_user_id']);
        }
        $auth_user_ids = array_merge(array_unique(array_filter($auth_user_ids))) ?: ['-1'];
        //负责人
        $authMap['leads.owner_user_id'] = ['in', $auth_user_ids];
        //列表展示字段
        $indexField = $fieldModel->getIndexField('crm_leads', $user_id, 1) ?: array('name');
        $userField = $fieldModel->getFieldByFormType('crm_leads', 'user'); //人员类型
        $structureField = $fieldModel->getFieldByFormType('crm_leads', 'structure');  //部门类型
        $datetimeField = $fieldModel->getFieldByFormType('crm_leads', 'datetime'); //日期时间类型
        $booleanField = $fieldModel->getFieldByFormType('crm_leads', 'boolean_value'); //布尔值
        $dateIntervalField = $fieldModel->getFieldByFormType('crm_leads', 'date_interval'); // 日期区间类型字段
        $positionField = $fieldModel->getFieldByFormType('crm_leads', 'position'); // 地址类型字段
        $handwritingField = $fieldModel->getFieldByFormType('crm_leads', 'handwriting_sign'); // 手写签名类型字段
        $locationField = $fieldModel->getFieldByFormType('crm_leads', 'location'); // 定位类型字段
        $boxField = $fieldModel->getFieldByFormType('crm_leads', 'checkbox'); // 多选类型字段
        $floatField = $fieldModel->getFieldByFormType('crm_leads', 'floatnumber'); // 货币类型字段
        # 处理人员和部门类型的排序报错问题(前端传来的是包含_name的别名字段)
        $temporaryField = str_replace('_name', '', $order_field);
        if (in_array($temporaryField, $userField) || in_array($temporaryField, $structureField)) {
            $order_field = $temporaryField;
        }
        //排序
        if ($order_type && $order_field) {
            $order = $fieldModel->getOrderByFormtype('crm_leads', 'leads', $order_field, $order_type);
        } else {
            $order = 'leads.update_time desc';
        }
        //过滤已转化线索
        if (!$map['leads.is_transform']) {
            $map['leads.is_transform'] = array('neq', 1);
        }

        // 待办事项下需联系线索(逾期)
        $overdueWhere = '';
        if (!empty($overdue)) {
            $overdueWhere = "(FROM_UNIXTIME(`leads`.`last_time`,'%Y-%m-%d') < FROM_UNIXTIME(`leads`.`next_time`,'%Y-%m-%d') OR (ISNULL(`leads`.`last_time`) AND `leads`.`next_time` < ".time()."))";
        }

        $readAuthIds = $userModel->getUserByPer('crm', 'leads', 'read');
        $updateAuthIds = $userModel->getUserByPer('crm', 'leads', 'update');
        $deleteAuthIds = $userModel->getUserByPer('crm', 'leads', 'delete');
        $dataCount = db('crm_leads')->alias('leads')->where($map)->where($searchMap)->where($authMap)->where($overdueWhere)->count('leads_id');
        if (!empty($getCount) && $getCount == 1) {
            $data['dataCount'] = !empty($dataCount) ? $dataCount : 0;
            return $data;
        }

        $list = db('crm_leads')
            ->alias('leads')
            ->where($map)
            ->where($searchMap)
            ->where($authMap)
            ->where($overdueWhere)
            ->limit($request['offset'], $request['length'])
            ->field(implode(',', $indexField))
            ->orderRaw($order)
            ->select();
        # 扩展数据
        $extraData = [];
        $leads_id_list = !empty($list) ? array_column($list, 'leads_id') : [];
        $extraList = db('crm_leads_data')->whereIn('leads_id', $leads_id_list)->select();
        foreach ($extraList AS $key => $value) {
            $extraData[$value['leads_id']][$value['field']] = $value['content'];
        }

        $grantData = getFieldGrantData($user_id);
        foreach ($grantData['crm_leads'] as $key => $value) {
            foreach ($value as $ke => $va) {
                if($va['maskType']!=0){
                    $fieldGrant[$ke]['maskType'] = $va['maskType'];
                    $fieldGrant[$ke]['form_type'] = $va['form_type'];
                    $fieldGrant[$ke]['field'] = $va['field'];
                }
            }
        }
        foreach ($list as $k => $v) {
            $list[$k]['create_user_id_info'] = isset($v['create_user_id']) ? $userModel->getUserById($v['create_user_id']) : [];
            $list[$k]['owner_user_id_info'] = isset($v['owner_user_id']) ? $userModel->getUserById($v['owner_user_id']) : [];
            $list[$k]['create_user_name'] = !empty($list[$k]['create_user_id_info']['realname']) ? $list[$k]['create_user_id_info']['realname'] : '';
            $list[$k]['owner_user_name'] = !empty($list[$k]['owner_user_id_info']['realname']) ? $list[$k]['owner_user_id_info']['realname'] : '';
            foreach ($userField as $key => $val) {
                $usernameField  = !empty($v[$val]) ? db('admin_user')->whereIn('id', stringToArray($v[$val]))->column('realname') : [];
                $list[$k][$val] = implode($usernameField, ',');
            }
            foreach ($structureField as $key => $val) {
                $structureNameField = !empty($v[$val]) ? db('admin_structure')->whereIn('id', stringToArray($v[$val]))->column('name') : [];
                $list[$k][$val] = implode($structureNameField, ',');
            }
            foreach ($datetimeField as $key => $val) {
                $list[$k][$val] = !empty($v[$val]) ? date('Y-m-d H:i:s', $v[$val]) : null;
            }
            foreach ($booleanField as $key => $val) {
                $list[$k][$val] = !empty($v[$val]) ? (string)$v[$val] : '0';
            }
            // 处理日期区间类型字段的格式
            foreach ($dateIntervalField AS $key => $val) {
                $list[$k][$val] = !empty($extraData[$v['leads_id']][$val]) ? json_decode($extraData[$v['leads_id']][$val], true) : null;
            }
            // 处理地址类型字段的格式
            foreach ($positionField AS $key => $val) {
                $list[$k][$val] = !empty($extraData[$v['leads_id']][$val]) ? json_decode($extraData[$v['leads_id']][$val], true) : null;
            }
            // 手写签名类型字段
            foreach ($handwritingField AS $key => $val) {
                $handwritingData = !empty($v[$val]) ? db('admin_file')->where('file_id', $v[$val])->value('file_path') : null;
                $list[$k][$val] = ['url' => !empty($handwritingData) ? getFullPath($handwritingData) : null];
            }
            // 定位类型字段
            foreach ($locationField AS $key => $val) {
                $list[$k][$val] = !empty($extraData[$v['leads_id']][$val]) ? json_decode($extraData[$v['leads_id']][$val], true) : null;
            }
            // 多选框类型字段
            foreach ($boxField AS $key => $val) {
                $list[$k][$val] = !empty($v[$val]) ? trim($v[$val], ',') : null;
            }
            // 货币类型字段
            foreach ($floatField AS $key => $val) {
                $list[$k][$val] = $v[$val]!='0.00' ? (string)$v[$val] : null;
            }

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

            // 货币类型字段
            foreach ($floatField AS $key => $val) {
                $list[$k][$val] = $v[$val]!='0.00' ? (string)$v[$val] : null;
            }
            //权限
            $permission = [];
            $is_read = 0;
            $is_update = 0;
            $is_delete = 0;
            if (in_array($v['owner_user_id'], $readAuthIds)) $is_read = 1;
            if (in_array($v['owner_user_id'], $updateAuthIds)) $is_update = 1;
            if (in_array($v['owner_user_id'], $deleteAuthIds)) $is_delete = 1;
            $permission['is_read'] = $is_read;
            $permission['is_update'] = $is_update;
            $permission['is_delete'] = $is_delete;
            $list[$k]['permission'] = $permission;
            # 关注
            $starWhere = ['user_id' => $user_id, 'target_id' => $v['leads_id'], 'type' => 'crm_leads'];
            $star = Db::name('crm_star')->where($starWhere)->value('star_id');
            $list[$k]['star'] = !empty($star) ? 1 : 0;
            # 日期
            $list[$k]['create_time'] = !empty($v['create_time']) ? date('Y-m-d H:i:s', $v['create_time']) : null;
            $list[$k]['update_time'] = !empty($v['update_time']) ? date('Y-m-d H:i:s', $v['update_time']) : null;
            $list[$k]['last_time']   = !empty($v['last_time'])   ? date('Y-m-d H:i:s', $v['last_time'])   : null;

            # 系统字段  负责人部门   zjf  20210726
            $list[$k]['owner_user_structure_name'] = $list[$k]['owner_user_id_info']['structure_name'];
        }
        $data = [];
        $data['list'] = $list;
        $data['dataCount'] = $dataCount ?: 0;

        return $data;
    }

    //根据IDs获取数组
    public function getDataByStr($idstr)
    {
        $idArr = stringToArray($idstr);
        if (!$idArr) {
            return [];
        }
        $list = Db::name('CrmLeads')->where(['leads_id' => ['in', $idArr]])->select();
        return $list;
    }

    /**
     * 创建线索主表信息
     * @param
     * @return
     * @author Michael_xu
     */
    public function createData($param)
    {
        unset($param['excel']);

        // 线索扩展表数据
        $leadsData = [];

        $fieldModel = new \app\admin\model\Field();

//        // 自动验证
//        $validateArr = $fieldModel->validateField($this->name); //获取自定义字段验证规则
//        $validate = new Validate($validateArr['rule'], $validateArr['message']);
//        $result = $validate->check($param);
//        if (!$result) {
//            $this->error = $validate->getError();
//            return false;
//        }

        // 数据验证
        $validateResult = $this->fieldDataValidate($param, $this->name, $param['create_user_id']);
        if (!empty($validateResult)) {
            $this->error = $validateResult;
            return false;
        }

        // 处理部门、员工、附件、多选类型字段
        $arrFieldAtt = $fieldModel->getArrayField('crm_leads');
        foreach ($arrFieldAtt as $k => $v) {
            $param[$v] = arrayToString($param[$v]);
        }
        // 处理日期（date）类型
        $dateField = $fieldModel->getFieldByFormType('crm_leads', 'date');
        if (!empty($dateField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $dateField) && empty($value)) $param[$key] = null;
            }
        }
        // 处理手写签名类型
        $handwritingField = $fieldModel->getFieldByFormType('crm_leads', 'handwriting_sign');
        if (!empty($handwritingField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $handwritingField)) {
                    $param[$key] = !empty($value['file_id']) ? $value['file_id'] : '';
                }
            }
        }
        // 处理地址、定位、日期区间、明细表格类型字段
        $positionField     = $fieldModel->getFieldByFormType($this->name, 'position');
        $locationField     = $fieldModel->getFieldByFormType($this->name, 'location');
        $dateIntervalField = $fieldModel->getFieldByFormType($this->name, 'date_interval');
        $detailTableField  = $fieldModel->getFieldByFormType($this->name, 'detail_table');
        foreach ($param AS $key => $value) {
            // 处理地址类型字段数据
            if (in_array($key, $positionField)) {
                if (!empty($value)) {
                    $leadsData[] = [
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
                    $leadsData[] = [
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
                    $leadsData[] = [
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
                    $leadsData[] = [
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

        # 设置今日需联系线索
        if (!empty($param['next_time']) && $param['next_time'] >= strtotime(date('Y-m-d 00:00:00'))) $param['is_dealt'] = 0;

        if ($this->data($param)->allowField(true)->isUpdate(false)->save()) {
            $data['leads_id'] = $this->leads_id;
            //修改记录
            updateActionLog($param['create_user_id'], 'crm_leads', $this->leads_id, '', '', '创建了线索');
            RecordActionLog($param['create_user_id'],'crm_leads','save',$param['name'],'','','新增了线索'.$param['name']);
            # 添加活动记录
            Db::name('crm_activity')->insert([
                'type'             => 2,
                'activity_type'    => 1,
                'activity_type_id' => $this->leads_id,
                'content'          => $param['name']?:'',
                'create_user_id'   => $param['create_user_id'],
                'update_time'      => time(),
                'create_time'      => time(),
                'customer_ids'     => null,
                'contacts_ids'     => null,
                'business_ids'     => null
            ]);
            // 添加线索扩展数据
            array_walk($leadsData, function (&$val) use ($data) {
                $val['leads_id'] = $data['leads_id'];
            });
            db('crm_leads_data')->insertAll($leadsData);

            return $data;
        } else {
            $this->error = '添加失败';
            return false;
        }
    }

    /**
     * 编辑线索信息
     * @param
     * @return
     * @author Michael_xu
     */
    public function updateDataById($param, $leads_id = '')
    {
        // 线索扩展表数据
        $leadsData = [];

        $userModel = new \app\admin\model\User();
        $dataInfo = $this->getDataById($leads_id);
        if (!$dataInfo) {
            $this->error = '数据不存在或已删除';
            return false;
        }
        //判断权限
        $auth_user_ids = $userModel->getUserByPer('crm', 'leads', 'update');
        if (!in_array($dataInfo['owner_user_id'], $auth_user_ids)) {
            $this->error = '无权操作';
            return false;
        }

        $param['leads_id'] = $leads_id;
        //过滤不能修改的字段
        $unUpdateField = ['create_user_id', 'is_deleted', 'delete_time'];
        foreach ($unUpdateField as $v) {
            unset($param[$v]);
        }

        $fieldModel = new \app\admin\model\Field();
        // 自动验证
//        $validateArr = $fieldModel->validateField($this->name, 0, 'update'); //获取自定义字段验证规则
//        $validate = new Validate($validateArr['rule'], $validateArr['message']);
//        $result = $validate->check($param);
//        if (!$result) {
//            $this->error = $validate->getError();
//            return false;
//        }
        // 数据验证
        $validateResult = $this->fieldDataValidate($param, $this->name, $param['user_id'], $leads_id);
        if (!empty($validateResult)) {
            $this->error = $validateResult;
            return false;
        }

        // 处理部门、员工、附件、多选类型字段
        $arrFieldAtt = $fieldModel->getArrayField('crm_leads');
        foreach ($arrFieldAtt as $k => $v) {
            if (isset($param[$v])) $param[$v] = arrayToString($param[$v]);
        }
        // 处理日期（date）类型
        $dateField = $fieldModel->getFieldByFormType('crm_leads', 'date');
        if (!empty($dateField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $dateField) && empty($value)) $param[$key] = null;
            }
        }
        // 处理手写签名类型
        $handwritingField = $fieldModel->getFieldByFormType('crm_leads', 'handwriting_sign');
        if (!empty($handwritingField)) {
            foreach ($param AS $key => $value) {
                if (in_array($key, $handwritingField)) {
                    $param[$key] = !empty($value['file_id']) ? $value['file_id'] : '';
                }
            }
        }
        // 处理地址、定位、日期区间、明细表格类型字段
        $positionField     = $fieldModel->getFieldByFormType($this->name, 'position');
        $locationField     = $fieldModel->getFieldByFormType($this->name, 'location');
        $dateIntervalField = $fieldModel->getFieldByFormType($this->name, 'date_interval');
        $detailTableField  = $fieldModel->getFieldByFormType($this->name, 'detail_table');
        foreach ($param AS $key => $value) {
            // 处理地址类型字段数据
            if (in_array($key, $positionField)) {
                if (!empty($value)) {
                    $leadsData[] = [
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
                    $leadsData[] = [
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
                    $leadsData[] = [
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
                    $leadsData[] = [
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

        # 设置今日需联系线索
        if (!empty($param['next_time']) && $param['next_time'] >= strtotime(date('Y-m-d 00:00:00'))) $param['is_dealt'] = 0;

        if ($this->update($param, ['leads_id' => $leads_id], true)) {
            $data['leads_id'] = $leads_id;
            //修改记录
            updateActionLog($param['user_id'], 'crm_leads', $leads_id, $dataInfo, $param);
            RecordActionLog($param['user_id'], 'crm_leads','update', $dataInfo['name'], $dataInfo, $param);
            // 添加线索扩展数据
            db('crm_leads_data')->where('leads_id', $leads_id)->delete();
            array_walk($leadsData, function (&$val) use ($leads_id) {
                $val['leads_id'] = $leads_id;
            });
            db('crm_leads_data')->insertAll($leadsData);
            return $data;
        } else {
            $this->error = '编辑失败';
            return false;
        }
    }

    /**
     * 线索数据
     *
     * @param string $id
     * @return Common|array|bool|\PDOStatement|string|\think\Model|null
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getDataById($id = '', $userId = 0, $model='')
    {
        $map['leads_id'] = $id;
        $dataInfo = db('crm_leads')->where($map)->find();
        if (!$dataInfo) {
            $this->error = '暂无此数据';
            return false;
        }

        if(empty($model) && $model!='update'){
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
                    $dataInfo[$val['field']] = !empty($dataInfo[$val['field']]) ? (string)substr_replace($dataInfo[$val['field']], '*****',0,strlen($dataInfo[$val['field']])) : null;
                }
            }
        }
        $userModel = new \app\admin\model\User();
        $dataInfo['create_user_id_info'] = isset($dataInfo['create_user_id']) ? $userModel->getUserById($dataInfo['create_user_id']) : [];
        $dataInfo['owner_user_id_info'] = isset($dataInfo['owner_user_id']) ? $userModel->getUserById($dataInfo['owner_user_id']) : [];
        $dataInfo['create_user_name'] = !empty($dataInfo['create_user_id_info']['realname']) ? $dataInfo['create_user_id_info']['realname'] : '';
        $dataInfo['owner_user_name'] = !empty($dataInfo['owner_user_id_info']['realname']) ? $dataInfo['owner_user_id_info']['realname'] : '';
        # 关注
        $starId = empty($userId) ? 0 : Db::name('crm_star')->where(['user_id' => $userId, 'target_id' => $id, 'type' => 'crm_leads'])->value('star_id');
        $dataInfo['star'] = !empty($starId) ? 1 : 0;
        # 处理时间格式处理
        $fieldModel = new \app\admin\model\Field();
        $datetimeField = $fieldModel->getFieldByFormType('crm_leads', 'datetime'); //日期时间类型
        foreach ($datetimeField as $key => $val) {
            $dataInfo[$val] = !empty($dataInfo[$val]) ? date('Y-m-d H:i:s', $dataInfo[$val]) : null;
        }
        $dataInfo['create_time'] = !empty($dataInfo['create_time']) ? date('Y-m-d H:i:s', $dataInfo['create_time']) : null;
        $dataInfo['update_time'] = !empty($dataInfo['update_time']) ? date('Y-m-d H:i:s', $dataInfo['update_time']) : null;
        $dataInfo['last_time']   = !empty($dataInfo['last_time'])   ? date('Y-m-d H:i:s', $dataInfo['last_time'])   : null;
        // 字段授权
        if (!empty($userId)) {
            $grantData = getFieldGrantData($userId);
            $userLevel = isSuperAdministrators($userId);
            foreach ($dataInfo AS $key => $value) {
                if (!$userLevel && !empty($grantData['crm_leads'])) {
                    $status = getFieldGrantStatus($key, $grantData['crm_leads']);

                    # 查看权限
                    if ($status['read'] == 0) unset($dataInfo[$key]);
                }
            }
        }
        return $dataInfo;
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
        # 线索
        $leads = Db::name('crm_leads')->field(['create_user_id','owner_user_id', 'create_time', 'update_time', 'last_time'])->where('leads_id', $id)->find();
        # 创建人
        $realname = Db::name('admin_user')->where('id', $leads['create_user_id'])->value('realname');

        # zjf   20210726
        $userModel   = new \app\admin\model\User();
        $ownerUserInfo = $userModel->getUserById($leads['owner_user_id']);
        # 负责人部门
        $ownerStructureName = $ownerUserInfo['structure_name'];

        # 负责人
        $ownerUserName = $ownerUserInfo['realname'];
        return [
            'create_user_id' => $realname,
            'owner_user_id' => $ownerUserName,
            'create_time' => date('Y-m-d H:i:s', $leads['create_time']),
            'update_time' => date('Y-m-d H:i:s', $leads['update_time']),
            'last_time' => !empty($leads['last_time']) ? date('Y-m-d H:i:s', $leads['last_time']) : '',
            'owner_user_structure_name' => $ownerStructureName
        ];
    }
}