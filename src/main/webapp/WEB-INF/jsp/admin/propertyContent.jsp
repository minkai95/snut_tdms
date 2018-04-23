<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>属性内容</title>
</head>
<body>
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
        <form id="pageForm" action="${ctx}/admin/propertyContent" method="get">
            <div class="teacherHeader">
                <p class="publicDataTitle">属性内容管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">已有属性内容列表</p>
                    <label for="chooseSelect" class="chooseLabel">属性名称:</label>
                    <select id="chooseSelect" name="classTypeId" class="form-control chooseSelect">
                        <option value="">全部</option>
                        <c:forEach items="${classTypeList}" var="classType" >
                            <option value="${classType.id}" <c:if test="${page.selectParam[0] == classType.id}">selected</c:if>>${classType.name}</option>
                        </c:forEach>
                    </select>
                    <button id="openModel" type="button" class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-upload" style="margin-right: 5px;"></i>新增属性内容</button>
                    <button id="batchDelete" type="button" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th style="text-align: center; width: 5%;"><input id="allCheckBtn" class="checkBtn" type="checkbox"/>#</th>
                        <th>属性名称</th>
                        <th>属性内容</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${typeContentList}" var="typeContent" varStatus="typeContentStatus">
                        <tr id="${typeContent.id}">
                            <td style="text-align: center; width: 5%;"><input class="checkBtn checkedBtn" type="checkbox"/>1</td>
                            <td>${typeContent.classType.name}</td>
                            <td>${typeContent.name}</td>
                            <td style="width: 250px;  text-align: center;">
                                <button type="button" class="btn btn-primary btn-sm" onclick="openMyModal2('${typeContent.id}')"><i class="icon-pencil"></i>修改</button>
                                <button type="button"  class="btn btn-danger btn-sm" onclick="deleteTypeContent('${typeContent.id}');"><i class="icon-remove-circle"></i>删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </div>
        </form>
    </div>
</div>

<!-- 新增院系Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增属性内容</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="addPropertyName">属性名称:</label>
                    <select id="addPropertyName" class="form-control applyDataName">
                        <c:forEach items="${classTypeList}" var="classType" >
                            <option value="${classType.id}">${classType.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="addPropertyCont">属性内容:</label>
                    <input type="text" id="addPropertyCont" class="form-control applyDataName">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="submitAddTypeContent()">提交</button>
            </div>
        </div>
    </div>
</div>

<!-- 属性内容Modal -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改属性内容</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="updateClassTypeName">属性名称:</label>
                    <span id="updateClassTypeName" class="form-control applyDataName"></span>
                </div>
                <div class="form-group">
                    <label for="updateTypeContentName">属性内容:</label>
                    <input type="text" id="updateTypeContentName" class="form-control applyDataName">
                </div>
            </div>
            <input id="typeContentId" style="display: none;"/>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button onclick="updateTypeContent()" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<script>

    $("#chooseSelect").change(function () {
        $("#currentPageInput").val("1");
        $("#pageForm").submit();
    });

    // 提交新增属性内容
    function submitAddTypeContent() {
        var classTypeId = $('#addPropertyName').val();
        var typeContentName = $('#addPropertyCont').val();
        $.ajax({
            url:"${ctx}/admin/addTypeContent?classTypeId="+classTypeId+"&typeContentName="+typeContentName,
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
                });
            }
        })
    }

    function deleteTypeContent(typeContentId) {
        $.confirm({
            title: '提示',
            content: '您确认删除该属性内容吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                取消: function () {
                },
                确定: function () {
                    var description = $('#deleteReason').val();
                    $.ajax({
                        url:"${ctx}/admin/deleteTypeContent?typeContentId="+typeContentId+"&description="+description,
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
                            });
                        }
                    })
                }
            }
        });
    }

    // 提交更新属性内容
    function updateTypeContent() {
        var typeContentId = $('#typeContentId').val();
        var typeContentName = $('#updateTypeContentName').val();
        $.ajax({
            url:"${ctx}/admin/updateTypeContent?typeContentId="+typeContentId+"&typeContentName="+typeContentName,
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
                });
            }
        })
    }

    /*打开修改Modal*/
    function openMyModal2(typeContentId){
        var tr = $('#'+typeContentId+'');
        $('#updateClassTypeName').text(tr.children('td').eq(1).text());
        $('#updateTypeContentName').val(tr.children('td').eq(2).text());
        $('#typeContentId').val(typeContentId);
        $("#myModal2").modal();
    }

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

</body>
</html>
