<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教师公共资料</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">教师公共资料</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已上传公共资料列表</p>
        </div>
    </div>
    <div class="teacherPublicDataList">
        <table class="table table-bordered table-striped">
            <tr>
                <th>#</th>
                <th>文件名称</th>
                <th>文件类型</th>
                <th>描述</th>
                <th>上传者</th>
                <th>上传日期</th>
                <th>资料类型</th>
                <th style="text-align: center">操作</th>
            </tr>
            <c:forEach items="${dataHelpClassList}" var="dataHelp" varStatus="dataHelpStatus">
                <tr id="${dataHelp.data.id}">
                    <td>${dataHelpStatus.index+1}</td>
                    <td>${dataHelp.data.fileName}</td>
                    <td>${dataHelp.data.dataClass.name}</td>
                    <td>${dataHelp.data.content}</td>
                    <td>${dataHelp.userInfo.name}</td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${dataHelp.data.submitTime}"/></td>
                    <td>公共资料</td>
                    <td style="width: 250px;  text-align: center;">
                        <button class="btn btn-info btn-sm"><i class="icon-search"></i>查看</button>
                        <a class="btn btn-primary btn-sm" onclick="downloadFile('${dataHelp.data.id}')"><i class="icon-download"></i>下载</a>
                        <button class="btn btn-danger btn-sm" onclick="deleteFile('${dataHelp.data.id}')"><i class="icon-remove-circle"></i>删除</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
<script>
    //删除文件
    function deleteFile(dataId) {
        $.confirm({
            title: '提示',
            content: '您确认删除吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                确认: function () {
                    var description = $('#deleteReason').val();
                    $.ajax({
                        type: "DELETE",
                        url: "${ctx}/user/deleteFile?dataId="+dataId+"&description="+description,
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
                    });
                },
                关闭: function () {
                    $('#myModal').modal("hide");
                }
            }
        })
    }
    //下载文件
    function downloadFile(id) {
        var tr = $('#'+id+'');
        var filename = tr.children('td').eq(1).text();
        $.ajax({
            type: "GET",
            url: "${ctx}/user/selectFile?saveFilename="+id+"_"+filename,
            dataType: "json",
            success: function (result) {
                if (result['message']=='您要下载的资源已被删除!') {
                    $.confirm({
                        title: '提示',
                        content: result['message'],
                        buttons: {
                            确定: function () {
                                $.ajax({
                                    type: "DELETE",
                                    url: "${ctx}/user/deleteFile?dataId="+id+"&description="+"",
                                    dataType: "json",
                                    success: function (result) {
                                        location.reload();
                                    }
                                });
                            }
                        }
                    })
                }else {
                    window.location.href = "${ctx}/user/downloadFile?saveFilename="+id+"_"+filename;
                }
            }
        });
    }
</script>
</html>

