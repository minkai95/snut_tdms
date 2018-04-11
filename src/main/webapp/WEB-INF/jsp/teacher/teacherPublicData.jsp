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
            <a href="#" class="upload" id="openModel" data-toggle="modal"><i class="icon-upload"></i>上传公共资料</a>
        </div>
    </div>
    <div class="teacherPublicDataList">
        <table class="table table-bordered table-striped">
            <tr>
                <th>#</th>
                <th>文件名称</th>
                <th>描述</th>
                <th>上传者</th>
                <th>上传日期</th>
                <th>资料类型</th>
                <th style="text-align: center">操作</th>
            </tr>
            <c:forEach items="${dataList}" var="datahelp" varStatus="dataStatus">
                <tr id="dataList">
                    <td style="display:none">${datahelp.data.id}</td>
                    <td>${dataStatus.index+1}</td>
                    <td>${datahelp.data.fileName}</td>
                    <td>${datahelp.data.content}</td>
                    <td>${datahelp.userInfo.name}</td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${datahelp.data.submitTime}"/></td>
                    <td>公共资料</td>
                    <td style="width: 250px;  text-align: center;">
                        <button class="btn btn-info btn-sm"><i class="icon-search"></i>查看</button>
                        <a href="" class="btn btn-primary btn-sm" id="downloadFile"><i class="icon-download"></i>下载</a>
                        <button class="btn btn-danger btn-sm" id="deleteFile"><i class="icon-remove-circle"></i>删除</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">上传公共资料</h4>
            </div>
            <div class="modal-body">
                <div class="uploadForm">
                    <form id="submitDataForm" action="${ctx}/user/uploadFile" method="POST" enctype="multipart/form-data" >
                        <div class="form-group">
                            <label for="description">文件描述:</label>
                            <textarea class="form-control" id="description" name="description" placeholder="请输入文件描述" ></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileType">文件类型:</label>
                            <select id="fileType" name="fileType" class="form-control"></select>
                        </div>
                        <div class="form-group">
                            <label for="chooseFile" class="control-label">选择文件:</label>
                            <span id="fileName" class="form-control fileName"></span>
                            <span class="btn btn-primary btn-sm chooseFileBtn" onclick="$('#chooseFile').click()">浏览</span>
                            <input class="form-control chooseFile" id="chooseFile" type="file" name="taskFile" value="" onchange="$('#fileName').text($(this).val().substr($(this).val().lastIndexOf('\\')+1))"/>
                        </div>
                        <div class="form-group" style="text-align: right; text-align: right; margin: 25px 0 0 0;">
                            <button data-dismiss="modal" aria-label="Close" class="btn btn-info btn-primary">取消</button>
                            <button type="submit" id="submitDataButton" class="btn btn-success btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#openModel').on('click',function () {
        $.ajax({
            type: "GET",
            url: "${ctx}/user/getDepartmentDataClass",
            dataType: "json",
            success: function (result) {
                if(result['dataClass'].length>0){
                    var fileType = $("#fileType");
                    fileType.html("");
                    for (var i = 0; i < result['dataClass'].length; i++) {
                        fileType.append("<option id='" + result['dataClass'][i]['id'] + "' value='" + result['dataClass'][i]['id'] + "' >" + result['dataClass'][i]['name'] + "</option >");
                    }
                }
                $('#myModal').modal();
            }
        })
    });
    $('#submitDataButton').on('click',function () {
        var options = {
            dataType:"json",
            url:"${ctx}/user/uploadFile?description="+$('#description').val()+"&fileType="+$('#fileType').val(),
            resetForm: true,
            success: function (result) {
                $.confirm({
                    title: '提示',
                    content: result['message'],
                    buttons: {
                        关闭: function () {
                            location.reload();
                        }
                    }
                })
            }
        };
        $("#submitDataForm").ajaxForm(options);
    });
    $('#deleteFile').on('click',function () {
        $.confirm({
            title: '提示',
            content: '您确认删除吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                确认: function () {
                    var description = $('#deleteReason').val();
                    var id = $('#dataList').children('td').eq(0).text();
                    console.log(description+"==="+id);
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/teacher/logicalDeleteDataById?id="+id+"&description="+description,
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
    });
    $('#downloadFile').on('click',function () {
        var tr = $('#dataList');
        var id = tr.children('td').eq(0).text();
        var filename = tr.children('td').eq(2).text();
        $(this).attr("href","${ctx}/user/downloadFile?saveFilename="+id+"_"+filename)
    })
</script>
</body>
</html>