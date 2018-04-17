<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理员首页</title>
</head>
<body>
    <div class="wrapper">
        <header class="header">
            <div class="headerLeft">高校资料管理系统</div>
            <div class="headerRight">
                <div class="welcome">你好，<a href="#" target="mainFrame" id="username">周杰伦</a></div>
            </div>
        </header>
        <div class="middle">
            <div class="leftContent">
                <ul class="aside">
                    <li class="publicLi"><a href="adminCurrent.jsp" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                    <li id="publicData" class="publicLi"><a href="adminUserManage.jsp" target="mainFrame"><i class="icon-group"></i>用户管理</a></li>
                    <li id="personData" class="publicLi"><a href="adminLog.jsp" target="mainFrame"><i class="icon-tasks"></i>学院日志</a></li>
                    <li id="dataType">
                        <a id="typeManage" class="asideAddClass_2" href="javascript:void(0)" target="mainFrame"><i class="icon-list-ul"></i>类目管理</a>
                        <div class="publicDataType" id="publicDataType">
                            <ul>
                                <li class="personLi"><a href="typeManageDeanOffice.jsp" target="mainFrame">教务处</a></li>
                                <li class="personLi"><a href="typeManageTeacher.jsp" target="mainFrame">教师</a></li>
                                <li class="personLi"><a href="typeManageStudentOffice.jsp" target="mainFrame">学办</a></li>
                                <li class="personLi"><a href="typeProperty.jsp" target="mainFrame">类目属性</a></li>
                            </ul>
                        </div>

                    </li>
                    <li id="teacherCenter" class="publicLi"><a href="#" target="mainFrame"><i class="icon-user"></i>个人中心</a></li>
                    <li id="teacherNews" class="publicLi"><a href="adminNews.jsp" target="mainFrame"><i class="icon-bell-alt"></i>消息通告</a></li>
                    <li class="publicLi"><a href="adminDataCopy.jsp" target="mainFrame"><i class=" icon-tag"></i>数据备份</a></li>
                </ul>
            </div>
            <div class="rightContent">
                <iframe id="mainFrame" class="mainFrame" name="mainFrame" src="adminCurrent.jsp"></iframe>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {

            /*侧边导航栏*/
            $(".publicLi").click(function() {
                $(this).children('a').addClass("asideAddClass");
                $(this).siblings().children('a').removeClass("asideAddClass");
                $(".personLi").children('a').removeClass("asideAddClass");
                $("#publicDataType").slideUp();
            });

            /*个人中心*/
            $("#username").click(function () {
                $(".aside li").siblings().children('a').removeClass("asideAddClass");
                $("#teacherCenter").children('a').addClass("asideAddClass");
            });

            /*菜单展开*/
            $("#typeManage").click(function() {
                $("#publicDataType").slideToggle();
            });
            /*菜单关闭*/
            $("#typeManage").siblings().children("a").click(function() {
                $("#publicDataType").slideUp();
                $("#publicDataType ul li a").removeClass("asideAddClass")
            });

            $(".personLi").click(function() {
                $(".aside li").siblings().children('a').removeClass("asideAddClass");
                $(this).children("a").addClass("asideAddClass");
            });

        })
    </script>
</body>
</html>
