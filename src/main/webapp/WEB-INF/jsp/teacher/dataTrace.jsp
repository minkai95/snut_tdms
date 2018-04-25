<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>资料追踪</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <form id="pageForm" action="${ctx}/user/dataTrace" method="get">
            <p class="publicDataTitle">资料追踪</p>
            <label for="dataClassFilter" class="chooseLabel" style="margin-left: 0;">文件类型:</label>
            <select id="dataClassFilter" name="dataClassId" class="form-control chooseSelect">
                <option value="">全部</option>
                <c:forEach items="${dataClassList}" var="dataClass">
                    <option value="${dataClass.id}" <c:if test="${page.selectParam[0]==dataClass.id}">selected</c:if>>${dataClass.name}</option>
                </c:forEach>
            </select>
            <label for="actionFilter" class="chooseLabel">操作动作:</label>
            <select id="actionFilter" name="action" class="form-control chooseSelect">
                <option value="">全部</option>
                <option value="新增" <c:if test="${page.selectParam[1]=='新增'}">selected</c:if>>新增</option>
                <option value="删除" <c:if test="${page.selectParam[1]=='删除'}">selected</c:if>>删除</option>
                <option value="恢复" <c:if test="${page.selectParam[1]=='恢复'}">selected</c:if>>恢复</option>
                <option value="逻辑删除" <c:if test="${page.selectParam[1]=='逻辑删除'}">selected</c:if>>逻辑删除</option>
            </select>
            <div class="mainCont">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>文件名</th>
                        <th>文件类型</th>
                        <th>内容</th>
                        <th>动作</th>
                        <th>时间</th>
                        <th>操作者</th>
                        <th>描述</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    <c:forEach items="${logHelpList}" var="logHelp" varStatus="logStatus">
                        <tr id="${logHelp.log.id}">
                            <td>${logStatus.index+1+(page.currentPage-1)*10}</td>
                            <td title="${logHelp.operatedData.fileName}" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.operatedData.fileName}<c:if test="${logHelp.operatedData.fileName==null}">暂无</c:if></td>
                            <td>${logHelp.operatedData.dataClass.name}<c:if test="${logHelp.operatedData.dataClass.name==null}">暂无</c:if></td>
                            <td title="${logHelp.log.content}" style="max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.content}</td>
                            <td>${logHelp.log.action}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${logHelp.log.time}"/></td>
                            <td>${logHelp.operationUserInfo.name}</td>
                            <td title="${logHelp.log.description}" style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.description}</td>
                            <td style="width: 140px; text-align: center;">
                                <button type="button" onclick="openModel('${logHelp.log.id}')" class="btn btn-info"><i class="icon-search"></i>查看详情</button>
                            </td>
                            <td style="display: none">${logHelp.operationUserRole.role.name}</td>
                            <td style="display: none">${logHelp.operationUserInfo.phone}</td>
                            <td style="display: none">${logHelp.operationUserInfo.email}</td>
                            <td style="display:none">${logHelp.operatedType}</td>
                            <c:if test="${logHelp.operatedType == '文件'}">
                                <td style="display:none;">
                                    <span>${logHelp.operatedData.fileName}<c:if test="${logHelp.operatedData.fileName==null}">已被删除</c:if></span>
                                    <span>${logHelp.operatedData.dataClass.name}<c:if test="${logHelp.operatedData.dataClass.name==null}">已被删除</c:if></span>
                                </td>
                            </c:if>
                            <c:if test="${logHelp.operatedType == '文件类型'}">
                                <td style="display:none">
                                    <span>${logHelp.operatedDataClass.name}<c:if test="${logHelp.operatedDataClass.name==null}">已被删除</c:if></span>
                                    <span>${logHelp.operatedDataClass.department.name}<c:if test="${logHelp.operatedDataClass.department.name==null}">已被删除</c:if></span>
                                    <span>${logHelp.operatedDataClass.role.name}<c:if test="${logHelp.operatedDataClass.role.name==null}">已被删除</c:if></span>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </div>
        </form>

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
                            <label for="content">内容</label>
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
                            <label for="handler2">被操作对象:<span id="operatedType"></span></label>
                            <div id="handler2">
                                <ul></ul>
                            </div>
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

    $("#dataClassFilter,#actionFilter").change(function () {
        $("#currentPageInput").val("1");
        $("#pageForm").submit();
    });

    function openModel(logId) {
        var tr = $('#'+logId+'');
        $('#content').text(tr.children().eq(3).text());
        $('#description').text(tr.children().eq(7).text());
        $('#handlerName').text(tr.children().eq(6).text());
        $('#handlerJob').text(tr.children().eq(9).text());
        $('#handlerPhone').text(tr.children().eq(10).text());
        $('#handlerEmail').text(tr.children().eq(11).text());
        var operatedType = tr.children('td').eq(12).text();
        $('#operatedType').text(operatedType);
        var ul = $("#handler2").children('ul').eq(0);
        ul.html("");
        var td = tr.children('td').eq(13);
        if (operatedType=='文件'){
            ul.append("<li>文件名:"+td.children('span').eq(0).text()+"</li>");
            ul.append("<li>文件类型:"+td.children('span').eq(1).text()+"</li>");
        }else if (operatedType=='文件类型'){
            ul.append("<li>类型名称:"+td.children('span').eq(0).text()+"</li>");
            ul.append("<li>所属院系:"+td.children('span').eq(1).text()+"</li>");
            ul.append("<li>所属角色:"+td.children('span').eq(2).text()+"</li>")
        }
        $('#myModal').modal();
    }
</script>
</html>
