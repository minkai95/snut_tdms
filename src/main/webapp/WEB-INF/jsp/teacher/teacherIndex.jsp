<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教师首页</title>
    <link rel="icon" href="${ctx}/resources/images/facivon.ico" type="image/x-icon">
</head>
<body>
<div class="wrapper">
    <header class="header">
        <div class="headerLeft">高校资料管理系统</div>
        <div class="headerRight">
            <div class="welcome">你好，<a href="${ctx}/user/personCenter" target="mainFrame" id="username">${userInfo.name}</a>  <a href="${ctx}/user/logout" class="loginOut"><i class="icon-signout"></i>注销</a></div>
        </div>
    </header>
    <div class="middle">
        <div class="leftContent">
            <ul class="aside">
                <li><a href="${ctx}/teacher/teacherCurrent" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li id="publicData"><a href="${ctx}/teacher/teacherPublicData" target="mainFrame"><i class="icon-folder-open"></i>公共资料</a></li>
                <li id="personData"><a href="${ctx}/user/personData" target="mainFrame"><i class="icon-briefcase"></i>私有资料</a></li>
                <li id="dataType"><a href="${ctx}/teacher/applyAddDataClass" target="mainFrame"><i class="icon-plus-sign"></i>申请类目</a></li>
                <li id="teacherCenter"><a href="${ctx}/user/personCenter" target="mainFrame"><i class="icon-user"></i>个人中心</a></li>
                <li><a href="${ctx}/user/dataTrace" target="mainFrame"><i class="icon-screenshot"></i>资料追踪</a></li>
                <li id="teacherNews"><a href="${ctx}/teacher/teacherNews" target="mainFrame"><i class="icon-bell-alt"></i>消息公告</a></li>
            </ul>
        </div>
        <div class="rightContent">
            <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="${ctx}/teacher/teacherCurrent"></iframe>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {

        /*侧边导航栏*/
        $(".aside li").click(function() {
            $(this).children('a').addClass("asideAddClass");
            $(this).siblings().children('a').removeClass("asideAddClass");
        });

        /*个人中心*/
        $("#username").click(function () {
            $(".aside li").siblings().children('a').removeClass("asideAddClass");
            $("#teacherCenter").children('a').addClass("asideAddClass");
        });

    })
</script>
</body>
</html>
