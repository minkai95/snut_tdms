<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>申请列表</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">申请列表</p>
        <div class="teacherUpload">
            <p class="uploadTitle">类目申请列表</p>
        </div>
    </div>
    <div class="teacherPublicDataList">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center">#</th>
                    <th>类目名称</th>
                    <th>所属角色</th>
                    <th>申请人</th>
                    <th>属性1</th>
                    <th>属性2</th>
                    <th>属性3</th>
                    <th style="text-align: center">操作</th>
                </tr>
                    <tr id="001">
                        <td style="text-align: center">1</td>
                        <td>试卷试卷</td>
                        <td>教师</td>
                        <td>大爱的</td>
                        <td>学期</td>
                        <td>专业</td>
                        <td>班级</td>
                        <td style="width: 250px;  text-align: center;">
                            <button type="button" class="btn btn-info btn-sm handelBtn" ><i class="icon-pencil">处理</i></button>
                            <button type="button" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>驳回</button>
                        </td>
                        <td style="display:none;"></td>
                    </tr>
                <tr id="002">
                    <td style="text-align: center">1</td>
                    <td>试卷试卷</td>
                    <td>教师</td>
                    <td>大爱的</td>
                    <td>学期</td>
                    <td>专业</td>
                    <td>班级</td>
                    <td style="width: 250px;  text-align: center;">
                        <button type="button" class="btn btn-info btn-sm" disabled><i class="icon-pencil">已处理</i></button>
                    </td>
                    <td style="display:none;"></td>
                </tr>
            </table>
    </div>
</div>

<!-- 处理申请Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabe">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增类目</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="typePropertyName">类目名称:</label>
                    <input id="typePropertyName" class="form-control" type="text" value="试卷试卷试卷">
                    <span id="nameError" class="nameError"><i class=" icon-remove"></i>请输入2-8位类目名称</span>
                </div>
                <div class="form-group">
                    <label>类目属性:</label>
                    <button id="addProperty" class="btn btn-success btn-sm" style="margin-left: -30px;">添加属性</button>
                    <button id="removeProperty" class="btn btn-warning btn-sm">删除属性</button>
                    <div id="selectProperty" class="form-group">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default">取消</button>
                <button id="submitBtn" type="button" class="btn btn-info">确定</button>
            </div>
        </div>
    </div>
</div>

<script>
    /*处理*/
    $(".handelBtn").on("click", function(){
        $("#myModal").modal();
    });
    /*添加属性*/
    $("#addProperty").click(function(){
        var propertyLength = $("#selectProperty").find("select").length;
        console.log(propertyLength);
        if(propertyLength < "3"){
            $("#selectProperty").append("<div class='selectPropertyWrapper'><label class='propertyLabel'></label><select class='form-control'><option value='专业'>专业</option><option value='班级'>班级</option></select></div>");
            $("#selectProperty select").attr("id",function(i) {
                return "property_" + ++i;
            });
            $("#selectProperty label").attr("for",function(i) {
                return "property_" + ++i;
            });
            $("#selectProperty label").text(function(i) {
                return "属性" + ++i + "：";
            });
        } else{
            $.alert({
                title: '提示',
                content: '最多只能添加三个属性！',
                buttons: {
                    确定: function () {

                    }
                }
            })
        }
    });
    $("#removeProperty").click(function(){
        $(".selectPropertyWrapper").last().remove();
    });

    /*提交*/
    $("#submitBtn").click(function(){
        var typePropertyName = $("#typePropertyName").val();
        if(typePropertyName.length < 2|| typePropertyName.length > 6){
            $("#nameError").css("display","block");
            $("#nameError").focus;
            return false;
        }
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
