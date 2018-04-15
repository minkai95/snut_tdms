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
            <a class="bannerOne" href="${ctx}/studentOffice/studentOfficePublicData" target="mainFrame" onclick="changeLiStyle('publicData')">
                <p class="bannerNumber">
                    <span>${publicDataCount}</span>份 </p>
                <p class="dataType">公共资料</p>
            </a>
            <a class="bannerTwo" href="${ctx}/studentOffice/studentOfficePersonData" target="mainFrame" onclick="changeLiStyle('personData')">
                <p class="bannerNumber">
                    <span>${personDataCount}</span>份 </p>
                <p class="dataType">私有资料</p>
            </a>
            <a class="bannerThree" href="${ctx}/studentOffice/applyAddDataClass" target="mainFrame" onclick="changeLiStyle('dataType')">
                <p class="bannerNumber">
                    <span>${dataClassCount}</span>份 </p>
                <p class="dataType">资料类目</p>
            </a>
            <a class="bannerFour" href="${ctx}/studentOffice/studentOfficeNews" target="mainFrame" onclick="changeLiStyle('teacherNews')">
                <p class="bannerNumber">
                    <span>${noticeCount}</span>条 </p>
                <p class="dataType">消息公告</p>
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
        $(".aside li", window.parent.document).siblings().children('a').removeClass("asideAddClass");
        $("#" + liId, window.parent.document).children('a').addClass('asideAddClass');
    }
</script>
</body>
</html>
