<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>忘记密码</title>
    <style>
        .n-error{
            top: 4px;
            left: -152px;
        }
    </style>
</head>
<body>
        <div class="forgetPSWWrapper">
            <p class="forgetPSWTitle">找回密码</p>
            <div class="forgetPSWHeader">
                <div class="stepOne">
                    <span id="stepOneSpan" class="active"><i class=" icon-ok-circle" style="font-size: 18px; margin-right: 5px;"></i>第一步</span>
                </div>
                <div class="stepOne">
                    <span id="stepTwoSpan"><i class=" icon-ok-circle" style="font-size: 18px; margin-right: 5px;"></i>第二步</span>
                </div>
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
                    <button class="btn btn-info nextBtn" type="submit">提交</button>
                </div>
            </div>
        </div>

    <script>

        $("#forgetPSWFormOne").on('valid.form', function () {
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
        });

        $("#nextBtn").click(function(){
            $("#stepOneSpan").removeClass("active");
            $("#stepOneSpan").addClass("rightStyle");
            $(".stepOneCont").css("display","none");
            $(".stepTwoCont").css("display","block");
            $("#stepTwoSpan").addClass("active");
        });
    </script>
</body>
</html>
