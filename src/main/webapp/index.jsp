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
    <button id="forgetPSW" type="button">找回密码</button>
    <script>
        $("#login").on('click', function () {
            var username = $("#username").val();
            var password = $("#password").val();
            $.ajax({
                type: "POST",
                url: "${ctx}/user/login?username=" + username + "&password=" + password,
                dataType: "json",
                success: function (result) {
                    if (result['message']!=null){
                        $.confirm({
                            title: '提示',
                            content: result['message'],
                            buttons: {
                                确定: function () {
                                    if (result['message']=='该用户不存在!'){
                                        location.reload();
                                    }else {
                                        $("#password").val("");
                                    }
                                }
                            }
                        })
                    }else {
                        location.href ="${ctx}"+result['urlStr'];
                    }
                }
            })
        });

        $('#forgetPSW').mousedown(function () {
            location.href ="${ctx}/user/forgetPSW?username="+$('#username').val();
        });

        //防止页面后退
        history.pushState(null, "", document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, "", document.URL);
        });
    </script>
</body>
</html>
