<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>消息公告</title>
</head>
<body>
<div class="adminCurrentWrapper">
    <p class="publicDataTitle">消息公告</p>
    <div class="mainCont">
        <form id="pageForm" action="${ctx}/deanOffice/deanOfficeNews" method="get">
            <table class="table table-bordered table-striped">
                <tr>
                    <th>#</th>
                    <th>标题</th>
                    <th>内容</th>
                    <th>时间</th>
                    <th>发布者</th>
                    <th style="text-align: center;">操作</th>
                </tr>
                <c:forEach items="${noticeHelpList}" var="noticeHelp" varStatus="noticeStatus">
                    <tr id="${noticeHelp.systemNotice.id}">
                        <td>${noticeStatus.index+1+(page.currentPage-1)*10}</td>
                        <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${noticeHelp.systemNotice.name}</td>
                        <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${noticeHelp.systemNotice.content}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${noticeHelp.systemNotice.date}"/></td>
                        <td>${noticeHelp.userInfo.name}</td>
                        <td style="width: 140px; text-align: center;">
                            <button type="button" onclick="openModel('${noticeHelp.systemNotice.id}')" class="btn btn-info"><i class="icon-search"></i>查看详情</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
        </form>
    </div>

    <!-- Modal -->
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
                            发布者：<span id="modelName"></span><br>
                            <span class="date" id="modelData"></span>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function openModel(logId) {
        var tr = $('#'+logId+'');
        $('#title').text(tr.children().eq(1).text());
        $('#content').text(tr.children().eq(2).text());
        $('#modelData').text(tr.children().eq(3).text());
        $('#modelName').text(tr.children().eq(4).text());
        $('#myModal').modal();
    }
</script>
</html>
