<?php

namespace app\bi\logic;

class ExcelLogic
{
    /**
     * 员工客户分析导出
     * @param $type
     * @param $param
     * @return mixed
     */
    public function biexcle($type, $param)
    {
        $excelModel = new \app\admin\model\Excel();
        $file_name='';
        $field_list=[];
        switch ($type['excel_types']) {
            case 'statistics':
                $file_name = 'totalCustomerTable';
                $field_list = [
                    '0' => ['name' => '员工姓名', 'field' => 'realname'],
                    '1' => ['name' => '新增客户数', 'field' => 'customer_num'],
                    '2' => ['name' => '成交客户数', 'field' => 'deal_customer_num'],
                    '3' => ['name' => '客户成交率', 'field' => 'deal_customer_rate'],
                    '4' => ['name' => '合同总金额', 'field' => 'un_receivables_money'],
                    '5' => ['name' => '回款金额', 'field' => 'receivables_money'],
                ];
                break;
            case 'recordList':
                $file_name = 'customerRecordInfo';
                $field_list = [
                    '0' => ['name' => '员工姓名', 'field' => 'realname'],
                    '1' => ['name' => '跟进次数', 'field' => 'record_num'],
                    '2' => ['name' => '跟进客户数', 'field' => 'customer_num'],
                ];
                break;
            case 'recordMode':
                $file_name = 'customerRecordCategoryStats';
                $field_list = [
                    '0' => ['name' => '跟进方式', 'field' => 'category'],
                    '1' => ['name' => '个数', 'field' => 'recordNum'],
                    '2' => ['name' => '占比', 'field' => 'proportion'],
                ];
                break;
            case 'poolList':
                $file_name = 'poolTable';
                $field_list = [
                    '0' => ['name' => '员工姓名', 'field' => 'realname'],
                    '1' => ['name' => '部门', 'field' => 'username'],
                    '2' => ['name' => '公海池领取客户数', 'field' => 'receive'],
                    '3' => ['name' => '进入公海客户数', 'field' => 'put_in'],
                ];
                break;
            case 'userCycleList':
                $file_name = 'employeeCycleInfo';
                $field_list = [
                    '0' => ['name' => '员工姓名', 'field' => 'realname'],
                    '1' => ['name' => '成交周期（天）', 'field' => 'cycle'],
                    '2' => ['name' => '成交客户数', 'field' => 'customer_num'],
                ];
                break;
            case 'productCycle':
                $file_name = 'addressCycleInfo';
                $field_list = [
                    '0' => ['name' => '地区', 'field' => 'address'],
                    '1' => ['name' => '成交周期（天）', 'field' => 'cycle'],
                    '2' => ['name' => '成交客户数', 'field' => 'customer_num'],
                ];
                break;
            case 'addressCycle':
                $file_name = 'productCycleInfo';
                $field_list = [
                    '0' => ['name' => '产品名称', 'field' => 'product_name'],
                    '1' => ['name' => '成交周期（天）', 'field' => 'cycle'],
                    '2' => ['name' => '成交客户数', 'field' => 'customer_num'],
                ];
                break;
            case 'customerSatisfaction':
                $file_name = 'customerSatisfaction';
                $field_list = [
                    '0' => ['name' => '员工姓名', 'field' => 'realname'],
                    '1' => ['name' => '回访合同总数', 'field' => 'visitContractNum'],
                    '2' => ['name' => '很满意', 'field' => '很满意'],
                    '3' => ['name' => '满意', 'field' => '满意'],
                    '4' => ['name' => '一般', 'field' => '一般'],
                    '5' => ['name' => '不满意', 'field' => '不满意'],
                    '6' => ['name' => '很不满意', 'field' => '很不满意'],
                ];
                break;
            case 'productSatisfaction':
                $file_name = 'productSatisfaction';
                $field_list = [
                    '0' => ['name' => '产品名称', 'field' => 'productName'],
                    '1' => ['name' => '回访次数', 'field' => 'visitNum'],
                    '2' => ['name' => '很满意', 'field' => '很满意'],
                    '3' => ['name' => '满意', 'field' => '满意'],
                    '4' => ['name' => '一般', 'field' => '一般'],
                    '5' => ['name' => '不满意', 'field' => '不满意'],
                    '6' => ['name' => '很不满意', 'field' => '很不满意'],
                ];
                break;
        }
        return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param);
    }

    /**
     * 员工业绩分析
     * @param $type
     * @param $param
     * @return mixed
     */
    public function contractExcel($type, $param)
    {

        $excelModel = new \app\admin\model\Excel();
        if($type['excel_types']=='analysis'){
            $file_name = 'contractNumStats';
            $field_list = [];
            
            return $excelModel->template_download($file_name, $field_list, $type['type'], $param);
        }elseif ($type['excel_types']=='summary'){
            $file_name = 'totalContract';
            $field_list = [
                '0' => ['name' => '日期', 'field' => 'type'],
                '1' => ['name' => '签约合同数（个）', 'field' => 'count'],
                '2' => ['name' => '签约合同金额（元）', 'field' => 'money'],
                '3' => ['name' => '回款金额（元）', 'field' => 'back'],
            ];
            return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param);
        }elseif ($type['excel_types']=='invoice'){
            $file_name = 'invoiceStats';
            $field_list = [
                '0' => ['name' => '日期', 'field' => 'type'],
                '1' => ['name' => '回款金额（元）', 'field' => 'receivables_money'],
                '2' => ['name' => '开票金额（元）', 'field' => 'invoice_money'],
                '3' => ['name' => '已回款未开票（元）', 'field' => 'not_invoice'],
                '4' => ['name' => '已开票未回款（元）', 'field' => 'not_receivables'],
            ];
            return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param);
        }
//        switch ($type['excel_types']) {
//            case 'analysis':
//
//
//                break;
//            case 'summary':
//                $file_name = 'totalContract';
//                $field_list = [
//                    '0' => ['name' => '日期', 'field' => 'type'],
//                    '1' => ['name' => '签约合同数（个）', 'field' => 'count'],
//                    '2' => ['name' => '签约合同金额（元）', 'field' => 'money'],
//                    '3' => ['name' => '回款金额（元）', 'field' => 'back'],
//                ];
//                return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param['items']);
//                break;
//            case 'invoice':
//                $file_name = 'invoiceStats';
//                $field_list = [
//                    '0' => ['name' => '日期', 'field' => 'type'],
//                    '1' => ['name' => '回款金额（元）', 'field' => 'receivables_money'],
//                    '2' => ['name' => '开票金额（元）', 'field' => 'invoice_money'],
//                    '3' => ['name' => '已回款未开票（元）', 'field' => 'not_invoice'],
//                    '4' => ['name' => '已开票未回款（元）', 'field' => 'not_receivables'],
//                ];
//                return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param);
//                break;
//        }


    }

    /**
     * 产品分析
     * @param $type
     * @param $param
     * @return mixed
     */
    public function productExcel($type, $param)
    {
        $file_name = 'contractNumStats';
        $field_list = [
            '0' => ['name' => '产品分类', 'field' => 'category_id_info'],
            '1' => ['name' => '产品名称', 'field' => 'product_name'],
            '2' => ['name' => '合同数', 'field' => 'contract_product_sum'],
            '3' => ['name' => '数量合计', 'field' => 'product_sum'],
            '4' => ['name' => '订单产品小计', 'field' => 'contract_money'],
        ];
        $type = '产品销售情况统计';
        $excelModel = new \app\admin\model\Excel();
        return $excelModel->biExportExcel($file_name, $field_list, $type, $param);
    }

    /**
     * 排行榜
     * @param $type
     * @param $param
     * @return mixed
     */
    public function rankingExcle($type, $param)
    {

        $excelModel = new \app\admin\model\Excel();
        switch ($type['excel_types']) {
            case 'contract':
                $file_name = 'contractRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '合同金额（元）', 'field' => 'money'],
                ];
                break;
            case 'receivablesRanKingExport':
                $file_name = 'receivablesRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '回款金额（元）', 'field' => 'money'],
                ];
                break;
            case 'signing':
                $file_name = 'signingRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '签约合同', 'field' => 'count'],
                ];
                break;
            case 'product':
                $file_name = 'productCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '产品销量', 'field' => 'num'],
                ];
                break;
            case 'addCustomer':
                $file_name = 'customerCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '新增客户数（个）', 'field' => 'count'],
                ];
                break;
            case 'addContacts':
                $file_name = 'contactsCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '新增联系人数（个）', 'field' => 'count'],
                ];
                break;
            case 'recordNun':
                $file_name = 'FollowupRecordCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '跟进次数（个）', 'field' => 'count'],
                ];
                break;
            case 'recordCustomer':
                $file_name = 'customerFollowupCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '跟进客户数（个）', 'field' => 'count'],
                ];
                break;
            case 'examine':
                $file_name = 'travelCountRanKing';
                $field_list = [
                    '0' => ['name' => '公司总排名', 'field' => 'id'],
                    '1' => ['name' => '签订人', 'field' => 'user_name'],
                    '2' => ['name' => '部门', 'field' => 'structure_name'],
                    '3' => ['name' => '出差次数（次）', 'field' => 'count'],
                ];
                break;
        }
        return $excelModel->biExportExcel($file_name, $field_list, $type['type'], $param);
    }

    /**
     * 业绩目标完成情况
     * @param $type
     * @param $param
     * @return mixed
     */
    public function achienementExcel($param)
    {
        $file_name = 'contractNumStats';
        $field_list = [
            '0' => ['name' => '名称', 'field' => 'name'],
            '1' => ['name' => '月份', 'field' => 'month'],
            '2' => ['name' => '目标', 'field' => 'achievement'],
            '3' => ['name' => '完成', 'field' => 'money'],
            '4' => ['name' => '完成率', 'field' => 'rate'],
        ];
        $type = '业绩目标完成情况';
        $excelModel = new \app\admin\model\Excel();
        $item=[];
        foreach ($param as $value) {
            foreach ($value as $v) {
                $item[] = $v;
            }
        }
        return $excelModel->biExportExcel($file_name, $field_list, $type, $item);
    }


}