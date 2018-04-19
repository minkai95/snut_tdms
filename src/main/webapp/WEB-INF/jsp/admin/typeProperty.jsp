<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>类目属性</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">类目属性</p>
            <div class="teacherUpload">
                <p class="uploadTitle">已有类目属性列表</p>
                <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign" style="margin-right: 5px;"></i>新增类目属性</button>
            </div>
        </div>
        <div class="typePropertyContent">
            <c:forEach items="${classTypeList}" var="classType" varStatus="classTypeStatus">
                <div id="${classType.id}" class="propertyWrapper">
                    <i class="icon-remove-sign iconPosition"></i>${classType.name}
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 添加类目Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabe">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增类目属性</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="typePropertyName">属性名称:</label>
                        <input id="typePropertyName" class="form-control" type="text">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="resetBtn" class="btn btn-default">重置</button>
                    <button type="button" class="btn btn-info" onclick="addClassTypeSubmit()">确定</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function addClassTypeSubmit() {
            var name = $('#typePropertyName').val();
            $.ajax({
                url:"${ctx}/admin/addClassType?name="+name,
                type:"POST",
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
        $(".iconPosition").click(function() {
            $(this).each(function(){
                var typeClassId = $(this).parent("div").attr("id");
                var typeText = $("#" + typeClassId).text();
                $.confirm({
                    title: '提示',
                    content: '确认删除 '+typeText+' 类目属性？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                    buttons: {
                        确定: function(){
                            var description = $('#deleteReason').val();
                            $.ajax({
                                type: "DELETE",
                                url: "${ctx}/admin/deleteTypeClass?typeClassId="+typeClassId+"&description="+description,
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
            })
        });

        $(".propertyWrapper:nth-child(4n-3)").css("backgroundColor","#5cb85c");
        $(".propertyWrapper:nth-child(4n-2)").css("backgroundColor","#5bc0de");
        $(".propertyWrapper:nth-child(4n-1)").css("backgroundColor","#f0ad4e");
        $(".propertyWrapper:nth-child(4n)").css("backgroundColor","#d9534f");

        $("#resetBtn").click(function() {
            $("#typePropertyName").val('');
        });
    </script>
</body>
</html>
