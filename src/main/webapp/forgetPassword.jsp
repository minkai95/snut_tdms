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
                            <label for="forgetUserId" class="idLabel">账号:</label>
                            <input type="email" class="form-control" id="forgetUserId" placeholder="请输入账号"
                                   data-rule="required;">
                        </div>
                        <div class="form-group">
                            <label for="forgetIdCard">身份证号:</label>
                            <input type="email" class="form-control" id="forgetIdCard" placeholder="请输入身份证号" name="forgetIdCard"
                                   data-rule="required;forgetIdCard;"
                                   data-rule-forgetIdCard="[/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X|x)$/,'请填写有效的身份证号']">
                        </div>
                        <a href="index.jsp" class="btn btn-warning nextBtn" style="margin-left: 120px">返回登录</a>
                        <button class="btn btn-info nextBtn" id="nextBtn">下一步</button>
                    </form>
                </div>
                <div class="stepTwoCont">
                    <div class="form-group">
                        <label for="forgetPSWNew" class="newPSWLabel">新密码:</label>
                        <input type="email" class="form-control" id="forgetPSWNew" placeholder="请输入新密码">
                    </div>
                    <div class="form-group">
                        <label for="forgetPSWAgain">再次输入:</label>
                        <input type="email" class="form-control" id="forgetPSWAgain" placeholder="请再次输入">
                    </div>
                    <a href="index.jsp" class="btn btn-warning nextBtn" style="margin-left: 120px">返回登录</a>
                    <button id="submitBtn" class="btn btn-info nextBtn" type="submit">提交</button>
                </div>
                <div class="stepThreeCont">
                    <div class="laughCont">
                        <img src="${ctx}/resources/images/laugh.png" alt="找回密码成功！">
                    </div>
                    <p class="findPSWSuccess">找回密码成功！返回<a href="index.jsp">登录页面</a>....</p>
                </div>
            </div>
        </div>
    </div>
    <script>

/*        $("#forgetPSWFormOne").on('valid.form', function () {
            var forgetUserId = $("#forgetUserId").val();
            var forgetIdCard = $("#forgetIdCard").val();
            $.ajax({
                type: "PUT",
                url: "#" + forgetUserId + "&password=" + forgetIdCard,
                dataType: "json",
                success: function (result) {
                    if (result['message'] == "密码修改成功！") {
                        alert(result['message']);
                        window.location.href = "index.jsp";
                    } else {
                        alert(result['message']);
                    }
                }
            });
        });*/

        $("#nextBtn").click(function(){
            $(".forgetPSWHeader").css("background","url('../resources/images/secondNextBgi.png') no-repeat 266px 0,#e0e0e0");
            $("#stepOneSpan").removeClass("spanNextActive");
            $("#stepOneSpan").append("<i class='icon-ok-circle passIcon'></i>");
            $("#stepOneSpan").addClass("passStyle");
            $("#stepTwoSpan").addClass("spanNextActive");
            $(".stepOneCont").css("display","none");
            $(".stepTwoCont").css("display","block");
        });
        $("#submitBtn").click(function(){
            $("#stepTwoSpan").removeClass("spanNextActive");
            $("#stepTwoSpan").addClass("passStyle");
            $("#stepTwoSpan").append("<i class='icon-ok-circle passIcon'></i>");
            $("#stepThreeSpan").addClass("spanNextActive");
            $(".forgetPSWHeader").css("background","url('../resources/images/threeBgi.png') no-repeat 534px 0,#e0e0e0");
            $(".stepTwoCont").css("display","none");
            $(".stepThreeCont").css("display","block");

        });
    </script>
</body>
</html>
