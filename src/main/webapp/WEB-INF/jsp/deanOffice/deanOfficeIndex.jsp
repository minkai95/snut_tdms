<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>学办首页</title>
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
                <li><a href="deanOfficeCurrent.jsp" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li id="publicData">
                    <a id="publicDataClass" class="asideAddClass_2" href="javascript:void(0)" target="mainFrame"><i class="icon-folder-open"></i>公共资料</a>
                    <div class="publicDataType" id="publicDataType">
                        <ul>
                            <li><a href="deanOfficePublicData.jsp" target="mainFrame">教务处</a></li>
                            <li><a href="teachersPublicData.jsp" target="mainFrame">教师</a></li>
                        </ul>
                    </div>
                </li>
                <li id="personData"><a href="deanOfficePersonData.jsp" target="mainFrame"><i class="icon-briefcase"></i>私有资料</a></li>
                <li id="dataType"><a href="deanApplyDataClass.jsp" target="mainFrame"><i class="icon-plus-sign"></i>申请类目</a></li>
                <li id="teacherCenter"><a href="personCenter.jsp" target="mainFrame"><i class="icon-user"></i>个人中心</a></li>
                <li><a href="deanOfficeDataTrace.jsp" target="mainFrame"><i class="icon-screenshot"></i>资料追踪</a></li>
                <li id="teacherNews"><a href="deanOfficeNews.jsp" target="mainFrame"><i class="icon-bell-alt"></i>消息通告</a></li>
            </ul>
        </div>
        <div class="rightContent">
            <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="deanOfficeCurrent.jsp" scrolling="no"></iframe>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {

        /*侧边导航栏*/
        $(".aside li").click(function() {
            $(this).children("a").addClass("asideAddClass");
            $(this).siblings().children("a").removeClass("asideAddClass");
        });

        /*个人中心*/
        $("#username").click(function () {
            $(".aside li").siblings().children('a').removeClass("asideAddClass");
            $("#teacherCenter").children("a").addClass("asideAddClass");
        });

        /*菜单展开*/
        $("#publicDataClass").click(function() {
            $("#publicDataType").slideToggle();
        });
        /*菜单关闭*/
        $("#publicData").siblings().children("a").click(function() {
            $("#publicDataType").slideUp();
            $("#publicDataType ul li a").removeClass("asideAddClass")
        });
    })
</script>
</body>
</html>
