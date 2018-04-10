<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教师首页</title>
</head>
<body>
<div class="wrapper">
    <header class="header">
        <div class="headerLeft">高校资料管理系统</div>
        <div class="headerRight">
            <div class="welcome">你好，<a href="personCenter.jsp" target="mainFrame" id="username">周杰伦</a></div>
        </div>
    </header>
    <div class="middle">
        <div class="leftContent">
            <ul class="aside">
                <li><a href="teacherCurrent.jsp" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li id="publicData"><a href="teacherPublicData.jsp" target="mainFrame"><i class="icon-folder-open"></i>公共资料</a></li>
                <li id="personData"><a href="teacherPersonData.jsp" target="mainFrame"><i class="icon-briefcase"></i>私有资料</a></li>
                <li id="dataType"><a href="applyAddDataClass.jsp" target="mainFrame"><i class="icon-plus-sign"></i>申请类目</a></li>
                <li id="teacherCenter"><a href="personCenter.jsp" target="mainFrame"><i class="icon-user"></i>个人中心</a></li>
                <li><a href="dataTrace.jsp" target="mainFrame"><i class="icon-screenshot"></i>资料追踪</a></li>
                <li id="teacherNews"><a href="teacherNews.jsp" target="mainFrame"><i class="icon-bell-alt"></i>消息通告</a></li>
            </ul>
        </div>
        <div class="rightContent">
            <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="teacherCurrent.jsp" scrolling="no"></iframe>
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
