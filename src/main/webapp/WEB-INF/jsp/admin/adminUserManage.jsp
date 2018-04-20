<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">用户管理</p>
            <div class="teacherUpload">
                <p class="uploadTitle">学院用户资料列表</p>
                <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
                <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-upload" style="margin-right: 5px;"></i>新增用户</button>
            </div>
        </div>
        <div class="teacherPublicDataList">
            <form id="pageForm" action="${ctx}/admin/adminUserManage" method="get">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th style="text-align: center"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>职务</th>
                        <th>联系方式</th>
                        <th>邮箱</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${userHelpClassList}" var="userHelp" varStatus="userStatus">
                        <tr id="${userHelp.userInfo.user.username}">
                            <td style="text-align: center"><input class="checkBtn checkedBtn" type="checkbox">1</td>
                            <td>${userHelp.userInfo.user.username}</td>
                            <td>${userHelp.userInfo.name}</td>
                            <td>${userHelp.userInfo.sex}</td>
                            <td>${userHelp.userRole.role.name}</td>
                            <td>${userHelp.userInfo.phone}</td>
                            <td>${userHelp.userInfo.email}</td>
                            <td style="width: 250px;  text-align: center;">
                                <button type="button" class="btn btn-info btn-sm" onclick="openUpdateUserModal('${userHelp.userInfo.user.username}')"><i class="icon-pencil"></i>修改</button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteUser('${userHelp.userInfo.user.username}')"><i class="icon-remove-circle"></i>删除</button>
                            </td>
                            <td style="display:none;">${userHelp.userRole.role.id}</td>
                        </tr>
                    </c:forEach>
                </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </form>
        </div>
    </div>

    <!-- 新增用户Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增用户</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addUsername" style="letter-spacing: 8px;">用户名:</label>
                        <input type="text" id="addUsername" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="addName" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addSex" style="letter-spacing: 19px;">性别:</label>
                        <select id="addSex" class="form-control applyDataName">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addUserJob" style="letter-spacing: 19px;">职务:</label>
                        <select id="addUserJob" class="form-control applyDataName">
                            <option value="005">教师</option>
                            <option value="003">学办</option>
                            <option value="004">教务处</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="addPhone" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="addEmail" class="form-control applyDataName">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="addUserSubmit()">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改用户信息Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改管理员信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="updateUsername" style="letter-spacing: 8px;">用户名:</label>
                        <span id="updateUsername" class="form-control applyDataName">00001</span>
                    </div>
                    <div class="form-group">
                        <label for="updateName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="updateName" class="form-control applyDataName" value="教师1">
                    </div>
                    <div class="form-group">
                        <label for="updateSex" style="letter-spacing: 19px;">性别:</label>
                        <select id="updateSex" class="form-control applyDataName">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateUserJob" style="letter-spacing: 19px;">职务:</label>
                        <select id="updateUserJob" class="form-control applyDataName">
                            <option value="005">教师</option>
                            <option value="003">学办</option>
                            <option value="004">教务处</option>
                        </select>
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
                            <div class="switchBtnLeft cont" onmousedown="btnMove()"></div>
                            <div class="switchBtnMiddle cont" onmousedown="btnMove()"></div>
                            <div class="switchBtnRight cont" onmousedown="btnMove()"></div>
                            <div class="switchBtn" id="btn" onmousedown="btnMove()"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="updateUserSubmit()">提交</button>
                </div>
            </div>
        </div>
    </div>

    <script>
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
        });
        // 按钮js
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
        // 打开修改用户的模态框
        function openUpdateUserModal(username) {
            var tr = $('#'+username+'');
            $('#updateUsername').text(tr.children('td').eq(1).text());
            $('#updateName').val(tr.children('td').eq(2).text());
            $('#updateSex').val(tr.children('td').eq(3).text()).attr('selected',true);
            $('#updateUserJob').val(tr.children('td').eq(8).text()).attr('selected',true);
            $('#updatePhone').val(tr.children('td').eq(5).text());
            $('#updateEmail').val(tr.children('td').eq(6).text());
            $("#myModal2").modal();
        }
        // 删除用户
        function deleteUser(username) {
            $.confirm({
                title: '提示',
                content: '确认删除该用户？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                buttons: {
                    确定: function(){
                        var description = $('#deleteReason').val();
                        $.ajax({
                            type: "DELETE",
                            url: "${ctx}/admin/deleteUser?username="+username+"&description="+description,
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
        //新增用户
        function addUserSubmit() {
            var username = $('#addUsername').val();
            var name = $('#addName').val();
            var sex = $('#addSex').val();
            var roleId = $('#addUserJob').val();
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
                    "code":"",
                    "name":""
                }
            };
            $.ajax({
                url:"${ctx}/admin/addUser?roleId="+roleId,
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
        function updateUserSubmit() {
            var username = $('#updateUsername').text();
            var name = $('#updateName').val();
            var sex = $('#updateSex').val();
            var roleId = $('#updateUserJob').val();
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
                    "code":"",
                    "name":""
                }
            };
            $.ajax({
                url:"${ctx}/admin/updateUser?reset="+btnResult+"&roleId="+roleId,
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
