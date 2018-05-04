<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>教务处公共资料</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <form id="pageForm" action="${ctx}/user/rolePublicData?roleId=004" method="get">
        <input id="typeContentStr" style="display:none;" type="text" name="typeContentStr"/>
        <input style="display:none;" type="text" name="roleId" value="004"/>
        <div class="teacherHeader">
            <p class="publicDataTitle">教务处公共资料</p>
            <div class="teacherUpload">
                <p class="uploadTitle">已上传公共资料列表</p>
                <label for="dataClassFilter" class="chooseLabel">文件类型:</label>
                <select id="dataClassFilter" name="dataClassId" class="form-control chooseSelect">
                    <option value="">全部</option>
                    <c:forEach items="${dataClassHelpList}" var="dataClassHelp">
                        <option value="${dataClassHelp.dataClass.id}" <c:if test="${page.selectParam[0]==dataClassHelp.dataClass.id}">selected</c:if>>${dataClassHelp.dataClass.name}</option>
                    </c:forEach>
                </select>
                <c:forEach items="${dataClassHelpList}" var="dataClassHelp">
                    <c:if test="${dataClassHelp.dataClass.id==nowDataClassId}">
                        <c:forEach items="${dataClassHelp.classTypeHelpClassList}" var="classTypeHelp" varStatus="classTypeStatus">
                            <label for="typeContentStrFilter${classTypeStatus.index+1}" class="chooseLabel">${classTypeHelp.classType.name}:</label>
                            <select id="typeContentStrFilter${classTypeStatus.index+1}" class="form-control chooseSelect">
                                <option value="">全部</option>
                                <c:forEach items="${classTypeHelp.typeContentList}" var="typeContent">
                                    <option value="${typeContent.id}" <c:if test="${page.selectParam[classTypeStatus.index+1]==typeContent.id}">selected</c:if>>${typeContent.name}</option>
                                </c:forEach>
                            </select>
                        </c:forEach>
                    </c:if>
                </c:forEach>
                <button id="openModel" type="button" class="btn btn-success upload batchDelete"><i class="icon-upload" style="margin-right: 5px;"></i>上传公共文件</button>
                <button id="batchDelete" type="button" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
            </div>
        </div>
        <div class="teacherPublicDataList">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                    <th>文件名称</th>
                    <th>文件类型</th>
                    <th>描述</th>
                    <th>上传者</th>
                    <th>上传日期</th>
                    <th style="text-align: center">操作</th>
                </tr>
                <c:forEach items="${dataHelpClassList}" var="dataHelp" varStatus="dataHelpStatus">
                    <tr id="${dataHelp.data.id}">
                        <td style="text-align: center;"><input class="checkBtn checkedBtn" type="checkbox">${dataHelpStatus.index+1+(page.currentPage-1)*10}</td>
                        <td title="${dataHelp.data.fileName}" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.fileName}</td>
                        <td>${dataHelp.data.dataClass.name}</td>
                        <td title="${dataHelp.data.content}" style="max-width: 280px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dataHelp.data.content}</td>
                        <td>${dataHelp.userInfo.name}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${dataHelp.data.submitTime}"/></td>
                        <td style="width: 210px;  text-align: center;">
                            <button type="button" class="btn btn-info btn-sm" onclick="openFile('${dataHelp.data.id}')"><i class="icon-search"></i> 预览</button>
                            <button type="button" class="btn btn-primary btn-sm" onclick="downloadFile('${dataHelp.data.id}')"><i class="icon-download"></i> 下载</button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="deleteFile('${dataHelp.data.id}')"><i class="icon-remove-circle"></i> 删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
        </div>
    </form>
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
                            <textarea class="form-control upLoadDescription" id="description" name="description" placeholder="请输入文件描述" ></textarea>
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
<div class="spin"></div>
<div id="mb"></div>
<script>
    // 打开文件
    function openFile(id) {
        var tr = $('#'+id+'');
        var filename = tr.children('td').eq(1).text();
        filename = filename.replace(/\+/g,"*");
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
                                    success: function () {
                                        location.reload();
                                    }
                                });
                            }
                        }
                    })
                }else {
                    var name = filename.split(".")[1].toLowerCase();
                    var src = result['message'];
                    if (name=="png"||name=="jpg"||name=="jpeg"){
                        window.open("${ctx}/user/openPicture?saveFilename="+id+"_"+filename,"_blank");
                    }else if(name=="pdf"){
                        src = src+"~+~"+id+"_"+filename;
                        src = src.replace(/\\/g,"~+~");
                        window.open("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src,"_blank");
                    }else if (name=="doc"||name=="docx"||name=="txt"||name=="xls"||name=="xlsx"||name=="ppt"||name=="pptx"){
                        $.ajax({
                            type: "GET",
                            url: "${ctx}/user/selectFile?saveFilename="+id+"_"+filename+"&realType=pdf",
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
                                        url: "${ctx}/user/officeToPDF?src="+src,
                                        dataType: "json",
                                        success: function (result) {
                                            $("#mb").css("display","none");
                                            spinner.spin();
                                            $(ele).hide();
                                            if (result['message']==1){
                                                src = src.replace(/~~/g,"~+~");
                                                window.open("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src,"_blank");
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
                                    window.open("/resources/pdf/generic/web/viewer.html?file=${ctx}/user/openPDF/"+src,"_blank");
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

    $("#dataClassFilter").change(function () {
        $("#currentPageInput").val("1");
        $("#pageForm").submit();
    });

    $('#typeContentStrFilter1,#typeContentStrFilter2,#typeContentStrFilter3').change(function () {
        $("#currentPageInput").val("1");
        var t1 = $('#typeContentStrFilter1').val();
        var t2 = $('#typeContentStrFilter2').val();
        var t3 = $('#typeContentStrFilter3').val();
        var str = [];
        if ('undefined'==t1){
            str[0]="";
        }else {
            str[0]=t1;
        }
        if ('undefined'==t2){
            str[1]="";
        }else {
            str[1]=t2;
        }
        if ('undefined'==t3){
            str[2]="";
        }else {
            str[2]=t3;
        }
        $('#typeContentStr').val(str.join("/"));
        $("#pageForm").submit();
    });

    //打开模态框
    $('#openModel').on('click',function () {
        $.ajax({
            type: "GET",
            url: "${ctx}/user/getDepartmentDataClass",
            dataType: "json",
            success: function (result) {
                if(result['dataClassHelp'].length>0){
                    var fileType = $("#fileType");
                    fileType.html("");
                    var sb = $('#submitDataForm');
                    if(sb.children('div').length>4){
                        var tar = sb.children('div').length-4;
                        for(var m=0;m<tar;m++){
                            sb.children('div').eq(2).remove();
                        }
                    }
                    for (var i = 0; i < result['dataClassHelp'].length; i++) {
                        fileType.append("<option value='" + result['dataClassHelp'][i]['dataClass']['id'] + "' >" + result['dataClassHelp'][i]['dataClass']['name'] + "</option >");
                    }
                    if (result['dataClassHelp'][0]['classTypeHelpClassList'].length>0){
                        for(var j=0;j<result['dataClassHelp'][0]['classTypeHelpClassList'].length;j++){
                            $('.form-group').eq(1+j).after("<div class='form-group appendGroup'>" +
                                "<label class='appendLabel' for='"+result['dataClassHelp'][0]['classTypeHelpClassList'][j]['classType']['id']+"'>"+result['dataClassHelp'][0]['classTypeHelpClassList'][j]['classType']['name']+":</label>" +
                                "<select id='"+result['dataClassHelp'][0]['classTypeHelpClassList'][j]['classType']['id']+"' class='form-control appendSelect'></select>" +
                                "</div>");
                            for(var a = 0;a<result['dataClassHelp'][0]['classTypeHelpClassList'][j]['typeContentList'].length;a++){
                                $('#'+result['dataClassHelp'][0]['classTypeHelpClassList'][j]['classType']['id']+'')
                                    .append("<option value='" + result['dataClassHelp'][0]['classTypeHelpClassList'][j]['typeContentList'][a]['id'] + "' >" + result['dataClassHelp'][0]['classTypeHelpClassList'][j]['typeContentList'][a]['name'] + "</option >");
                            }
                            if (j>0){
                                sb.children('div').eq(j+2).addClass("appendMargin");
                            }
                        }
                    }
                }
                $('#myModal').modal();
            }
        })
    });

    // 模态框内类目属性动态变化
    $('#fileType').change(function () {
        var sb = $('#submitDataForm');
        if(sb.children('div').length>4){
            var tar = sb.children('div').length-4;
            for(var m=0;m<tar;m++){
                sb.children('div').eq(2).remove();
            }
        }
        var dataClassId = $('#fileType').val();
        $.ajax({
            type: "GET",
            url: "${ctx}/user/selectClassTypeByParam?dataClassId="+dataClassId,
            dataType: "json",
            success: function (result) {
                if (result['result'].length>0){
                    for(var i=0;i<result['result'].length;i++) {
                        $('.form-group').eq(1 + i).after("<div class='form-group appendGroup'>" +
                            "<label for='" + result['result'][i]['classType']['id'] + "'>" + result['result'][i]['classType']['name'] + ":</label>" +
                            "<select id='" + result['result'][i]['classType']['id'] + "' class='form-control'></select>" +
                            "</div>");
                        for (var j = 0; j < result['result'][i]['typeContentList'].length; j++) {
                            $('#' + result['result'][i]['classType']['id'] + '').append("<option value='" + result['result'][i]['typeContentList'][j]['id'] + "'>" + result['result'][i]['typeContentList'][j]['name'] + "</option>")
                        }
                        if (i>0){
                            sb.children('div').eq(i+2).addClass("appendMargin");
                        }
                    }
                }
            }
        })
    });

    //上传文件
    $('#submitDataButton').on('click',function () {
        if($("#fileName").text() == null || $("#fileName").text() == ""){
            $.alert({
                title: '提示',
                content: '文件不能为空！'
            });
            return false;
        }else{
            var sb = $('#submitDataForm');
            var typeContentArr = [];
            if(sb.children('div').length>4){
                var tar = sb.children('div').length-4;
                for(var m=0;m<tar;m++){
                    typeContentArr.push(sb.children('div').eq(2+m).find('select').val());
                }
            }
            var typeContentStr = typeContentArr.join("/");
            var options = {
                dataType:"json",
                url:"${ctx}/user/uploadFile?description="+$('#description').val()+"&fileType="+$('#fileType').val()+"&typeContentStr="+typeContentStr,
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
            }
        }
        sb.ajaxSubmit(options);
    });
    //逻辑删除文件
    function deleteFile(id) {
        $.confirm({
            title: '提示',
            content: '您确认删除吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
            buttons: {
                关闭: function () {
                },
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
                }
            }
        })
    }
    //下载文件
    function downloadFile(id) {
        var tr = $('#'+id+'');
        var filename = tr.children('td').eq(1).text();
        filename = filename.replace(/\+/g,"*");
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
        var ids = checkedTrId.join(",");
        if (checkedTrId.length>0){
            $.confirm({
                title: '提示',
                content: '您确认删除'+checkedTrId.length+'条数据吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入删除原因(选填)"/>',
                buttons: {
                    关闭: function () {
                    },
                    确认: function () {
                        var description = $('#deleteReason').val();
                        $.ajax({
                            type: "POST",
                            url: "${ctx}/user/logicalDeleteDataById?id="+ids+"&description="+description,
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
