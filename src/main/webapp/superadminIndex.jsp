<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>超级管理员首页</title>
</head>
<body>
<div class="wrapper">
    <header class="header">
        <div class="headerLeft">高校资料管理系统</div>
        <div class="headerRight">
            <div class="welcome">你好，superAdmin</div>
        </div>
    </header>
    <div class="middle">
        <div class="leftContent">
            <ul class="aside">
                <li><a href="superadminCurrent.jsp" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li><a href="departmentManage.jsp" target="mainFrame"><i class="icon-sitemap"></i>院系管理</a></li>
                <li><a href="departmentAdminManage.jsp" target="mainFrame"><i class="icon-group"></i>管理员管理</a></li>
                <li><a href="log.jsp" target="mainFrame"><i class="icon-bar-chart"></i>全校日志</a></li>
            </ul>
        </div>
        <div class="rightContent">
            <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="superadminCurrent.jsp" scrolling="no"></iframe>
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
