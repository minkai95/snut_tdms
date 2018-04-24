<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理员管理</title>
    <style>
        .n-error{top: 5px !important;left: -150px !important;  }
    </style>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">院系管理员管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">院系管理员列表</p>
                    <button id="openModel" class="btn btn-success upload batchDelete" onclick="openAddAdminModal()"><i class="icon-upload" style="margin-right: 5px;"></i>新增管理员</button>
                    <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <form id="pageForm" action="${ctx}/superAdmin/departmentAdminManage" method="get">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="text-align: center; width: 5%;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
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
                                <td style="text-align: center; width: 5%;"><input class="checkBtn checkedBtn" type="checkbox">${userInfoStatus.index+1}</td>
                                <td>${userInfo.user.username}</td>
                                <td>${userInfo.name}</td>
                                <td>${userInfo.sex}</td>
                                <td>${userInfo.department.name}</td>
                                <td>${userInfo.phone}</td>
                                <td>${userInfo.email}</td>
                                <td style="width: 250px;  text-align: center;">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="openUpdateAdminModal('${userInfo.user.username}')"><i class="icon-pencil"></i>修改</button>
                                    <button type="button" onclick="deleteAdmin('${userInfo.user.username}')" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                                </td>
                                <td style="display: none">${userInfo.department.code}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
                </form>
            </div>
        </div>
    </div>

    <!-- 新增管理员Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="addAdminForm">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">新增管理员</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="addUsername" style="letter-spacing: 8px;">用户名:</label>
                            <input type="text" id="addUsername" class="form-control applyDataName" name="departmentAdminId"
                                   data-rule="required;departmentAdminId;"
                                   data-rule-departmentAdminId="[/^[A-Za-z0-9]{6,18}$/, '请输入6-18数字或字母']">
                        </div>
                        <div class="form-group">
                            <label for="addName" style="letter-spacing: 19px;">姓名:</label>
                            <input type="text" id="addName" class="form-control applyDataName" name="departmentName"
                                   data-rule="departmentName;"
                                   data-rule-departmentName="[/^([\u4e00-\u9fa5]){2,8}$/, '请输入4-8位汉字姓名']">
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
                            <input type="text" id="addPhone" class="form-control applyDataName" name="departmentAdminPhone"
                                   data-rule="departmentAdminPhone;"
                                   data-rule-departmentAdminPhone="[/^1\d{10}$/, '请输入11位手机号码']">
                        </div>
                        <div class="form-group">
                            <label for="addEmail" style="letter-spacing: 19px;">邮箱:</label>
                            <input type="text" id="addEmail" class="form-control applyDataName" name="departmentAdminEmail"
                                   data-rule="departmentAdminEmail;"
                                   data-rule-departmentAdminEmail="[/(^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+)|(^$)/, '请输入正确的邮箱地址']">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 修改管路员信息Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="editAdminInfoForm">
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
                            <input type="text" id="updateName" class="form-control applyDataName" name="updateName" value=""
                                   data-rule="updateName;"
                                   data-rule-updateName="[/^([\u4e00-\u9fa5]){2,8}$/, '请输入4-8位汉字姓名']">
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
                            <input type="text" id="updatePhone" class="form-control applyDataName" value="12345678901" name="updatePhone"
                                   data-rule="departmentAdminPhone;"
                                   data-rule-departmentAdminPhone="[/^1\d{10}$/, '请输入11位手机号码']">
                        </div>
                        <div class="form-group">
                            <label for="updateEmail" style="letter-spacing: 19px;">邮箱:</label>
                            <input type="text" id="updateEmail" class="form-control applyDataName" value="123456@163.com" name="updateEmail"
                                   data-rule="departmentAdminEmail;"
                                   data-rule-departmentAdminEmail="[/(^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+)|(^$)/, '请输入正确的邮箱地址']">
                        </div>
                        <div class="form-group">
                            <label for="resetPassword" style="letter-spacing: 2.5px;">重置密码:</label>
                            <div class="switchBtnWrapper switchBtnMove" id="resetPassword">
                                <div class="switchBtnLeft cont" onmousedown="btnMove()"></div>
                                <div class="switchBtnMiddle cont" onmousedown="btnMove()"></div>
                                <div class="switchBtnRight cont" onmousedown="btnMove()"></div>
                                <div class="switchBtn" id="btn" onmousedown="btnMove()"></div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit"  class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>

        $("#addAdminForm").on('valid.form', function () {
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
        });

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
        function btnMove() {
            if ($("#btn").css("left") === "0px") {
                $("#btn").animate({left: '29px'}, "fast");
                $(".cont").addClass("addStyle");
                btnResult = 1;
            } else {
                $("#btn").animate({left: '0'}, "fast");
                $(".switchBtnWrapper div").removeClass("addStyle");
                btnResult = 0;
            }
        }

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

        $("#editAdminInfoForm").on('valid.form', function () {
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
        });

        /* --全选JS-- */
        $("#allCheckBtn").click(function() {
            if($(this).is(':checked') == true){
                $("#allCheckBtn").attr("checked",true);
                $('.checkedBtn').each(function() {
                    this.checked = true;
                });
            } else{
                $("#allCheckBtn").attr("checked",false);
                $('.checkedBtn').each(function() {
                    this.checked = false;
                });
            }
        });

        $(".checkedBtn").click(function(){
            $(this).each(function() {
                var allCheckedBox = $(".checkedBtn").length;
                var CheckedBox = $(".checkedBtn:checked").length;
                if(allCheckedBox == CheckedBox){
                    $("#allCheckBtn").prop("checked",true);
                } else{
                    $("#allCheckBtn").prop("checked",false);
                }
            });
        });

        /*批量删除*/
        $("#batchDelete").click(function(){
            var checkedTrId = [];
            $(".checkedBtn:checked").each(function(){
                checkedTrId.push($(this).parents("tr").attr("id"));
            });
            console.log(checkedTrId);
        });
    </script>
</body>
</html>
