<?php if (!defined('THINK_PATH')) exit(); /*a:3:{s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php/application/admin\view\install\step2.html";i:1672829736;s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php\application\admin\view\public\header.html";i:1672829736;s:80:"D:\phpstudy_pro\WWW\wukong.com\crm_php\application\admin\view\public\footer.html";i:1672829736;}*/ ?>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <title>悟空CRM安装向导</title>
        <link rel="shortcut icon" href="/public/static/icon/favicon.ico">
        <link rel="stylesheet" href="/public/static/style/base.css">
        <link rel="stylesheet" href="/public/static/style/step2.css">
        <link rel="stylesheet" href="/public/static/style/loading.css">
        <script src="/public/static/js/jquery-3.3.1.min.js"></script>
    </head>
    
    <body style="width: 100%; height: 100%;position: relative;">
        <div id="cover">
           <div id="loader-container">
            <p id="loadingText">creating...</p>
        </div> 
        </div>  
        
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
                <div class="step line"></div>
                <div class="step">
                    <div class="sort">
                        <img class="pic" style="width:100%; height: 100%;" src="/public/static/icon/success_gray.png" alt="">
                    </div>
                    <div class="desc">安装成功</div>
                </div>
            </div>
        </div>
        <div class="container">         
            <div class="content">
                <div class="base-top">
                    <span class="title">创建数据库</span>
                    <span class="version">当前版本：<?php echo $envir_data['version']['VERSION']; ?> <?php echo $envir_data['version']['RELEASE']; ?></span>
                </div>
                <div class="form">
                    <div class="form-sec-title">请填写数据库信息</div>
                    <div class="form-item">
                        <div class="form-label">数据库主机：</div>
                        <input type="text" class="wkform" name="databaseUrl" placeholder="127.0.0.1">
                        <!--<div class="error" style="display: none">数据库主机不能空</div>-->
                        <!-- <div class="remind">数据库地址一般为127.0.0.1</div> -->
                    </div>
                    <div class="form-item">
                        <div class="form-label">数据库名：</div>
                        <input type="text" class="wkform" name="databaseName">
                    </div>
                    <div class="form-item">
                        <div class="form-label">端口：</div>
                        <input type="text" class="wkform" name="databasePort" placeholder="一般为3306">
                        <!-- <div class="remind">一般为 3306</div> -->
                    </div>
                    <div class="form-item">
                        <div class="form-label">数据库用户名：</div>
                        <input type="text" class="wkform" name="databaseUser" placeholder="生产环境建议创建独立账号">
                        <!-- <div class="remind">生产环境建议创建独立账号</div> -->
                    </div>
                    <div class="form-item">
                        <div class="form-label">数据库密码：</div>
                        <input type="password" class="wkform" name="databasePwd">
                    </div>
                    <div class="form-item">
                        <div class="form-label">表前缀：</div>
                        <input type="text" class="wkform" name="databaseTable" placeholder="默认我5kcrm-" disabled>
                        <!-- <div class="remind">默认为5kcrm_</div> -->
                    </div>
                    <div class="form-item">
                        <div class="form-label">安装序列号：</div>
                        <textarea name="wkcode" class="wkform" rows="6" placeholder="请输入您的序列号"></textarea>
<!--                        <div class="remind">-->
<!--                            <span class="title">您需要通过手机号来<a class="base-a" target="_blank" href="https://www.72crm.com/login">注册悟空ID</a>，该手机号将作为您登录系统的管理员账号。您需要进入【悟空个人中心】，点击【开源版下载】<a class="base-a" target="_blank" href="https://www.72crm.com/login">获取您的序列号</a>，如您已经注册悟空ID，您只需要点击<a class="base-a" target="_blank" href="https://www.72crm.com/login">登录个人中心</a>即可查看您的序列号</span>-->
<!--                        </div>-->
                    </div>

                    <div class="form-sec-title">请填写管理员信息</div>
                    <p style="color:#d5d5d5;font-size: 12px;">
                        请填写以下管理员信息,是指完成且系统安装成功后,您可以使用管理员信息登录系统.
                    </p>
                    <div class="form-item">
                        <div class="form-label">管理员账号：</div>
                        <input type="text" class="wkform" name="root" placeholder="请输入您的手机号码">
                    </div>                     
                    <div class="form-item">
                        <div class="form-label">管理员密码：</div>
                        <input type="password" class="wkform" name="pwd" placeholder="6~20位字母加数字组合">
                    </div>
                    
                </div>
                <div class="base-des">
                </div>                
                <div class="install_progress_a">
                <!-- <progress class="install_progress" max="97" value="8"></progress> -->
                </div>
                <div class="control">
                    <div class="prev btn">上一步</div>
                    <div class="next btn primary">安装</div>
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
<!-- <script src="/public/static/js/base.js"></script> -->
<script src="/public/static/js/step2.js"></script> 
</html>