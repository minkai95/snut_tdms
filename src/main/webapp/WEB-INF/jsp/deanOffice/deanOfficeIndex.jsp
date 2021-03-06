<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教务处首页</title>
    <link rel="icon" href="${ctx}/resources/images/facivon.ico" type="image/x-icon">
</head>
<body>
<div class="wrapper">
    <header class="header">
        <div class="headerLeft">高校资料管理系统</div>
        <div class="headerRight">
            <div class="welcome">你好，<a href="${ctx}/user/personCenter" target="mainFrame" id="username">${userInfo.name}</a> <a href="${ctx}/user/logout" class="loginOut"><i class="icon-signout"></i>注销</a></div>
        </div>
    </header>
    <div class="middle">
        <div class="leftContent">
            <ul class="aside">
                <li><a href="${ctx}/deanOffice/deanOfficeCurrent" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li id="publicData">
                    <a id="publicDataClass" class="asideAddClass_2" href="javascript:void(0)" target="mainFrame" style="position: relative"><i class="icon-folder-open"></i>公共资料<i class="icon-angle-down iconDown" id="iconDown"></i></a>
                    <div class="publicDataType" id="publicDataType">
                        <ul>
                            <li class="personLi"><a href="${ctx}/user/rolePublicData?roleId=004" target="mainFrame">教务处</a></li>
                            <li class="personLi"><a href="${ctx}/user/rolePublicData?roleId=005" target="mainFrame">教师</a></li>
                        </ul>
                    </div>
                </li>
                <li id="personData"><a href="${ctx}/user/personData" target="mainFrame"><i class="icon-briefcase"></i>私有资料</a></li>
                <li id="dataType"><a href="${ctx}/deanOffice/deanApplyDataClass" target="mainFrame"><i class="icon-plus-sign"></i>申请类目</a></li>
                <li id="teacherCenter"><a href="${ctx}/user/personCenter" target="mainFrame"><i class="icon-user"></i>个人中心</a></li>
                <li><a href="${ctx}/user/dataTrace" target="mainFrame"><i class="icon-screenshot"></i>资料追踪</a></li>
                <li id="teacherNews"><a href="${ctx}/deanOffice/deanOfficeNews" target="mainFrame"><i class="icon-bell-alt"></i>消息通告</a></li>
            </ul>
        </div>
        <div class="rightContent">
            <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="${ctx}/deanOffice/deanOfficeCurrent"></iframe>
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
            if($("#publicDataType").css("display") == "none"){
                $("#publicDataType").slideDown();
                $("#iconDown").attr("class","icon-angle-up iconDown");
            } else{
                $("#publicDataType").slideUp();
                $("#iconDown").attr("class","icon-angle-down iconDown");
            }
        });
        /*菜单关闭*/
        $("#publicDataClass").parent().siblings().children("a").click(function() {
            $("#iconDown").attr("class","icon-angle-down iconDown");
            $("#publicDataType").slideUp();
            $("#publicDataType ul li a").removeClass("asideAddClass")
        });
    });
</script>
</body>
</html>
