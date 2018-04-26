<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>登录页面</title>
        <link rel="icon" href="${ctx}/resources/images/title.ico" type="image/x-icon">
        <style>
            .n-error{top: 6px; left: -105px;}
        </style>
    </head>
    <body>
        <div class="indexWrapper">
            <div class="indexContWrapper">
                <div class="indexTitle"></div>
                <div class="indexCont">
                    <p class="loginTitle">登录</p>
                    <div class="loginFormWrapper">
                        <form id="loginForm">
                            <i class="icon-user iconUser"></i>
                            <input id="username" class="form-control username" type="text" name="username" placeholder="用户名">
                            <i class="icon-lock iconPassword"></i>
                            <input id="password" class="form-control password" type="password" name="password" placeholder="密码">
                            <input id="verificationCode" class="form-control verificationCode" type="text" name="verificationCode" placeholder="验证码">
                            <div id="verificationCodeCont" class="verificationCodeCont"></div>
                            <div class="rememberPassword">
                                <div class="smallSwitchBtnWrapper" id="resetPassword">
                                    <div class="switchBtnLeft cont" onmousedown="btnMove()"></div>
                                    <div class="switchBtnMiddle cont" onmousedown="btnMove()"></div>
                                    <div class="switchBtnRight cont" onmousedown="btnMove()"></div>
                                    <div class="smallSwitchBtn" id="btn" onmousedown="btnMove()"></div>
                                </div>
                                <p class="rememberTittle">记住密码</p>
                                <a class="forgetLink" href="${ctx}/forgetPassword.jsp"><i class="icon-question-sign" style="margin-right: 5px;"></i>忘记密码</a>
                            </div>
                            <button class="btn btn-success loginBtn" type="submit">登录</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // 按钮js
            var btnResult = 0;
            function btnMove() {
                if ($("#btn").css("left") === "0px") {
                    $("#btn").animate({left: '22px'}, "fast");
                    $(".cont").addClass("addStyle2");
                    btnResult = 1;
                } else {
                    $("#btn").animate({left: '0'}, "fast");
                    $(".smallSwitchBtnWrapper div").removeClass("addStyle2");
                    btnResult = 0;
                }
            }
            //提交验证
            $(function(){
                var verifyCode = new GVerify("verificationCodeCont");
                /*$.validator.setTheme('bootstrap', {
                    validClass: 'has-success',
                    invalidClass: 'has-error',
                    bindClassTo: '.form-group',
                    formClass: 'n-default n-bootstrap',
                    msgClass: 'n-right'
                });*/
                $("#loginForm").validator({
                   /* theme: 'bootstrap',
                    timely: '2',*/
                    fields: {
                        username: {
                            rule: "required;",
                            msg: {
                                required: "请输入用户名"
                            }
                        },
                        password: {
                            rule: "required",
                            msg: {
                                required: "请输入密码"
                            }
                        }
                    },
                    beforeSubmit: function () {
                        var checkCode = $("#verificationCode");
                        if (!verifyCode.validate(checkCode.val())) {
                            /*checkCode.parent().addClass("has-error");*/
                            checkCode.trigger("showmsg", ["error", "验证码错误"]);
                            return false;
                        } else {
                            return true;
                        }
                    },
                    valid: function () {
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
                }
             });

                $('#forgetPSW').mousedown(function () {
                    location.href ="${ctx}/user/forgetPSW?username="+$('#username').val();
                });

                //防止页面后退
                history.pushState(null, "", document.URL);
                window.addEventListener('popstate', function () {
                    history.pushState(null, "", document.URL);
                });
            });
    </script>
</body>
</html>
