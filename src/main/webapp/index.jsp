<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>登录页面</title>
        <link rel="icon" href="${ctx}/resources/images/title.ico" type="image/x-icon">
    </head>
    <body>
        <h2>Hello World!</h2>

        <label for="username">用户名:</label>
        <input type="text" id="username" name="username"/>
        <label for="password">密码:</label>
        <input type="password" id="password" name="password"/>
        <input type="button" value="登录" id="login">

        <script>
            $("#login").on('click', function () {
                var username = $("#username").val();
                var password = $("#password").val();
                $.ajax({
                    type: "POST",
                    url: "${ctx}/user/login?username=" + username + "&password=" + password,
                    dataType: "json",
                    success: function (result) {
                        location.href ="${ctx}"+result['urlStr'];
                    }
                })
            })
        </script>
    </body>
</html>
