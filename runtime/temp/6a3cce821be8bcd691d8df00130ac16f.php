<?php if (!defined('THINK_PATH')) exit(); /*a:3:{s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php/application/admin\view\install\step5.html";i:1672829736;s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php\application\admin\view\public\header.html";i:1672829736;s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php\application\admin\view\public\footer.html";i:1672829736;}*/ ?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>悟空CRM安装向导</title>
    <link rel="shortcut icon" href="/public/static/icon/favicon.ico">
    <link rel="stylesheet" href="/public/static/style/base.css">
    <link rel="stylesheet" href="/public/static/style/step3.css">
    <script src="/public/static/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="header-wrapper">
    <header class="header">
  <div class="header-content">
    <h1 class="logo">
      <a href="http://www.5kcrm.com"><img class="pic" src="/public/static/img/logo.png" alt=""></a>
    </h1>
    <div class="title">
      悟空CRM11.0安装向导
    </div>
    <div class="concat-us">
      <img class="icon" src="/public/static/icon/phone.png" alt="">
      <span class="desc">官方电话：400-0812-558</span>
    </div>
  </div>
</header>

</div>
<div class="top">
    <div class="step-group">
        <div class="step active">
            <div class="sort">
                <img class="pic" style="width:100%; height: 100%;" src="/public/static/icon/success.png" alt="">
            </div>
            <div class="desc">检查安装环境</div>
        </div>
        <div class="step active line"></div>
        <div class="step active">
            <div class="sort">
                <img class="pic" style="width:100%; height: 100%;" src="/public/static/icon/success.png" alt="">
            </div>
            <div class="desc">创建数据库</div>
        </div>
        <div class="step line active"></div>
        <div class="step">
            <div class="sort">
                <img class="pic" style="width:100%; height: 100%;" src="/public/static/icon/success.png" alt="">
            </div>
            <div class="desc">安装成功</div>
        </div>
    </div>
</div>
<div class="container">
    <div class="result">
        <div class="status-box" style="display:flex; align-items:center;justify-content:center">
            <img class="pic" style="width: 50px; height: 50px;" src="/public/static/icon/success.png" alt="">       
        </div>
         <h1 style="text-align:center">恭喜您,已成功安装悟空CRM</h1>
        <div class="desc" style="color:#acacac; font-weight: 600; margin-top: 50px; line-height:30px">
            <p>您已经成功安装开源PHP悟空CRM,您可以尽情享用悟空CRM开源版所有功能及服务.</p>
            <p>使用管理员账号即可登录</p>
        </div>
        <div class="control">
            <div class="btn primary login">立即登录</div>
        </div>
    </div>
</div>
<div class="footer-wrapper">
    <footer class="footer">
  <div class="content">
    悟空CRM受国家计算机软件著作权保护，未经授权不得进行商业行为，违者必究。<br>
    &copy;2021 悟空软件 <a target="_blank" style="color: #fff;" href="http://www.5kcrm.com">www.5kcrm.com</a>
  </div>
</footer>

</div>
</body>
<script>
    $('.login').click(function () {
        window.location = '../../../index.html'
    })
</script>
</html>