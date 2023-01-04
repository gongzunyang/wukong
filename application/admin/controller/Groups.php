<?php
// +----------------------------------------------------------------------
// | Description: 用户组
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com 
// +----------------------------------------------------------------------

namespace app\admin\controller;

use app\admin\logic\FieldGrantLogic;
use think\Hook;
use think\Request;

class Groups extends ApiCommon
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
            'allow'=>['index','enables','copy','typelist','save','update','delete']
        ];
        Hook::listen('check_auth',$action);
        $request = Request::instance();
        $a = strtolower($request->action());        
        if (!in_array($a, $action['permission'])) {
            parent::_initialize();
        } 
        //权限判断
        $unAction = ['index','typelist'];
        if (!in_array($a, $unAction) && !checkPerByAction('admin', 'groups', 'update')) {
            header('Content-Type:application/json; charset=utf-8');
            exit(json_encode(['code'=>102,'error'=>'无权操作']));
        }                        
    }        

    /**
     * 角色列表
     * @author Michael_xu
     * @param 
     * @return                            
     */     
    public function index()
    {         
        $groupModel = model('Group');
        $param = $this->param;
        $data = $groupModel->getDataList($param);
        return resultArray(['data' => $data]);
    }

    /**
     * 角色详情
     * @author Michael_xu
     * @param 
     * @return                            
     */    
    public function read()
    {   
        $groupModel = model('Group');
        $param = $this->param;
        $data = $groupModel->getDataById($param['id']);
        if (!$data) {
            return resultArray(['error' => $groupModel->getError()]);
        } 
        return resultArray(['data' => $data]);
    }

    /**
     * 角色添加
     * @author Michael_xu
     * @param 
     * @return                            
     */    
    public function save(FieldGrantLogic $fieldGrantLogic)
    {
        $userInfo=$this->userInfo;
        $groupModel = model('Group');
        $param = $this->param;
		$param['rules'] = arrayToString($param['rules']);
        $lastInsId = $groupModel->createData($param);
        if (!$lastInsId) {
            return resultArray(['error' => $groupModel->getError()]);
        }
        # 添加记录
        SystemActionLog($userInfo['id'], 'admin_group','role', $lastInsId, 'save', $param['title'], '', '', '添加了角色：' . $param['title']);
    
        # 新增客户管理角色的字段授权数据
        if (isset($param['pid']) && $param['pid'] == 2) {
            $fieldGrantLogic->createCrmFieldGrant($lastInsId);
        }

        return resultArray(['data' => 1]);
    }

    /**
     * 角色编辑
     * @author Michael_xu
     * @param 
     * @return                            
     */     
    public function update()
    {        
        $groupModel = model('Group');
        $param = $this->param;
        $userInfo=$this->userInfo;
        $param['user_id']=$userInfo['id'];
        $dataInfo = $groupModel->getDataById($param['id']);
        if (!$dataInfo) {
            return resultArray(['error' => '参数错误']);
        }

        # 处理前端传来的type是work的错误
        if (!empty($param['type']) && $param['type'] == 'work') $param['type'] = 1;

        $param['rules'] = arrayToString($param['rules']);
        $data = $groupModel->updateDataById($param, $param['id']);
        return resultArray(['data' => '编辑成功']);
    }

    /**
     * 角色删除
     * @author Michael_xu
     * @param 
     * @return                            
     */     
    public function delete(FieldGrantLogic $fieldGrantLogic)
    {            
        $groupModel = model('Group');
        $param = $this->param;
        $userInfo=$this->userInfo;
        $dataInfo = $groupModel->getDataById($param['id']);
        if (!$dataInfo) {
            return resultArray(['error' => '参数错误']);
        }
        if ($dataInfo['types']) {
            return resultArray(['error' => '系统角色，不能删除']);
        }        
        $data = $groupModel->delGroupById($param['id'],$userInfo['id']);
        if (!$data) {
            return resultArray(['error' => $groupModel->getError()]);
        }

        # 删除字段授权数据
        $fieldGrantLogic->deleteCrmFieldGrant($param['id']);

        return resultArray(['data' => '删除成功']);    
    }

    /**
     * 角色启用、禁用
     * @author Michael_xu
     * @param 
     * @return                            
     */   
    public function enables()
    {        
        $groupModel = model('Group');
        $param = $this->param;
        $dataInfo = $groupModel->getDataById($param['id']);
        if (!$dataInfo) {
            return resultArray(['error' => '参数错误']);
        }
        if ($dataInfo['types']) {
            return resultArray(['error' => '系统角色，不能删除']);
        }         
        $data = $groupModel->enableDatas($param['id'], $param['status'], true);  
        if (!$data) {
            return resultArray(['error' => $groupModel->getError()]);
        } 
        return resultArray(['data' => '操作成功']);         
    }

    /**
     * 角色复制
     * @author Michael_xu
     * @param 
     * @return                            
     */   
    public function copy(FieldGrantLogic $fieldGrantLogic)
    {        
        $groupModel = model('Group');
        $param = $this->param;
        $userInfo = $this->userInfo;
        $dataInfo = $groupModel->getDataById($param['id']);
        if (!$dataInfo) {
            return resultArray(['error' => '参数错误']);
        }
        $dataInfo = json_decode($dataInfo, true);
        unset($dataInfo['id']);
        $titleCount = db('admin_group')->where(['title' => $dataInfo['title']])->count();
        $dataInfo['title'] = $dataInfo['title'].'('.$titleCount.')';
        $data = $groupModel->createData($dataInfo);
        if (!$data) {
            return resultArray(['error' => $groupModel->getError()]);
        }
        # 添加记录
        SystemActionLog($userInfo['id'], 'admin_group','role', $data, 'copy', $dataInfo['title'], '', '', '添加了角色：' . $dataInfo['title']);
    
        # 复制客户管理角色的字段授权数据
        if (!empty($dataInfo['pid']) && $dataInfo['pid'] == 2) {
            $fieldGrantLogic->copyCrmFieldGrant($param['id'], $data);
        }

        return resultArray(['data' => '操作成功']);         
    }

    /**
     * 角色分类列表
     * @author Michael_xu
     * @param 
     * @return                            
     */     
    public function typeList()
    {         
        $groupModel = model('Group');
        $param = $this->param;
        $data = $groupModel->getTypeList($param);
        return resultArray(['data' => $data]);
    }        
}
 