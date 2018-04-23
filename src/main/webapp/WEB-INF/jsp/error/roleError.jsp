<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录超时</title>
    <link rel="icon" href="${ctx}/resources/images/title.ico" type="image/x-icon">
</head>
<body>
<div class="roleErrorWrapper">
    <p class="roleErrorInfo">抱歉，由于你没有该访问权限，<span id="count">3</span>秒后将为您跳转至<a href="../../../index.jsp">登录页面</a>....</p>
</div>
<script type="text/javascript">
    var i = 2;
    var timer;
    timer = setInterval("fun()", 1000);
    function fun() {
        if (i == 0) {
            top.location.href = "../../../index.jsp";
            clearInterval(timer);
        }
        $('#count').text(i);
        i--;
    }
</script>
</body>
</html>
