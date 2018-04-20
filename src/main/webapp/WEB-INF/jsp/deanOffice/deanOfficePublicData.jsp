<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教务处公共资料</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">教务处公共资料</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已上传公共资料列表</p>
            <label for="chooseSelect" class="chooseLabel">文件类型:</label>
            <select id="chooseSelect" class="form-control chooseSelect">
                <option value="全部">全部</option>
                <option value="试卷">试卷</option>
                <option value="实验报告">实验报告</option>
            </select>
            <select id="chooseSelect2" class="form-control chooseSelect">
                <option value="全部">全部</option>
                <option value="试卷">试卷</option>
                <option value="实验报告">实验报告</option>
            </select>
            <select id="chooseSelect3" class="form-control chooseSelect">
                <option value="全部">全部</option>
                <option value="试卷">试卷</option>
                <option value="实验报告">实验报告</option>
            </select>
            <button id="openModel" class="btn btn-success upload batchDelete"><i class="icon-upload" style="margin-right: 5px;"></i>上传公共文件</button>
            <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
        </div>
    </div>
    <div class="teacherPublicDataList">
        <form id="pageForm" action="${ctx}/user/rolePublicData?roleId=004" method="get">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
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
                        <td style="text-align: center;"><input class="checkBtn checkedBtn" type="checkbox">${dataHelpStatus.index+1}</td>
                        <td title="${dataHelp.data.fileName}" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.fileName}</td>
                        <td>${dataHelp.data.dataClass.name}</td>
                        <td title="${dataHelp.data.content}" style="max-width: 280px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.content}</td>
                        <td>${dataHelp.userInfo.name}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${dataHelp.data.submitTime}"/></td>
                        <td>公共资料</td>
                        <td style="width: 210px;  text-align: center;">
                            <button class="btn btn-info btn-sm"><i class="icon-search"></i>查看</button>
                            <button type="button" class="btn btn-primary btn-sm" onclick="downloadFile('${dataHelp.data.id}')"><i class="icon-download"></i>下载</button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="deleteFile('${dataHelp.data.id}')"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
        </form>
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
                    <form id="submitDataForm" action="${ctx}/user/uploadFile" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="description">文件描述:</label>
                            <textarea class="form-control" id="description" name="description" placeholder="请输入文件描述" ></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileType">文件类型:</label>
                            <select id="fileType" class="form-control"></select>
                        </div>
                        <div class="form-group">
                            <label for="chooseFile" class="control-label">选择文件:</label>
                            <span id="fileName" class="form-control fileName"></span>
                            <span class="btn btn-primary btn-sm chooseFileBtn" onclick="$('#chooseFile').click()">浏览</span>
                            <input class="form-control chooseFile" id="chooseFile" type="file" name="taskFile" value="" onchange="$('#fileName').text($(this).val().substr($(this).val().lastIndexOf('\\')+1))"/>
                        </div>
                        <div class="form-group" style="text-align: right; text-align: right; margin: 25px 0 0 0;">
                            <button type="reset" class="btn btn-info btn-primary">取消</button>
                            <button type="submit" id="submitDataButton" class="btn btn-success btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    //打开模态框
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
    //上传文件
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
                        确定: function () {
                            location.reload();
                        }
                    }
                })
            }
        };
        $("#submitDataForm").ajaxSubmit(options);
    });
    //逻辑删除文件
    function deleteFile(id) {
        $.confirm({
            title: '提示',
            content: '您确认删除吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                确认: function () {
                    var description = $('#deleteReason').val();
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/user/logicalDeleteDataById?id="+id+"&description="+description,
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
</html>
