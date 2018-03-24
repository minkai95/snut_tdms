<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
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
            <div class="welcome">你好，周杰伦</div>
        </div>
    </header>
    <div class="middle">
        <div class="leftContent">
            <ul class="aside">
                <li><a href="teacherCurrent.jsp" target="mainFrame" class="asideAddClass"><i class="icon-home"></i>运行首页</a></li>
                <li><a href="teacherPublicData.jsp" target="mainFrame"><i class="icon-folder-open"></i>公共资料</a></li>
                <li><a href="teacherPersonData.jsp" target="mainFrame"><i class="icon-briefcase"></i>私有资料</a></li>
                <li><a href="applyAddDataClass.jsp" target="mainFrame"><i class="icon-plus-sign"></i>申请类目</a></li>
                <li><a href="#"><i class="icon-user"></i>个人中心</a></li>
                <li><a href="#"><i class="icon-screenshot"></i>资料追踪</a></li>
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
        })
    })
</script>
</body>
</html>
