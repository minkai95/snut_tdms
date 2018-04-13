<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">院系管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">已有院系列表</p>
                    <a href="#" class="upload" onclick="openMyModal()"><i class="icon-plus-sign"></i>新增院系</a>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>院系编号</th>
                        <th>院系名称</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${departmentList}" var="department" varStatus="departmentStatus">
                        <tr>
                            <td>${departmentStatus.index+1}</td>
                            <td>${department.code}</td>
                            <td>${department.name}</td>
                            <td style="width: 250px;  text-align: center;">
                                <button onclick="amendDepartmentInfo('${department.code}','${department.name}')" class="btn btn-primary btn-sm"><i class="icon-pencil"></i>修改</button>
                                <button onclick="deleteDepartment('${department.code}')" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- 新增院系Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增院系</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="departmentId">院系编号:</label>
                        <input type="text" id="departmentId" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="departmentName">院系名称:</label>
                        <input type="text" id="departmentName" class="form-control applyDataName">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button onclick="addDepartment()" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改院系Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
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
                        <input type="text" id="amendDepartmentName" class="form-control applyDataName" value="">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button onclick="updateDepartment()" class="btn btn-primary">提交</button>
                </div>
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
                content: '确认删除该院系？',
                buttons: {
                    确定: function(){
                        $.ajax({
                            url:"${ctx}/superAdmin/deleteDepartment?code="+code,
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
                    },
                    取消: function() {
                    }
                }
            })
        }
        function openMyModal() {
            $('#departmentId').val("");
            $('#departmentName').val("");
            $('#myModal').modal();
        }
        function addDepartment() {
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
        }
        function updateDepartment() {
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
        }
    </script>
</body>
</html>
