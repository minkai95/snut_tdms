<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>全校日志</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">全校日志管理</p>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>日志内容</th>
                        <th>操作行为</th>
                        <th>时间</th>
                        <th>操作者</th>
                        <th>被操作者</th>
                        <th>描述</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${logHelpClassList}" var="logHelp" varStatus="logHelpStatus">
                        <tr id="${logHelp.log.id}">
                            <td>${logHelpStatus.index+1}</td>
                            <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.content}</td>
                            <td>${logHelp.log.action}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${logHelp.log.time}"/></td>
                            <td>${logHelp.operationUserInfo.name}</td>
                            <td>${logHelp.operatedUserInfo.name}</td>
                            <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.description}</td>
                            <td style="width: 250px;  text-align: center;">
                                <button class="btn btn-info btn-sm" onclick="checkLogBtn('${logHelp.log.id}')"><i class="icon-search"></i>查看详情</button>
                            </td>
                            <td style="display: none">${logHelp.operationUserRole.role.name}</td>
                            <td style="display: none">
                                    ${logHelp.operationUserInfo.phone}<c:if test="${logHelp.operationUserInfo.phone==null}">暂无</c:if>
                            </td>
                            <td style="display: none">
                                    ${logHelp.operationUserInfo.email}<c:if test="${logHelp.operationUserInfo.email==null}">暂无</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- 查看日志Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">日志详细信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="content">日志内容</label>
                        <div id="content"></div>
                    </div>
                    <div class="form-group">
                        <label for="description">描述</label>
                        <div id="description"></div>
                    </div>
                    <div class="form-group">
                        <label for="handler">操作者</label>
                        <div id="handler">
                            <ul>
                                <li>姓名:<span id="handlerName"></span></li>
                                <li>职务:<span id="handlerJob"></span></li>
                                <li>电话:<span id="handlerPhone"></span></li>
                                <li>邮箱:<span id="handlerEmail"></span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function checkLogBtn(logId) {
            var tr = $('#'+logId+'');
            $('#content').text(tr.children('td').eq(1).text());
            $('#description').text(tr.children('td').eq(6).text());
            $('#handlerName').text(tr.children('td').eq(4).text());
            $('#handlerJob').text(tr.children('td').eq(8).text());
            $('#handlerPhone').text(tr.children('td').eq(9).text());
            $('#handlerEmail').text(tr.children('td').eq(10).text());
            $("#myModal").modal();
        }

        $("#deleteLogBtn").click(function(){
            $.confirm({
                title: '提示',
                content: '确认删除该条日志？',
                buttons: {
                    确定: function(){

                    },
                    取消: function() {

                    }
                }
            });
        });
    </script>
</body>
</html>
