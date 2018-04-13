<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理员管理</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">院系管理员管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">院系管理员列表</p>
                    <a href="#" class="upload" onclick="openAddAdminModal()"><i class="icon-plus-sign"></i>新增管理员</a>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>所属院系</th>
                        <th>联系方式</th>
                        <th>E-mail</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${adminUserInfoList}" var="userInfo" varStatus="userInfoStatus">
                        <tr id="${userInfo.user.username}">
                            <td>${userInfoStatus.index+1}</td>
                            <td>${userInfo.user.username}</td>
                            <td>${userInfo.name}</td>
                            <td>${userInfo.sex}</td>
                            <td>${userInfo.department.name}</td>
                            <td>${userInfo.phone}</td>
                            <td>${userInfo.email}</td>
                            <td style="width: 250px;  text-align: center;">
                                <button class="btn btn-primary btn-sm" onclick="openUpdateAdminModal('${userInfo.user.username}')"><i class="icon-pencil"></i>修改</button>
                                <button onclick="deleteAdmin('${userInfo.user.username}')" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                            </td>
                            <td style="display: none">${userInfo.department.code}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- 新增管理员Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增管理员</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addUsername" style="letter-spacing: 8px;">用户名:</label>
                        <input type="text" id="addUsername" class="form-control applyDataName" name="departmentAdminId">
                    </div>
                    <div class="form-group">
                        <label for="addName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="addName" class="form-control applyDataName" name="departmentName">
                    </div>
                    <div class="form-group">
                        <label for="addSex" style="letter-spacing: 19px;">性别:</label>
                        <select name="departmentAdminSex" id="addSex" class="form-control applyDataName">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="departmentLocation" style="letter-spacing: 2.5px;">所属院系:</label>
                        <select name="departmentLocation" id="departmentLocation" class="form-control applyDataName"></select>
                    </div>
                    <div class="form-group">
                        <label for="addPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="addPhone" class="form-control applyDataName" name="departmentAdminPhone">
                    </div>
                    <div class="form-group">
                        <label for="addEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="addEmail" class="form-control applyDataName" name="departmentAdminEmail">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button onclick="addAdminSubmit()" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改管路员信息Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改管理员信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="updateUsername" style="letter-spacing: 8px;">用户名:</label>
                        <span id="updateUsername" class="form-control applyDataName"></span>
                    </div>
                    <div class="form-group">
                        <label for="updateName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="updateName" class="form-control applyDataName" value="">
                    </div>
                    <div class="form-group">
                        <label for="updateSex" style="letter-spacing: 19px;">性别:</label>
                        <select id="updateSex" class="form-control applyDataName">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentLocation" style="letter-spacing: 2.5px;">所属院系:</label>
                        <select id="amendDepartmentLocation" class="form-control applyDataName"></select>
                    </div>
                    <div class="form-group">
                        <label for="updatePhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="updatePhone" class="form-control applyDataName" value="12345678901">
                    </div>
                    <div class="form-group">
                        <label for="updateEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="updateEmail" class="form-control applyDataName" value="123456@163.com">
                    </div>
                    <div class="form-group">
                        <label for="resetPassword" style="letter-spacing: 2.5px;">重置密码:</label>
                        <div class="switchBtnWrapper switchBtnMove" id="resetPassword">
                            <div class="switchBtnLeft cont"></div>
                            <div class="switchBtnMiddle cont">否</div>
                            <div class="switchBtnRight cont"></div>
                            <div class="switchBtn" id="btn"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" onclick="updateAdminSubmit()" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        function addAdminSubmit() {
            var username = $('#addUsername').val();
            var name = $('#addName').val();
            var sex = $('#addSex').val();
            var departmentCode = $('#departmentLocation').val();
            var phone = $('#addPhone').val();
            var email = $('#addEmail').val();
            var userInfo = {
                "user":{
                    "username":username,
                    "password":"",
                    "idCard":"",
                    "firstLogin":0
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
                url:"${ctx}/superAdmin/addAdmin",
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
                                location.reload();
                            }
                        }
                    })
                }
            })
        }

        // 打开新增管理员的模态框
        function openAddAdminModal() {
            $.ajax({
                type: "GET",
                url: "${ctx}/superAdmin/getAllDepartment",
                dataType: "json",
                success: function (result) {
                    if(result['departmentList'].length>0){
                        var departmentLocation = $("#departmentLocation");
                        departmentLocation.html("");
                        for (var i = 0; i < result['departmentList'].length; i++) {
                            departmentLocation.append("<option id='" + result['departmentList'][i]['code'] + "' value='" + result['departmentList'][i]['code'] + "' >" + result['departmentList'][i]['name'] + "</option >");
                        }
                    }
                    $('#myModal').modal();
                }
            })
        }

        // 打开修改管理员的模态框
        function openUpdateAdminModal(username) {
            var tr = $('#'+username+'');
            $('#updateUsername').text(tr.children('td').eq(1).text());
            $('#updateName').val(tr.children('td').eq(2).text());
            $('#updateSex').val(tr.children('td').eq(3).text()).attr('selected',true);
            $('#updatePhone').val(tr.children('td').eq(5).text());
            $('#updateEmail').val(tr.children('td').eq(6).text());
            $.ajax({
                type: "GET",
                url: "${ctx}/superAdmin/getAllDepartment",
                dataType: "json",
                success: function (result) {
                    if(result['departmentList'].length>0){
                        var amendDepartmentLocation = $("#amendDepartmentLocation");
                        amendDepartmentLocation.html("");
                        for (var i = 0; i < result['departmentList'].length; i++) {
                            if (result['departmentList'][i]['code'] == tr.children('td').eq(8).text()){
                                amendDepartmentLocation.append("<option selected='selected' id='" + result['departmentList'][i]['code'] + "' value='" + result['departmentList'][i]['code'] + "' >" + result['departmentList'][i]['name'] + "</option >");
                            }else {
                                amendDepartmentLocation.append("<option id='" + result['departmentList'][i]['code'] + "' value='" + result['departmentList'][i]['code'] + "' >" + result['departmentList'][i]['name'] + "</option >");
                            }
                        }
                    }
                }
            });
            $("#myModal2").modal();
        }

        //按钮js
        var btnResult = 0;
        $("#btn").mousedown(function() {
            if($('#btn').css("left") === "0px"){
                $("#btn").animate({left:'60px'},"2000");
                $(".cont").addClass("addStyle");
                $(".switchBtnMiddle").text("是");
                btnResult = 1;
            }else{
                $("#btn").animate({left:'0'},"2000");
                $(".switchBtnWrapper div").removeClass("addStyle");
                $(".switchBtnMiddle").text("否");
                btnResult = 0;
            }
        });

        function deleteAdmin(username) {
            $.confirm({
                title: '提示',
                content: '确认删除该管理员？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                buttons: {
                    确定: function(){
                        var description = $('#deleteReason').val();
                        $.ajax({
                            type: "DELETE",
                            url: "${ctx}/superAdmin/deleteAdmin?username="+username+"&description="+description,
                            dataType: "json",
                            success: function (result) {
                                $.confirm({
                                    title: '提示',
                                    content: result['message'],
                                    buttons: {
                                        确定: function () {
                                            location.reload();
                                        }
                                    }
                                })
                            }
                        })
                    },
                    取消: function() {
                    }
                }
            })
        }

        function updateAdminSubmit() {
            var username = $('#updateUsername').text();
            var name = $('#updateName').val();
            var sex = $('#updateSex').val();
            var departmentCode = $('#amendDepartmentLocation').val();
            var phone = $('#updatePhone').val();
            var email = $('#updateEmail').val();
            var userInfo = {
                "user":{
                    "username":username,
                    "password":"",
                    "idCard":"",
                    "firstLogin":0
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
                url:"${ctx}/superAdmin/updateAdmin?reset="+btnResult,
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
                                location.reload();
                            }
                        }
                    })
                }
            })
        }
    </script>
</body>
</html>
