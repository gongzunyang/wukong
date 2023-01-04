<?php
// +----------------------------------------------------------------------
// | Description: 附件
// +----------------------------------------------------------------------
// | Author:  Michael_xu | gengxiaoxu@5kcrm.com
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\work\traits\WorkAuthTrait;
use think\Hook;
use think\Request;

class File extends ApiCommon
{
    use WorkAuthTrait;

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
            'allow'=>['index', 'save', 'delete', 'update', 'read', 'download', 'deleteall', 'downloadimage']
        ];
        Hook::listen('check_auth',$action);
        $request = Request::instance();
        $a = strtolower($request->action());        
        if (!in_array($a, $action['permission'])) {
            parent::_initialize();
        }         
    }

    /**
     * 附件列表
     * @author Michael_xu
     * @param 
     * @return                            
     */
    public function index()
    {
        $fileModel = model('File');
        $param = $this->param;
        $data = $fileModel->getDataList($param, $param['by']);
        return resultArray(['data' => $data]);
    }

	/**
     * 附件上传
     * @author Michael_xu
     * @return                            
     */
    public function save()
    {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: POST');
        header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
        $type     = $this->param['type'];
        $files    = request()->file('file');
        $imgs     = request()->file('img');
        $i        = 0;
        $newFiles = [];

        # 项目上传附件权限
        if (!empty($this->param['module']) && $this->param['module'] == 'work_task' && !empty($this->param['work_id'])) {
            if (!$this->checkWorkOperationAuth('uploadTaskFile', $this->param['work_id'], $this->userInfo['id'])) {
                header('Content-Type:application/json; charset=utf-8');
                exit(json_encode(['code' => 102, 'error' => '无权操作！']));
            }
        }

        if (!empty($type) && in_array($type, ['img', 'file'])) {
            # todo 兼容11.0前端
            if ($type == 'img') {
                $newFiles[0]['obj']   = $files;
                $newFiles[0]['types'] = 'img';
            }
            if ($type == 'file') {
                $newFiles[0]['obj']   = $files;
                $newFiles[0]['types'] = 'file';
            }
        } else {
            # todo 兼容9.0前端
            if (!empty($files)) {
                foreach ($files as $v) {
                    $newFiles[$i]['obj']   = $v;
                    $newFiles[$i]['types'] = 'file';
                    $i++;
                }
            }
            if (!empty($imgs)) {
                foreach ($imgs as $v) {
                    $newFiles[$i]['obj']   = $v;
                    $newFiles[$i]['types'] = 'img';
                    $i++;
                }
            }
        }


        $fileModel = model('File');
        $param = $this->param;
        $param['create_user_id'] = $this->userInfo['id'];
        $res = $fileModel->createData($newFiles, $param);
		if($res){
			return resultArray(['data' => $res]);
		} else {
			return resultArray(['error' => $fileModel->getError()]);
		}
        
    }

	/**
     * 附件删除
     * @author Michael_xu
     * @param 通过 save_name 作为条件 来删除附件
     * @return                            
     */ 
    public function delete()
    {
        $fileModel = model('File');
        $param = $this->param;

        # 项目删除附件权限
        if (!empty($this->param['module']) && $this->param['module'] == 'work_task' && !empty($this->param['work_id'])) {
            if (!$this->checkWorkOperationAuth('deleteTaskFile', $this->param['work_id'], $this->userInfo['id'])) {
                header('Content-Type:application/json; charset=utf-8');
                exit(json_encode(['code' => 102, 'error' => '无权操作！']));
            }
        }

        $res = $fileModel->delFileBySaveName($param['save_name'], $param);
        if (!$res) {
            return resultArray(['error' => $fileModel->getError()]);
        }
        return resultArray(['data' => '删除成功']);        
    }

    /**
     * 全部删除(活动、产品)
     *
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function deleteAll()
    {
        if ((empty($this->param['module']) && empty($this->param['module_id'])) || empty($this->param['file_id'])) {
            return resultArray(['error' => '参数错误！']);
        }

        $fileModel = new \app\admin\model\File();

        if (!$fileModel->deleteAll($this->param)) return resultArray(['error' => '操作失败！']);

        return resultArray(['data' => '操作成功！']);
    }

    /**
     * 附件编辑
     */
    public function update()
    {
        $fileModel = model('File');
        $param = $this->param;
        if ( $param['save_name'] && $param['name'] ) {
            $ret = $fileModel->updateNameBySaveName($param['save_name'],$param['name']);
            if ($ret) {
                return resultArray(['data'=>'操作成功']);
            } else {
                return resultArray(['error'=>'操作失败']);
            } 
        } else {
            return resultArray(['error'=>'参数错误']);
        }
    }

	/**
     * 附件查看（下载）
     * @author Michael_xu
     * @return                            
     */  
    public function read()
    {
        $fileModel = model('File');
        $param = $this->param;
        $data = $fileModel->getDataBySaveName($param['save_name']);
        if (!$data) {
            return resultArray(['error' => $this->getError()]);
        }
        return resultArray(['data' => $data]);        
    }   
    
    /**
     * 静态资源文件下载
     */
    public function download()
    {
        if(isset($this->param['path'])){
            $path = $this->param['path'];
            $name = $this->param['name'] ?: '';
            if (empty($path)) return resultArray(['error' => '参数错误！']);
            return download(realpath('./public/' . $path), $name);
        }else{
            $path = $this->param['save_name'];
            $name = $this->param['name'] ?: '';
            if (empty($path)) return resultArray(['error' => '参数错误！']);
            if (!strstr($path, 'uploads')) $path = 'uploads/' . $path;
            return download(realpath('./public/' . $path), $name);
        }
    }

    /**
     * 下载图片（头像），前端要求重写一个。
     *
     * @return \think\response\Json|void
     */
    public function downloadImage()
    {
        $path = $this->param['path'];
        $file = explode('public/', $path);

        if (empty($path) || empty($file[1])) return resultArray(['error' => '参数错误！']);

        return download(realpath('./public/'.$file[1]));
    }
}
