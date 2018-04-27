<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>首次登陆</title>
    <link rel="icon" href="${ctx}/resources/images/facivon.ico" type="image/x-icon">
</head>
<body>
    <div class="firstLoginWrapper">
        <input id="departmentCode" style="display: none" value="${sessionScope.get('userInfo').department.code}">
        <p class="firstLoginTitle">欢迎使用高校资料管理系统</p>
        <p class="secondTitle"><i class="icon-warning-sign"></i> 首次登录，请完善个人信息</p>
        <div class="firstLoginContent">
            <form id="firstLoginForm">
                <div class="form-group">
                    <label for="firstUsername" style="letter-spacing: 5px;">用户名:</label>
                    <span id="firstUsername" class="form-control firstUsername">${sessionScope.get('userInfo').user.username}</span>
                </div>
                <div class="form-group">
                    <label for="firstName" style="letter-spacing: 14px;">姓名:</label>
                    <input class="form-control" id="firstName" type="text" value="${sessionScope.get('userInfo').name}" placeholder="请输入姓名"
                           data-rule="required;firstName;"
                           data-rule-firstName="[/^([\u4e00-\u9fa5]){2,8}$/, '请输入2-8位汉字姓名']">
                </div>
                <div class="form-group">
                    <label for="firstSex" style="letter-spacing: 14px;">性别:</label>
                    <select id="firstSex" class="form-control">
                        <option value="男" <c:if test="${sessionScope.get('userInfo').sex =='男'}">selected</c:if>>男</option>
                        <option value="女" <c:if test="${sessionScope.get('userInfo').sex =='女'}">selected</c:if>>女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="firstUserJob" style="letter-spacing: 14px;">职务:</label>
                    <select id="firstUserJob" class="form-control">
                        <option value="005" <c:if test="${sessionScope.get('userRole').role.id=='005'}">selected</c:if>>教师</option>
                        <option value="004" <c:if test="${sessionScope.get('userRole').role.id=='004'}">selected</c:if>>教务处教师</option>
                        <option value="003" <c:if test="${sessionScope.get('userRole').role.id=='003'}">selected</c:if>>学办教师</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="firstIdCard">身份证号:</label>
                    <input class="form-control" id="firstIdCard" type="text" placeholder="请输入身份证号"
                           data-rule="required;firstIdCard;"
                           data-rule-firstIdCard="[/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X|x)$/,'请填写有效的身份证号']">
                </div>
                <div class="form-group">
                    <label for="firstPhone">联系方式:</label>
                    <input class="form-control" id="firstPhone" type="text" value="${sessionScope.get('userInfo').phone}" placeholder="请输入手机号"
                           data-rule="required;firstPhone;"
                           data-rule-firstPhone="[/^1\d{10}$/, '请输入11位手机号码']">
                </div>
                <div class="form-group">
                    <label for="firstEmail" class="forgetUserEmail" style="letter-spacing: 14px;">邮箱:</label>
                    <input class="form-control" id="firstEmail" type="text" value="${sessionScope.get('userInfo').email}" placeholder="请输入邮箱"
                           data-rule="required;firstEmail;"
                           data-rule-firstEmail="[/(^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+)|(^$)/, '请输入正确的邮箱地址']">
                </div>
                <div class="form-group">
                    <label for="firstUserPSW" class="forgetUserPSW">修改密码:</label>
                    <input class="form-control" id="firstUserPSW" type="text" placeholder="请输入新密码" name="firstUserPSW"
                           data-rule="新密码:firstUserPSW;"
                           data-rule-firstUserPSW="[/^[a-zA-Z0-9]{6,18}$/, '请填写6-18位密码']">
                </div>
                <div class="form-group">
                    <label for="firstUserPSWAgain" class="forgetUserEmail">再次输入:</label>
                    <input class="form-control" id="firstUserPSWAgain" type="text" placeholder="请再次输入" name="firstUserPSWAgain"
                           data-rule="确认密码: match[firstUserPSW];">
                </div>
                <div class="form-group btnCont">
                    <button class="btn btn-warning" type="reset">重置</button>
                    <button class="btn btn-success" type="submit">确定</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        $("#firstLoginForm").on('valid.form', function () {
            var username = $('#firstUsername').text();
            var name = $('#firstName').val();
            var sex = $('#firstSex').val();
            var roleId = $('#firstUserJob').val();
            var idCard = $('#firstIdCard').val();
            var phone = $('#firstPhone').val();
            var email = $('#firstEmail').val();
            var password = $('#firstUserPSW').val();
            var departmentCode = $('#departmentCode').val();
            var userInfo = {
                "user":{
                    "username":username,
                    "password":password,
                    "idCard":idCard,
                    "firstLogin":1
                },
                "name":name,
                "sex":sex,
                "phone":phone,
                "email":email,
                "department":{
                    "code":departmentCode,
                    "name":""
                }
            };
            $.ajax({
                url:"${ctx}/user/firstLoginUpdate?roleId="+roleId,
                type:"POST",
                data:JSON.stringify(userInfo),
                contentType:"application/json",
                dataType:"json",
                success: function (result) {
                    $.confirm({
                        title: '提示',
                        content: result['message'],
                        buttons: {
                            确定: function () {
                                location.href ="${ctx}"+result['urlStr'];
                            }
                        }
                    })
                }
            })
        });
    </script>
</body>
</html>
