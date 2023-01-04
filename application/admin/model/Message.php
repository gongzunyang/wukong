<?php
// +----------------------------------------------------------------------
// | Description: 站内信
// +----------------------------------------------------------------------
// | Author:  ymob
// +----------------------------------------------------------------------
namespace app\admin\model;

use app\admin\model\ImportRecord as ImportRecordModel;
use app\admin\model\User as UserModel;
use app\crm\model\Contract as ContractModel;
use app\crm\model\Invoice;
use app\crm\model\Receivables as ReceivablesModel;
use app\oa\model\Announcement as AnnouncementModel;
use app\oa\model\Event as EventModel;
use app\oa\model\Examine as ExamineModel;
use app\oa\model\ExamineCategory;
use app\oa\model\Log as LogModel;
use app\work\model\Task as TaskModel;

class Message extends Common
{
    protected $name = 'admin_message';

    protected $autoWriteTimestamp = true;
    protected $createTime = 'send_time';
    protected $updateTime = false;

    /**
     * 错误信息
     */
    public $error = '';

    /**
     * 将要发送的消息内容
     */
    protected $content = '';

    /**
     * 消息类型
     */
    protected $type = 0;

    /**
     * 任务分配
     */
    const TASK_ALLOCATION = 1;
    /**
     * 任务邀请
     */
    const TASK_INVITE = 2;
    /**
     * 任务结束
     */
    const TASK_OVER = 3;
    /**
     * 回复日志
     */
    const LOG_REPLAY = 4;
    /**
     * 发送日志
     */
    const LOG_SEND = 5;
    /**
     * 审批待处理
     */
    const EXAMINE_TO_DO = 6;
    /**
     * 审批驳回
     */
    const EXAMINE_REJECT = 7;
    /**
     * 审批通过
     */
    const EXAMINE_PASS = 8;
    /**
     * 公告
     */
    const NOTICE_MESSAGE = 9;
    /**
     * 日程
     */
    const EVENT_MESSAGE = 10;
    /**
     * 合同待审批
     */
    const CONTRACT_TO_DO = 11;
    /**
     * 合同审批驳回
     */
    const CONTRACT_REJECT = 12;
    /**
     * 合同审批通过
     */
    const CONTRACT_PASS = 13;
    /**
     * 回款待审批
     */
    const RECEIVABLES_TO_DO = 14;
    /**
     * 回款审批驳回
     */
    const RECEIVABLES_REJECT = 15;
    /**
     * 回款审批通过
     */
    const RECEIVABLES_PASS = 16;
    /**
     * 客户导入
     */
    const IMPORT_CUSTOMER = 17;
    /**
     * 联系人
     */
    const IMPORT_CONTACTS = 18;
    /**
     * 线索
     */
    const IMPORT_LEADS = 19;
    /**
     * 产品
     */
    const IMPORT_PRODUCT = 20;
    /**
     * 团队成员-客户
     */
    const TEAM_CUSTOMER = 21;
    /**
     * 团队成员-商机
     */
    const TEAM_BUSINESS = 22;
    /**
     * 团队成员-合同
     */
    const TEAM_CONTRACT = 23;
    /**
     * 发票待审批
     */
    const INVOICE_TO_DO = 24;
    /**
     * 发票审批驳回
     */
    const INVOICE_REJECT = 25;
    /**
     * 发票审批通过
     */
    const INVOICE_PASS = 26;
    /**
     * 项目任务导入
     */
    const IMPORT_TASK = 27;
    /**
     * 退出商机团队
     */
    const BUSINESS_PASS = 28;
    /**
     * 退出客户团队
     */
    const CUSTOMER_PASS = 29;
    /**
     * 退出合同团队
     */
    const CONTRACT_END = 30;
    /**
     * 移除团队成员
     */
    const TEAM_END = 31;
    /**
     * 移除队成员
     */
    const TEAM_LEADS = 32;
    /**
     * 采购单待审批
     */
    const PURCHASE_TO_DO = 33;
    /**
     * 采购单审批驳回
     */
    const PURCHASE_REJECT = 34;
    /**
     * 采购单审批通过
     */
    const PURCHASE_PASS = 35;
    /**
     * 采购退货单待审批
     */
    const RETREAT_TO_DO = 36;
    /**
     * 采购退货单审批驳回
     */
    const RETREAT_REJECT = 37;
    /**
     * 采购退货单审批通过
     */
    const RETREAT_PASS = 38;
    /**
     * 销售订单待审批
     */
    const SALE_TO_DO = 39;
    /**
     * 销售订单审批驳回
     */
    const SALE_REJECT = 40;
    /**
     * 销售订单审批通过
     */
    const SALE_PASS = 41;
    /**
     * 销售退货单待审批
     */
    const SALERETURN_TO_DO = 42;
    /**
     * 销售退货单审批驳回
     */
    const SALERETURN_REJECT = 43;
    /**
     * 销售退货单审批通过
     */
    const SALERETURN_PASS = 44;
    /**
     * 回款单待审批
     */
    const COLLECTION_TO_DO = 45;
    /**
     * 回款单审批驳回
     */
    const COLLECTION_REJECT = 46;
    /**
     * 回款单审批通过
     */
    const COLLECTION_PASS = 47;
    /**
     * 付款单待审批
     */
    const PAYMENT_TO_DO = 48;
    /**
     * 付款单审批驳回
     */
    const PAYMENT_REJECT = 49;
    /**
     * 付款单审批通过
     */
    const PAYMENT_PASS = 50;
    /**
     * 调拨待审批
     */
    const ALLOCATION_TO_DO = 51;
    /**
     * 调拨审批驳回
     */
    const ALLOCATION_REJECT = 52;
    /**
     * 调拨审批通过
     */
    const ALLOCATION_PASS = 53;
    /**
     * 盘点待审批
     */
    const INVENTORY_TO_DO = 54;
    /**
     * 盘点审批驳回
     */
    const INVENTORY_REJECT = 55;
    /**
     * 盘点审批通过
     */
    const INVENTORY_PASS = 56;
    
    /**
     * 消息类型
     *
     * @var array
     * @author Ymob
     * @datetime 2019-10-17 15:27:43
     */
    protected $typeList = [
        1 => [
            'template' => '{from_user} 将 {title} 任务分配给您，请及时查看。',
        ],
        2 => [
            'template' => '{from_user} 邀请您参与 {title} 任务，请及时查看。',
        ],
        3 => [
            'template' => '{from_user} 将 {title} 任务标记结束。',
        ],
        4 => [
            'template' => '{from_user} 回复了您的 {title} 日志：“今天工作状态不错，继续加油！”，请及时查看',
        ],
        5 => [
            'template' => '{from_user} 将日志 {title} 发送给您，请及时查看。',
        ],
        6 => [
            'template' => '{from_user} 提交 {title} 审批，请及时处理。',
        ],
        7 => [
            'template' => '{from_user} 拒绝您的 {title} 审批，拒绝理由：“日期填写错误”，请及时处理。',
        ],
        8 => [
            'template' => '{from_user} 已经审核通过您的 {title} ，请及时查看。',
        ],
        9 => [
            'template' => '您有一个新公告 {title} ，请及时查看。',
        ],
        10 => [
            'template' => '{from_user} 邀请您参与 {title} 日程，将于**分钟后开始，请及时查看。',
        ],
        11 => [
            'template' => '{from_user} 提交 {title} 合同审批待您处理，请及时查看。',
        ],
        12 => [
            'template' => '{from_user} 拒绝您的 {title} 合同审批，拒绝理由：“日期填写错误”，请及时处理。',
        ],
        13 => [
            'template' => '{from_user} 已经审核通过您的 {title} 合同，请及时查看',
        ],
        14 => [
            'template' => '{from_user} 提交 {title} 回款审批待您处理，请及时查看。',
        ],
        15 => [
            'template' => '{from_user} 拒绝您的 {title} 回款审批，拒绝理由：“日期填写错误”，请及时处理。',
        ],
        16 => [
            'template' => '{from_user} 已经审核通过您的 {title} 回款，请及时查看。',
        ],
        17 => [
            // 'template' => '{from_user} 导入客户数据，共 {total} 条，已导入 {done} 条 ， 成功 {success} 条， 覆盖 {cover} 条, 失败 {error} 条。',
            'template' => '{total},{cover},{success},{error}',
        ],
        18 => [
            // 'template' => '{from_user} 导入联系人数据，共 {total} 条，已导入 {done} 条 ， 成功 {success} 条， 覆盖 {cover} 条, 失败 {error} 条。',
            'template' => '{total},{cover},{success},{error}',
        ],
        19 => [
            // 'template' => '{from_user} 导入线索数据，共 {total} 条，已导入 {done} 条 ， 成功 {success} 条， 覆盖 {cover} 条, 失败 {error} 条。',
            'template' => '{total},{cover},{success},{error}',
        ],
        20 => [
            // 'template' => '{from_user} 导入产品数据，共 {total} 条，已导入 {done} 条 ， 成功 {success} 条， 覆盖 {cover} 条, 失败 {error} 条。',
            'template' => '{total},{cover},{success},{error}',
        ],
        21 => [
            'template' => '{from_user} 将您添加为客户 {title} 的成员。',
        ],
        22 => [
            'template' => '{from_user} 将您添加为商机 {title} 的成员。',
        ],
        23 => [
            'template' => '{from_user} 将您添加为合同 {title} 的成员。',
        ],
        24 => [
            'template' => '{from_user} 提交 {title} 发票审批待您处理，请及时查看。',
        ],
        25 => [
            'template' => '{from_user} 拒绝您的 {title} 发票审批，请及时处理。',
        ],
        26 => [
            'template' => '您的 {title} 发票已经审批通过，请及时查看。',
        ],
        27 => [
            // 'template' => '{date}，{from_user} 导入任务，共 {total} 条，已导入 {done} 条 ， 成功 {success} 条， 覆盖 {cover} 条, 失败 {error} 条。{title}',
            'template' => '{total},{cover},{success},{error}',
        ],
        28 => [
            'template' => '{from_user} 退出了您商机 {title} 的团队。',
        ],
        29 => [
            'template' => '{from_user} 退出了您客户 {title} 的团队。',
        ],

        30 => [
            'template' => '{from_user} 退出了您合同 {title} 的团队。',
        ],
        31 => [
            'template' => '将{from_user} 移除了您 {title} 的团队。',
        ],
        32 => [
            'template' => '{from_user} 将您添加为线索 {title} 的成员。',
        ],
    ];

    /**
     * 消息类型分组
     */
    public static $typeGroup = [
        'announcement' => [
            self::NOTICE_MESSAGE,
        ],
        'examine' => [
            self::EXAMINE_TO_DO,
            self::EXAMINE_REJECT,
            self::EXAMINE_PASS,
        ],
        'task' => [
            self::TASK_ALLOCATION,
            self::TASK_INVITE,
            self::TASK_OVER,
            self::IMPORT_TASK,
        ],
        'log' => [
            self::LOG_REPLAY,
            self::LOG_SEND,
        ],
        'event' => [
            self::EVENT_MESSAGE,
        ],
        'crm' => [
            self::CONTRACT_TO_DO,
            self::CONTRACT_REJECT,
            self::CONTRACT_PASS,
            self::RECEIVABLES_TO_DO,
            self::RECEIVABLES_REJECT,
            self::RECEIVABLES_PASS,
            self::IMPORT_CUSTOMER,
            self::IMPORT_CONTACTS,
            self::IMPORT_LEADS,
            self::IMPORT_PRODUCT,
            self::TEAM_CUSTOMER,
            self::TEAM_BUSINESS,
            self::TEAM_CONTRACT,
            self::INVOICE_TO_DO,
            self::INVOICE_REJECT,
            self::INVOICE_PASS,
            self::BUSINESS_PASS,
            self::CUSTOMER_PASS,
            self::CONTRACT_END,
        ],
        'jxc' => [
            self::PURCHASE_TO_DO,
            self::PURCHASE_REJECT,
            self::PURCHASE_PASS,
            self::RETREAT_TO_DO,
            self::RETREAT_REJECT,
            self::RETREAT_PASS,
            self::SALE_TO_DO,
            self::SALE_REJECT,
            self::SALE_PASS,
            self::SALERETURN_TO_DO,
            self::SALERETURN_REJECT,
            self::SALERETURN_PASS,
            self::COLLECTION_TO_DO,
            self::COLLECTION_REJECT,
            self::COLLECTION_PASS,
            self::PAYMENT_TO_DO,
            self::PAYMENT_REJECT,
            self::PAYMENT_PASS,
            self::ALLOCATION_TO_DO,
            self::ALLOCATION_REJECT,
            self::ALLOCATION_PASS,
            self::INVENTORY_TO_DO,
            self::INVENTORY_REJECT,
            self::INVENTORY_PASS,
        ]
    ];

    /**
     * 发送系统通知
     *
     * @param int $type 消息类型
     * @param array $data 关联信息
     * @param array|int $user_id 接收消息员工ID
     * @param boolean $system 是否系统消息
     * @return bool
     * @author Ymob
     * @datetime 2019-10-17 17:23:05
     */
    public function send($type, $data, $user_id_list, $system = false)
    {
        if (!isset($this->typeList[$type])) {
            $this->error = '消息类型错误';
            return false;
        }
        $user_id_list = (array)$user_id_list;
        $user_id_list = array_unique(array_filter($user_id_list));
        if (empty($user_id_list)) {
            $this->error = '接收人不能为空';
            return false;
        }

        $action_id = $data['action_id'];
        $title = $data['title'];
        $content = $this->typeList[$type]['template'];
        foreach ($data as $key => $val) {
            $content = str_replace('{' . $key . '}', $val, $content);
        }
        $advance_time= $data['advance_time'];
        $content = str_replace('{from_user}', User::userInfo('realname'), $content);
        $content = str_replace('{date}', date('Y-m-d'), $content);
        $data = [];
        $data['type'] = $type;
        $data['content'] = $content;
        $data['action_id'] = $action_id;
        $data['read_time'] = 0;
        $data['from_user_id'] = $system ? 0 : User::userInfo('id');
        $data['title'] = $title;
        $data['advance_time'] = $advance_time ?: 0;
        $request = request();
        $data['controller_name'] = strtolower($request->controller());
        $data['module_name'] = strtolower($request->module());
        $data['action_name'] = strtolower($request->action());

        $from_user_id = $data['from_user_id'];
        if (!in_array($type,[9,17,18,19,20,27])) {
            $user_id_list = array_filter($user_id_list, function ($val) use ($from_user_id) {
                return $val !== $from_user_id;
            });
        }

        $all_data = [];
        foreach ($user_id_list as $user_id) {
            $temp = $data;
            $temp['to_user_id'] = $user_id;
            $all_data[] = $temp;
        }
        if (!empty($from_user_id) && class_exists('DingTalk')) {
            (new Dingtalk())->message($user_id_list, $content);
        }
        $this->saveAll($all_data);
    }

    /**
     * 获取关联模块数据
     *
     * @author Ymob
     * @datetime 2019-10-22 15:34:35
     */
    public function getRelationTitleAttr($val, $data)
    {
        switch ($data['type']) {
            // 任务
            case self::TASK_ALLOCATION:
            case self::TASK_INVITE:
            case self::TASK_OVER:
                return TaskModel::where(['task_id' => $data['action_id']])->value('name') ?: '';

            // 日志
            case self::LOG_REPLAY:
            case self::LOG_SEND:
                return LogModel::where(['log_id' => $data['action_id']])->value('title') ?: '';

            // 审批
            case self::EXAMINE_TO_DO:
            case self::EXAMINE_REJECT:
            case self::EXAMINE_PASS:
                $category_id = ExamineModel::where(['examine_id' => $data['action_id']])->value('category_id') ?: 0;
                $categoryInfo = (new ExamineCategory())->getDataById($category_id);
                return $categoryInfo['title'];

            // 公告
            case self::NOTICE_MESSAGE:
                return AnnouncementModel::where(['announcement_id' => $data['action_id']])->value('title') ?: '';

            // 日程
            case self::EVENT_MESSAGE:
                return EventModel::where(['event_id' => $data['action_id']])->value('title') ?: '';

            // 合同
            case self::CONTRACT_TO_DO:
            case self::CONTRACT_REJECT:
            case self::CONTRACT_PASS:
            case self::TEAM_CONTRACT:
                return ContractModel::where(['contract_id' => $data['action_id']])->value('name') ?: '';

            // 回款
            case self::RECEIVABLES_TO_DO:
            case self::RECEIVABLES_REJECT:
            case self::RECEIVABLES_PASS:
                return ReceivablesModel::where(['receivables_id' => $data['action_id']])->value('number') ?: '';

            // 发票
            case self::INVOICE_TO_DO:
            case self::INVOICE_REJECT:
            case self::INVOICE_PASS:
                return Invoice::where(['invoice_id' => $data['action_id']])->value('invoice_apple_number') ?: '';

            // 导入数据
            case self::IMPORT_CUSTOMER:
            case self::IMPORT_CONTACTS:
            case self::IMPORT_LEADS:
            case self::IMPORT_PRODUCT:
            case self::IMPORT_TASK:
                $error = ImportRecordModel::where(['id' => $data['action_id']])->value('error');
                return $error ? '点击下载错误数据' : '';

            // 客户
            case self::TEAM_CUSTOMER:
            case self::CUSTOMER_PASS:
                return CustomerModel::where(['customer_id' => $data['action_id']])->value('name') ?: '';

            // 商机
            case self::TEAM_BUSINESS:
            case self::BUSINESS_PASS:
                return BusinessModel::where(['business_id' => $data['action_id']])->value('name') ?: '';

            // 采购单
            case self::PURCHASE_TO_DO:
            case self::PURCHASE_REJECT:
            case self::PURCHASE_PASS:
                return PurchaseModel::where(['purchase_id' => $data['action_id']])->value('order_number') ?: '';

            // 采购退货单
            case self::RETREAT_TO_DO:
            case self::RETREAT_REJECT:
            case self::RETREAT_PASS:
                return RetreatModel::where(['retreat_id' => $data['action_id']])->value('order_number') ?: '';

            // 销售订单
            case self::SALE_TO_DO:
            case self::SALE_REJECT:
            case self::SALE_PASS:
                return SaleModel::where(['sale_id' => $data['action_id']])->value('order_number') ?: '';

            // 销售退货单订单
            case self::SALERETURN_TO_DO:
            case self::SALERETURN_REJECT:
            case self::SALERETURN_PASS:
                return SalereturnModel::where(['salereturn_id' => $data['action_id']])->value('order_number') ?: '';

            // 回款单
            case self::COLLECTION_TO_DO:
            case self::COLLECTION_REJECT:
            case self::COLLECTION_PASS:
                return CollectionModel::where(['collection_note_id' => $data['action_id']])->value('collection_no') ?: '';

            // 付款单
            case self::PAYMENT_TO_DO:
            case self::PAYMENT_REJECT:
            case self::PAYMENT_PASS:
                return PaymentModel::where(['payment_note_id' => $data['action_id']])->value('payment_no') ?: '';

            // 调拨
            case self::ALLOCATION_TO_DO:
            case self::ALLOCATION_REJECT:
            case self::ALLOCATION_PASS:
                return PaymentModel::where(['allocation_id' => $data['action_id']])->value('allocation_code') ?: '';

            // 盘点
            case self::INVENTORY_TO_DO:
            case self::INVENTORY_REJECT:
            case self::INVENTORY_PASS:
                return PaymentModel::where(['inventory_id' => $data['action_id']])->value('inventory_number') ?: '';

        }

        return '';
    }

    /**
     * 发送人
     */
    public function getFromUserIdInfoAttr($val, $data)
    {
        return $data['from_user_id'] ? UserModel::getUserById($data['from_user_id']) : [];
    }
}
