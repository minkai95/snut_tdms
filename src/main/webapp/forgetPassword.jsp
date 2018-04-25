<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>忘记密码</title>
    <link rel="icon" href="${ctx}/resources/images/title.ico" type="image/x-icon">
    <style>
        .n-error{top: 4px;left: -152px;}
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="forgetPSWWrapper">
            <p class="forgetPSWTitle">找回密码</p>
            <div class="forgetPSWHeader">
                <span id="stepOneSpan" class="spanNextActive">验证身份</span>
                <span id="stepTwoSpan">重置密码</span>
                <span id="stepThreeSpan">找回密码成功</span>
            </div>
            <div class="forgetPSWCont">
                <div class="stepOneCont">
                    <form id="forgetPSWFormOne" data-validator-option="{timely:2, focusCleanup:true}">
                        <div class="form-group">
                            <label for="username" class="idLabel">账号:</label>
                            <input type="text" class="form-control" id="username" value="${username}" placeholder="请输入账号"
                                   data-rule="required;">
                        </div>
                        <div class="form-group">
                            <label for="idCard">身份证号:</label>
                            <input type="text" class="form-control" id="idCard" placeholder="请输入身份证号" name="forgetIdCard"
                                   data-rule="required;forgetIdCard;"
                                   data-rule-forgetIdCard="[/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X|x)$/,'请填写有效的身份证号']">
                        </div>
                        <a href="${ctx}/index.jsp" class="btn btn-warning nextBtn" style="margin-left: 120px">返回登录</a>
                        <button type="submit" id="nextBtn"  class="btn btn-info nextBtn">下一步</button>
                    </form>
                </div>
                <div class="stepTwoCont">
                    <form id="forgetPSWFormTwo" data-validator-option="{timely:2, focusCleanup:true}">
                        <div class="form-group">
                            <label for="forgetPSWNew" class="newPSWLabel">新密码:</label>
                            <input type="password" class="form-control" id="forgetPSWNew" name="forgetPSWNew" placeholder="请输入新密码"
                                   data-rule="新密码:forgetPSWNew;"
                                   data-rule-forgetPSWNew="[/^[a-zA-Z0-9]{6,18}$/, '请填写6-18位密码']">
                        </div>
                        <div class="form-group">
                            <label for="forgetPSWAgain">再次输入:</label>
                            <input type="password" class="form-control" id="forgetPSWAgain" name="forgetPSWAgain" placeholder="请再次输入"
                                   data-rule="确认密码: match[forgetPSWNew];">
                        </div>
                        <a href="${ctx}/index.jsp" class="btn btn-warning nextBtn" style="margin-left: 120px">返回登录</a>
                        <button type="submit" class="btn btn-info nextBtn">提交</button>
                    </form>
                </div>
                <div class="stepThreeCont">
                    <div class="laughCont">
                        <img src="${ctx}/resources/images/laugh.png" alt="找回密码成功！">
                    </div>
                    <p class="findPSWSuccess">找回密码成功！<span id="second">3</span>秒后返回<a href="${ctx}/index.jsp">登录页面</a>....</p>
                </div>
            </div>
        </div>
    </div>
    <script>
        $("#forgetPSWFormOne").on('valid.form', function () {
            $.ajax({
                type: "GET",
                url: "${ctx}/user/forgetPSWNext?username=" + $('#username').val() + "&idCard=" + $('#idCard').val(),
                dataType: "json",
                success: function (result) {
                    if (result['message']=='验证通过!'){
                        $(".forgetPSWHeader").css("background","url('../resources/images/secondNextBgi.png') no-repeat 266px 0,#e0e0e0");
                        $("#stepOneSpan").removeClass("spanNextActive");
                        $('#stepOneSpan').text("身份验证通过");
                        $("#stepOneSpan").append("<i class='icon-ok-circle passIcon'></i>");
                        $("#stepOneSpan").addClass("passStyle");
                        $("#stepTwoSpan").addClass("spanNextActive");
                        $(".stepOneCont").css("display","none");
                        $(".stepTwoCont").css("display","block");
                    }else {
                        $.confirm({
                            title: '提示',
                            content: result['message'],
                            buttons: {
                                确定: function () {
                                    $('#idCard').val("");
                                }
                            }
                        })
                    }
                }
            })
        });
        $("#forgetPSWFormTwo").on('valid.form', function () {
            $.ajax({
                type: "POST",
                url: "${ctx}/user/submitForgetPSW?username=" + $('#username').val() + "&password=" + $('#forgetPSWNew').val(),
                dataType: "json",
                success: function (result) {
                    if (result['message']=='更新成功!'){
                        $("#stepTwoSpan").removeClass("spanNextActive");
                        $("#stepTwoSpan").addClass("passStyle");
                        $('#stepTwoSpan').text("密码重置成功");
                        $("#stepTwoSpan").append("<i class='icon-ok-circle passIcon'></i>");
                        $("#stepThreeSpan").addClass("spanNextActive");
                        $(".forgetPSWHeader").css("background","url('../resources/images/threeBgi.png') no-repeat 534px 0,#e0e0e0");
                        $(".stepTwoCont").css("display","none");
                        $(".stepThreeCont").css("display","block");
                        var i = 2;
                        var timer = setInterval(function fun(){
                            if (i == 0) {
                                location.href="${ctx}/index.jsp";
                                clearInterval(timer);
                            }
                            $('#second').text(i);
                            i--;
                        },1000);
                    }else {
                        $.confirm({
                            title: '提示',
                            content: result['message'],
                            buttons: {
                                确定: function () {
                                    if (result['message']=='新密码与旧密码重复!'){
                                        $('#forgetPSWNew').val("");
                                        $('#forgetPSWAgain').val("");
                                    }else {
                                        location.reload();
                                    }
                                }
                            }
                        })
                    }
                }
            })
        });
        //防止页面后退
        history.pushState(null, "", document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, "", document.URL);
        });
    </script>
</body>
</html>
