<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>运行首页</title>
</head>
<body>
<div class="adminCurrentWrapper">
    <p class="title">运行首页</p>
    <div calss="mainCont">
        <div class="banner">
            <a class="adminBannerOne" href="adminUserManage.jsp" target="mainFrame" onclick="changeLiStyle('publicData')">
                <p class="bannerNumber">
                    <span>15</span>位 </p>
                <p class="dataType">学院用户</p>
            </a>
            <a class="adminBannerTwo" href="adminLog.jsp" target="mainFrame" onclick="changeLiStyle('personData')">
                <p class="bannerNumber">
                <p class="bannerNumber">
                    <span>30</span>条 </p>
                <p class="dataType">系统日志</p>
            </a>
            <a class="adminBannerThree" href="javascript:void(0)" target="mainFrame" onclick="changeLiStyle('dataType')">
                <p class="bannerNumber">
                    <span>7</span>条 </p>
                <p class="dataType">公共类目</p>
            </a>
            <a class="adminBannerFour" href="adminNews.jsp" target="mainFrame" onclick="changeLiStyle('teacherNews')">
                <p class="bannerNumber">
                    <span>9</span>条 </p>
                <p class="dataType">消息通告</p>
            </a>
        </div>
        <div class="currentCont">
            <p class="welcomeTitle">欢迎使用高校资料管理系统</p>
            <p class="welcomeEnglish">Welcome Use SNUT_TDMS System</p>
        </div>
    </div>
</div>

<script>
    function changeLiStyle(liId) {
        if(liId == "dataType"){
            $("#publicDataType", window.parent.document).slideToggle();
        } else{
            $(".aside li", window.parent.document).siblings().children('a').removeClass("asideAddClass");
            $("#" + liId, window.parent.document).children('a').addClass('asideAddClass');

        }
    }
</script>
</body>
</html>
