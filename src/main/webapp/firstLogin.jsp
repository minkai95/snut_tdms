<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>首次登陆</title>
</head>
<body>
    <div class="firstLoginWrapper">
        <p class="firstLoginTitle">欢迎使用高校资料管理系统</p>
        <p class="secondTitle"><i class="icon-warning-sign"></i> 首次登录，请完善个人信息</p>
        <div class="firstLoginContent">
            <form action="#" id="firstLoginForm">
                <div class="form-group">
                    <label for="firstUserId" style="letter-spacing: 5px;">用户名:</label>
                    <span id="firstUserId" class="form-control">teacher</span>
                </div>
                <div class="form-group">
                    <label for="firstUserName" style="letter-spacing: 14px;">姓名:</label>
                    <input class="form-control" id="firstUserName" type="text" placeholder="请输入姓名">
                </div>
                <div class="form-group">
                    <label for="firstUserJob" style="letter-spacing: 14px;">职务:</label>
                    <select id="firstUserJob" class="form-control">
                        <option value="教师">教师</option>
                        <option value="教务处教师">教务处教师</option>
                        <option value="学办教师">学办教师</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="firstUserIdCard">身份证号:</label>
                    <input class="form-control" id="firstUserIdCard" type="text" placeholder="请输入身份证号">
                </div>
                <div class="form-group">
                    <label for="firstUserPhone">联系方式:</label>
                    <input class="form-control" id="firstUserPhone" type="text" placeholder="请输入手机号">
                </div>
                <div class="form-group">
                    <label for="firstUserEmail" class="forgetUserEmail" style="letter-spacing: 14px;">邮箱:</label>
                    <input class="form-control" id="firstUserEmail" type="text" placeholder="请输入邮箱">
                </div>
                <div class="form-group">
                    <label for="firstUserPSW" class="forgetUserPSW">修改密码:</label>
                    <input class="form-control" id="firstUserPSW" type="text" placeholder="请输入新密码">
                </div>
                <div class="form-group">
                    <label for="firstUserPSWAgain" class="forgetUserEmail">再次输入:</label>
                    <input class="form-control" id="firstUserPSWAgain" type="text" placeholder="请再次输入">
                </div>
                <div class="form-group btnCont">
                    <button id="firstSubmitBtn" class="btn btn-success" type="submit">确定</button>
                    <button id="firstResetBtn" class="btn btn-warning" type="reset">重置</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
