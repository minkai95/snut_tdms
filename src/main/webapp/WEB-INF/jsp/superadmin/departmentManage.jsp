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
                    <a href="#" class="upload" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign"></i>新增院系</a>
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
                    <tr>
                        <td>1</td>
                        <td>000001</td>
                        <td>管理学院</td>
                        <td style="width: 250px;  text-align: center;">
                            <button id="amendDepartmentInfo" class="btn btn-primary btn-sm"><i class="icon-pencil"></i>修改</button>
                            <button class="btn btn-danger btn-sm" id="deleteDepartment"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>000002</td>
                        <td>数计学院</td>
                        <td style="width: 250px;  text-align: center;">
                            <button class="btn btn-primary btn-sm"><i class="icon-pencil"></i>修改</button>
                            <button class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
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
                    <button type="button" class="btn btn-primary">提交</button>
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
                        <span id="amendDepartmentId" class="form-control applyDataName">00001</span>
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentName">院系名称:</label>
                        <input type="text" id="amendDepartmentName" class="form-control applyDataName" value="管理学院">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#amendDepartmentInfo").on("click", function(){
            $("#myModal2").modal();
        })

        $("#deleteDepartment").click(function() {
            $.confirm({
                title: '提示',
                content: '确认删除该管理员？',
                buttons: {
                    确定: function(){

                     },
                    取消: function() {

                    }
                }
            });
        })
    </script>
</body>
</html>
