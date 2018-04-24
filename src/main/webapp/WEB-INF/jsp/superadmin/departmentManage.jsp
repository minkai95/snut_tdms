<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理</title>
    <style>
        .n-error{top: 5px !important;left: -165px !important;  }
    </style>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">院系管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">已有院系列表</p>
                    <button id="openModel" class="btn btn-success upload batchDelete" onclick="openMyModal()"><i class="icon-upload" style="margin-right: 5px;"></i>新增院系</button>
                    <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <form id="pageForm" action="${ctx}/superAdmin/departmentManage" method="get">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="text-align: center; width: 5%;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                            <th>院系编号</th>
                            <th>院系名称</th>
                            <th style="text-align: center">操作</th>
                        </tr>
                        <c:forEach items="${departmentList}" var="department" varStatus="departmentStatus">
                            <tr id="${department.code}">
                                <td style="text-align: center; width: 5%;"><input class="checkBtn checkedBtn" type="checkbox">${departmentStatus.index+1+(page.currentPage-1)*10}</td>
                                <td>${department.code}</td>
                                <td>${department.name}</td>
                                <td style="width: 250px;  text-align: center;">
                                    <button type="button" onclick="amendDepartmentInfo('${department.code}','${department.name}')" class="btn btn-primary btn-sm"><i class="icon-pencil"></i>修改</button>
                                    <button type="button" onclick="deleteDepartment('${department.code}')" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
                </form>
            </div>
        </div>
    </div>

    <!-- 新增院系Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="addDepartmentForm">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">新增院系</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="departmentId">院系编号:</label>
                            <input type="text" id="departmentId" class="form-control applyDataName" name="departmentId"
                                   data-rule="required;departmentId;"
                                   data-rule-departmentId="[/^[A-Za-z0-9]{4,16}$/, '请输入4-16数字或字母']">
                        </div>
                        <div class="form-group">
                            <label for="departmentName">院系名称:</label>
                            <input type="text" id="departmentName" class="form-control applyDataName" name="departmentName"
                                   data-rule="required;departmentName;"
                                   data-rule-departmentName="[/^([\u4e00-\u9fa5]){4,8}$/, '请输入4-8位汉字学院名称']">
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

    <!-- 修改院系Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="editDepartmentInfoForm">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">新增院系</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="amendDepartmentId">院系编号:</label>
                            <span id="amendDepartmentId" class="form-control applyDataName"></span>
                        </div>
                        <div class="form-group">
                            <label for="amendDepartmentName">院系名称:</label>
                            <input type="text" id="amendDepartmentName" class="form-control applyDataName" name="amendDepartmentName" value=""
                                   data-rule="required;amendDepartmentName;"
                                   data-rule-amendDepartmentName="[/^([\u4e00-\u9fa5]){4,8}$/, '请输入4-8位汉字学院名称']">
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

    <script>
        function amendDepartmentInfo(code,name) {
            $('#amendDepartmentId').text(code);
            $('#amendDepartmentName').val(name);
            $("#myModal2").modal();
        }
        function deleteDepartment(code) {
            $.confirm({
                title: '提示',
                content: '您确认删除该条院系数据吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                buttons: {
                    取消: function() {
                    },
                    确定: function(){
                        var description = $('#deleteReason').val();
                        $.ajax({
                            url:"${ctx}/superAdmin/deleteDepartment?code="+code+"&description="+description,
                            type:"DELETE",
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
                }
            })
        }
        function openMyModal() {
            $('#departmentId').val("");
            $('#departmentName').val("");
            $('#myModal').modal();
        }

        /*新增院系*/
        $("#addDepartmentForm").on('valid.form', function () {
            var departmentId = $('#departmentId').val();
            var departmentName = $('#departmentName').val();
            var department = {
                "code":departmentId,
                "name":departmentName
            };
            $.ajax({
                url:"${ctx}/superAdmin/addDepartment",
                type:"POST",
                data:JSON.stringify(department),
                contentType:"application/json",
                dataType:"json",
                success: function (result) {
                    console.log(result['message']);
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

        /*修改院系信息*/
        $("#editDepartmentInfoForm").on('valid.form', function () {
            var departmentId = $('#amendDepartmentId').text();
            var departmentName = $('#amendDepartmentName').val();
            var department = {
                "code":departmentId,
                "name":departmentName
            };
            $.ajax({
                url:"${ctx}/superAdmin/updateDepartment",
                type:"POST",
                data:JSON.stringify(department),
                contentType:"application/json",
                dataType:"json",
                success: function (result) {
                    console.log(result['message']);
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
            var codes = checkedTrId.join(",");
            if (checkedTrId.length>0){
                $.confirm({
                    title: '提示',
                    content: '您确认删除'+checkedTrId.length+'条院系数据吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                    buttons: {
                        取消: function() {
                        },
                        确定: function(){
                            var description = $('#deleteReason').val();
                            $.ajax({
                                url:"${ctx}/superAdmin/deleteDepartment?code="+codes+"&description="+description,
                                type:"DELETE",
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
                    }
                })
            }else {
                $.confirm({
                    title: '提示',
                    content: '请在勾选需要删除的院系!',
                    buttons: {
                        确定: function () {
                        }
                    }
                })
            }
        });
    </script>
</body>
</html>
