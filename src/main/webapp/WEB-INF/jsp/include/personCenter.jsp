<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心</title>
</head>
<body>
<div class="adminCurrentWrapper">
    <p class="publicDataTitle">个人中心</p>
    <div class="mainCont">
        <div class="personCenter">
            <div class="form-group formDiv">
                <label for="username" class="letterSpacingThree">用户名</label>
                <span  id="username" class="spanClass">${userInfo.user.username}</span>
            </div>
            <div class="form-group formDiv">
                <label for="name" class="letterSpacingTwo">姓名</label>
                <span  id="name" class="spanClass">${userInfo.name}</span>
            </div>
            <div class="form-group formDiv">
                <label for="department">所属院系</label>
                <span  id="department" class="spanClass">${userInfo.department.name}</span>
            </div>
            <div class="form-group formDiv">
                <label for="personId" class="letterSpacingThree">身份证</label>
                <span  id="personId" class="spanClass">${userInfo.user.idCard}</span>
            </div>
            <div class="form-group formDiv">
                <label for="phone" class="letterSpacingThree">手机号</label>
                <input type="text" class="form-control inputClass" id="phone" value="${userInfo.phone}">
            </div>
            <div class="form-group formDiv">
                <label for="email" class="letterSpacingTwo">邮箱</label>
                <input type="text" class="form-control inputClass" id="email" value="${userInfo.email}">
            </div>
            <div class="changePassword">
                <div class="form-group formDiv">
                    <label for="newPassword" class="letterSpacingThree">新密码</label>
                    <input type="password" class="form-control inputClass" id="newPassword" placeholder="若无需修改密码，请勿输入">
                </div>
                <div class="form-group formDiv">
                    <label for="confirmPassword">确认密码</label>
                    <input type="password" class="form-control inputClass" id="confirmPassword" placeholder="若无需修改密码，请勿输入">
                </div>
            </div>
            <div class="button-group">
                <button type="button" id="reset" class="btn btn-info">取消</button>
                <button type="button" id="submitUpdate" class="btn btn-success">修改</button>
            </div>
        </div>
    </div>
</div>

<script>
    $("#submitUpdate").on('click', function () {
        var username = $("#username").text();
        var phone = $("#phone").val();
        var email = $("#email").val();
        var newPassword = $("#newPassword").val();
        $.ajax({
            type: "POST",
            url: "${ctx}/user/updatePerson?username=" + username + "&phone=" + phone + "&email=" + email + "&newPassword=" + newPassword,
            dataType: "json",
            success: function (result) {
                $.confirm({
                    title: '提示',
                    content: result['message'],
                    buttons: {
                        确定: function () {
                            if (result['message']!="您未做任何修改!") {
                                location.reload();
                            }
                        }
                    }
                })
            }
        })
    });
    $("#reset").on('click',function () {
        location.href = "${ctx}/user/personCenter";
    })
</script>

</body>
</html>
