<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
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
            <a class="adminBannerOne" href="${ctx}/admin/adminUserManage" target="mainFrame" onclick="changeLiStyle('publicData')">
                <p class="bannerNumber">
                    <span>${userCount}</span>位 </p>
                <p class="dataType">学院用户</p>
            </a>
            <a class="adminBannerTwo" href="${ctx}/admin/adminLog" target="mainFrame" onclick="changeLiStyle('personData')">
                <p class="bannerNumber">
                <p class="bannerNumber">
                    <span>${logCount}</span>条 </p>
                <p class="dataType">系统日志</p>
            </a>
            <a class="adminBannerThree" href="javascript:void(0)" target="mainFrame" onclick="changeLiStyle('dataType')">
                <p class="bannerNumber">
                    <span>${dataClassCount}</span>条 </p>
                <p class="dataType">公共类目</p>
            </a>
            <a class="adminBannerFour" href="${ctx}/admin/adminNews" target="mainFrame" onclick="changeLiStyle('teacherNews')">
                <p class="bannerNumber">
                    <span>${newsCount}</span>条 </p>
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
            if($("#publicDataType", window.parent.document).css("display") == "none"){
                $("#iconDown",  window.parent.document).attr("class", "icon-angle-up iconDown");
                $("#publicDataType", window.parent.document).slideDown();
            }else{
                $("#iconDown",  window.parent.document).attr("class", "icon-angle-down iconDown");
                $("#publicDataType", window.parent.document).slideUp();
            }
        } else{
            $(".aside li", window.parent.document).siblings().children('a').removeClass("asideAddClass");
            $("#" + liId, window.parent.document).children('a').addClass('asideAddClass');

        }
    }
</script>
</body>
</html>
