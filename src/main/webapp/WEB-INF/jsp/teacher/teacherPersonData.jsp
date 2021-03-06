<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教师私有资料</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">教师私有资料</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已上传私有资料列表</p>
            <button id="openModel" class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-upload" style="margin-right: 5px;"></i>上传私有文件</button>
            <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
        </div>
    </div>
    <div class="teacherPublicDataList">
        <form id="pageForm" action="${ctx}/user/personData" method="get">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                    <th>文件名称</th>
                    <th>描述</th>
                    <th>上传者</th>
                    <th>上传日期</th>
                    <th>资料类型</th>
                    <th style="text-align: center;">操作</th>
                </tr>
                <c:forEach items="${dataList}" var="dataHelp" varStatus="dataStatus">
                    <tr id="${dataHelp.data.id}">
                        <td style="text-align: center;"><input class="checkBtn checkedBtn" type="checkbox">${dataStatus.index+1+(page.currentPage-1)*10}</td>
                        <td title="${dataHelp.data.fileName}" style="max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.fileName}</td>
                        <td title="${dataHelp.data.content}" style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.content}</td>
                        <td>${dataHelp.userInfo.name}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${dataHelp.data.submitTime}"/></td>
                        <td>私有资料</td>
                        <td style="min-width: 210px;  text-align: center;">
                            <button type="button" onclick="openFile('${dataHelp.data.id}')" class="btn btn-info btn-sm"><i class="icon-search"></i> 预览</button>
                            <button type="button" onclick="downloadFile('${dataHelp.data.id}')" class="btn btn-primary btn-sm"><i class="icon-download"></i> 下载</button>
                            <button type="button" onclick="deleteFile('${dataHelp.data.id}')" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i> 删除</button>
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
                <h4 class="modal-title" id="myModalLabel">上传私有资料</h4>
            </div>
            <div class="modal-body">
                <div class="uploadForm">
                    <form id="submitDataForm" action="${ctx}/user/uploadFile" method="POST" enctype="multipart/form-data" >
                        <div class="form-group">
                            <label for="description">文件描述:</label>
                            <textarea class="form-control upLoadDescription" id="description" name="description" placeholder="请输入文件描述" ></textarea>
                        </div>
                        <div class="form-group">
                            <label for="chooseFile" class="control-label">选择文件:</label>
                            <span id="fileName" class="form-control fileName"></span>
                            <span class="btn btn-primary btn-sm chooseFileBtn" onclick="$('#chooseFile').click()">浏览</span>
                            <input class="form-control chooseFile" id="chooseFile" type="file" name="taskFile" value="" onchange="$('#fileName').text($(this).val().substr($(this).val().lastIndexOf('\\')+1))"/>
                        </div>
                        <div class="form-group" style="text-align: right; margin: 25px 0 0 0;">
                            <button  data-dismiss="modal" aria-label="Close" class="btn btn-info btn-primary">取消</button>
                            <button type="submit" id="submitDataButton" class="btn btn-success btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="spin"></div>
<div id="mb">
    <p class="spinText">首次加载时间较长，请耐心等待...</p>
</div>
<script>
    // 打开文件
    function openFile(id) {
        var tr = $('#'+id+'');
        var filename = tr.children('td').eq(1).text();
        filename = filename.replace(/\+/g,"*");
        $.ajax({
            type: "GET",
            url: encodeURI("${ctx}/user/selectFile?saveFilename="+id+"_"+filename),
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
                                    url: encodeURI("${ctx}/user/deleteFile?dataId="+id+"&description="+""),
                                    dataType: "json",
                                    success: function () {
                                        location.reload();
                                    }
                                });
                            }
                        }
                    })
                }else {
                    var len = filename.split(".").length;
                    var name = filename.split(".")[len-1].toLowerCase();
                    var src = result['message'];
                    if (name=="png"||name=="jpg"||name=="jpeg"){
                        window.open(encodeURI("${ctx}/user/openPicture?saveFilename="+id+"_"+filename),"_blank");
                    }else if(name=="pdf"){
                        src = src+"~+~"+id+"_"+filename;
                        src = src.replace(/\\/g,"~+~");
                        window.open(encodeURI("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src),"_blank");
                    }else if (name=="doc"||name=="docx"||name=="txt"||name=="xls"||name=="xlsx"||name=="ppt"||name=="pptx"){
                        $.ajax({
                            type: "GET",
                            url: encodeURI("${ctx}/user/selectFile?saveFilename="+id+"_"+filename+"&realType=pdf"),
                            dataType: "json",
                            success: function (result) {
                                if (result['message'] == '您要下载的资源已被删除!') {
                                    src = src+"~~"+id+"_"+filename;
                                    src = src.replace(/\\/g,"~~");
                                    var ele = ".spin";
                                    var opts = {
                                        lines: 13, // 花瓣数目
                                        length: 20, // 花瓣长度
                                        width: 10, // 花瓣宽度
                                        radius: 30, // 花瓣距中心半径
                                        scale: 1,
                                        corners: 1, // 花瓣圆滑度 (0-1)
                                        color: '#000', // 花瓣颜色
                                        opacity: 0.25,
                                        rotate: 0, // 花瓣旋转角度
                                        direction: 1, // 花瓣旋转方向 1: 顺时针, -1: 逆时针
                                        speed: 1, // 花瓣旋转速度
                                        trail: 60, // 花瓣旋转时的拖影(百分比)
                                        zIndex: 2e9, // spinner的z轴 (默认是2000000000)
                                        className: 'spinner', // spinner css 样式名称
                                        top: '50%', // spinner 相对父容器Top定位 单位 px
                                        left: '50%', // spinner 相对父容器Left定位 单位 px
                                        shadow: false, // 花瓣是否显示阴影
                                        hwaccel: false, //spinner 是否启用硬件加速及高速旋转
                                        position: 'absolute'
                                    };
                                    $("#mb").css("display","block");
                                    var spinner = new Spinner(opts);
                                    $(ele).show();
                                    var target = $(ele)[0];
                                    spinner.spin(target);
                                    $.ajax({
                                        type: "POST",
                                        url: encodeURI("${ctx}/user/officeToPDF?src="+src),
                                        dataType: "json",
                                        success: function (result) {
                                            $("#mb").css("display","none");
                                            spinner.spin();
                                            $(ele).hide();
                                            if (result['message']==1){
                                                src = src.replace(/~~/g,"~+~");
                                                window.open(encodeURI("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src),"_blank");
                                            }else {
                                                $.confirm({
                                                    title: '提示',
                                                    content: '预览失败,请尝试下载后查看!',
                                                    buttons: {
                                                        确定: function () {
                                                        }
                                                    }
                                                })
                                            }
                                        }
                                    })
                                }else {
                                    src = src+"~+~"+id+"_"+filename;
                                    src = src.replace(/\\/g,"~+~");
                                    window.open(encodeURI("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src),"_blank");
                                }
                            }
                        })
                    }else {
                        $.confirm({
                            title: '提示',
                            content: '预览失败,请尝试下载后查看!',
                            buttons: {
                                确定: function () {
                                }
                            }
                        })
                    }
                }
            }
        })
    }

    // 上传文件
    $('#submitDataButton').on('click',function () {
        if($("#fileName").text() == null || $("#fileName").text() == ""){
            $.alert({
                title: '提示',
                content: '文件不能为空！'
            });
            return false;
        }else{
            var options = {
                dataType:"json",
                url:encodeURI("${ctx}/user/uploadFile?description="+$('#description').val()),
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
        }
    });

    //下载文件
    function downloadFile(id) {
        var tr = $('#'+id+'');
        var filename = tr.children('td').eq(1).text();
        filename = filename.replace(/\+/g,"*");
        $.ajax({
            type: "GET",
            url: encodeURI("${ctx}/user/selectFile?saveFilename="+id+"_"+filename),
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
                                    url: encodeURI("${ctx}/user/deleteFile?dataId="+id+"&description="+""),
                                    dataType: "json",
                                    success: function () {
                                        location.reload();
                                    }
                                });
                            }
                        }
                    })
                }else {
                    window.location.href = encodeURI("${ctx}/user/downloadFile?saveFilename="+id+"_"+filename);
                }
            }
        });
    }
    //删除文件
    function deleteFile(id) {
        $.confirm({
            title: '提示',
            content: '您确认删除吗？(删除后不可恢复)<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                关闭: function () {
                 },
                确认: function () {
                    var description = $('#deleteReason').val();
                    $.ajax({
                        type: "DELETE",
                        url: encodeURI("${ctx}/user/deleteFile?dataId="+id+"&description="+description),
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
                }
            }
        })
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
        var ids = checkedTrId.join(",");
        if (checkedTrId.length>0){
            $.confirm({
                title: '提示',
                content: '您确认删除'+checkedTrId.length+'条数据吗？(删除后不可恢复)<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                buttons: {
                    关闭: function () {
                    },
                    确认: function () {
                        var description = $('#deleteReason').val();
                        $.ajax({
                            type: "DELETE",
                            url: encodeURI("${ctx}/user/deleteFile?dataId="+ids+"&description="+description),
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
                    }
                }
            })
        }else {
            $.confirm({
                title: '提示',
                content: '请在勾选需要删除的文件!',
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
