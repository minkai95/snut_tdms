<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>消息公告</title>
    <style>
        .n-error{top: 5px;left: -110px;}
        .n-error:nth-child(2){top: 160px !important;left: -110px;}
    </style>
</head>
<body>
    <div class="adminCurrentWrapper">
        <p class="publicDataTitle">消息公告</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已有消息公告列表</p>
            <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal2"><i class="icon-upload" style="margin-right: 5px;"></i>发布公告</button>
        </div>
        <div class="mainCont">
            <form id="pageForm" action="${ctx}/admin/adminNews" method="get">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>标题</th>
                        <th>内容</th>
                        <th>时间</th>
                        <th>发布者</th>
                        <th>发布者职务</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    <c:forEach items="${noticeHelpList}" var="noticeHelp" varStatus="noticeStatus">
                        <tr id="${noticeHelp.systemNotice.id}">
                            <td>${noticeStatus.index+1+(page.currentPage-1)*10}</td>
                            <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${noticeHelp.systemNotice.name}</td>
                            <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${noticeHelp.systemNotice.content}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${noticeHelp.systemNotice.date}"/></td>
                            <td>${noticeHelp.userInfo.name}</td>
                            <td>${noticeHelp.userRole.role.name}</td>
                            <td style="width: 140px; text-align: center;">
                                <button type="button"  onclick="openModel('${noticeHelp.systemNotice.id}')"  class="btn btn-info"><i class="icon-search"></i>查看详情</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </form>
        </div>
    </div>

    <!-- 通告详情Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">详细信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="title">标题</label>
                        <div id="title"></div>
                    </div>
                    <div class="form-group">
                        <label for="content">内容</label>
                        <div id="content"></div>
                    </div>
                    <div class="form-group">
                        <p class="date" style="text-align: right; margin-top: 30px; font-weight: bold;">
                            发布者：<span id="modalName"></span><br>
                            职位：<span id="modalJob"></span><br>
                            <span class="date" id="modalData"></span>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 发布通告Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="publishNewsForm">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">详细信息</h4>
                </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="newsTitle">标题</label>
                            <input id="newsTitle" class="form-control" type="text" data-rule="required;newsTitle;">
                        </div>
                        <div class="form-group">
                            <label for="newsContent">内容</label>
                            <textarea id="newsContent" class="textareaStyle" data-rule="required;newsContent;"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default">重置</button>
                        <button type="submit" class="btn btn-info">发布</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // 打开查看详情模态框
        function openModel(logId) {
            var tr = $('#'+logId+'');
            $('#title').text(tr.children().eq(1).text());
            $('#content').text(tr.children().eq(2).text());
            $('#modalData').text(tr.children().eq(3).text());
            $('#modalName').text(tr.children().eq(4).text());
            $('#modalJob').text(tr.children().eq(5).text());
            $('#myModal').modal();
        }
        // 提交发布公告
        $("#publishNewsForm").on('valid.form', function () {
            var title = $('#newsTitle').val();
            var content = $('#newsContent').val();
            $.ajax({
                url:encodeURI("${ctx}/admin/publishNews?title="+title+"&content="+content),
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
        });
    </script>
</body>
</html>
