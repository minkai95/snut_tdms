<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>学院日志</title>
</head>
<body>
   <div class="teacherCurrentWrapper">
       <form id="pageForm" action="${ctx}/admin/adminLog" method="get">
            <div class="teacherHeader">
                <p class="publicDataTitle">学院日志</p>
                <label for="actionFilter" class="chooseLabel">操作行为:</label>
                <select id="actionFilter" name="action" class="form-control chooseSelect">
                    <option value="">全部</option>
                    <option value="登录" <c:if test="${page.selectParam[0]=='登录'}">selected</c:if>>登录</option>
                    <option value="新增" <c:if test="${page.selectParam[0]=='新增'}">selected</c:if>>新增</option>
                    <option value="删除" <c:if test="${page.selectParam[0]=='删除'}">selected</c:if>>删除</option>
                    <option value="更新" <c:if test="${page.selectParam[0]=='更新'}">selected</c:if>>更新</option>
                    <option value="恢复" <c:if test="${page.selectParam[0]=='恢复'}">selected</c:if>>恢复</option>
                    <option value="逻辑删除" <c:if test="${page.selectParam[0]=='逻辑删除'}">selected</c:if>>逻辑删除</option>
                </select>
                <label for="operatedTypeFilter" class="chooseLabel">操作对象:</label>
                <select id="operatedTypeFilter" name="operatedType" class="form-control chooseSelect">
                    <option value="">全部</option>
                    <option value="文件" <c:if test="${page.selectParam[1]=='文件'}">selected</c:if>>文件</option>
                    <option value="用户" <c:if test="${page.selectParam[1]=='用户'}">selected</c:if>>用户</option>
                    <option value="院系" <c:if test="${page.selectParam[1]=='院系'}">selected</c:if>>院系</option>
                    <option value="公告" <c:if test="${page.selectParam[1]=='公告'}">selected</c:if>>公告</option>
                    <option value="文件类型" <c:if test="${page.selectParam[1]=='文件类型'}">selected</c:if>>文件类型</option>
                    <option value="类目属性" <c:if test="${page.selectParam[1]=='类目属性'}">selected</c:if>>类目属性</option>
                    <option value="类目属性内容" <c:if test="${page.selectParam[1]=='类目属性内容'}">selected</c:if>>类目属性内容</option>
                </select>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>日志内容</th>
                        <th>操作行为</th>
                        <th>时间</th>
                        <th>操作者</th>
                        <th>被操作对象</th>
                        <th>描述</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${logHelpClassList}" var="logHelp" varStatus="logHelpStatus">
                        <tr id="${logHelp.log.id}">
                            <td>1</td>
                            <td title="${logHelp.log.content}" style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.content}</td>
                            <td>${logHelp.log.action}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${logHelp.log.time}"/></td>
                            <td>${logHelp.operationUserInfo.name}</td>
                            <td>${logHelp.operatedType}</td>
                            <td title="${logHelp.log.description}" style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.description}</td>
                            <td style="width: 140px;  text-align: center;">
                                <button class="btn btn-info btn-sm" type="button" onclick="checkLogBtn('${logHelp.log.id}')"><i class="icon-search"></i> 查看详情</button>
                                <c:if test="${logHelp.log.action == '逻辑删除'}">
                                    <c:choose>
                                        <c:when test="${logHelp.operatedData.flag==1}">
                                            <button class="btn btn-primary btn-sm recoverLogBtn" type="button" onclick="recover('${logHelp.operatedData.id}')"><i class="icon-wrench"></i> 恢复</button>
                                        </c:when>
                                        <c:otherwise>
                                            已被恢复
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </td>
                            <td style="display: none">${logHelp.operationUserRole.role.name}</td>
                            <td style="display: none">
                                    ${logHelp.operationUserInfo.phone}<c:if test="${logHelp.operationUserInfo.phone==null}">暂无</c:if>
                            </td>
                            <td style="display: none">
                                    ${logHelp.operationUserInfo.email}<c:if test="${logHelp.operationUserInfo.email==null}">暂无</c:if>
                            </td>
                            <c:if test="${logHelp.operatedType == '用户'}">
                                <td style="display: none">
                                    <span>${logHelp.operatedUserInfo.name}<c:if test="${logHelp.operatedUserInfo.name==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedUserRole.role.name}<c:if test="${logHelp.operatedUserRole.role.name==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedUserInfo.phone}<c:if test="${logHelp.operatedUserInfo.phone==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedUserInfo.email}<c:if test="${logHelp.operatedUserInfo.email==null}">暂无</c:if></span>
                                </td>
                            </c:if>
                            <c:if test="${logHelp.operatedType == '文件'}">
                                <td style="display:none;">
                                    <span>${logHelp.operatedData.fileName}<c:if test="${logHelp.operatedData.fileName==null}">已被删除</c:if></span>
                                    <span>${logHelp.operatedData.dataClass.name}<c:if test="${logHelp.operatedData.dataClass.name==null}">已被删除</c:if></span>
                                    <span>${logHelp.operatedDataUserInfo.name}<c:if test="${logHelp.operatedDataUserInfo.name==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedDataUserRole.role.name}<c:if test="${logHelp.operatedDataUserRole.role.name==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedDataUserInfo.phone}<c:if test="${logHelp.operatedDataUserInfo.phone==null}">暂无</c:if></span>
                                    <span>${logHelp.operatedDataUserInfo.email}<c:if test="${logHelp.operatedDataUserInfo.email==null}">暂无</c:if></span>
                                </td>
                            </c:if>
                            <c:if test="${logHelp.operatedType == '院系'}">
                                <td style="display:none">
                                    <span>${logHelp.operatedDepartment.code}</span>
                                    <span>${logHelp.operatedDepartment.name}</span>
                                </td>
                            </c:if>
                            <c:if test="${logHelp.operatedType == '文件类型'}">
                                <td style="display:none">
                                    <span>${logHelp.operatedDataClass.name}</span>
                                    <span>${logHelp.operatedDataClass.department.name}</span>
                                    <span>${logHelp.operatedDataClass.role.name}</span>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                 </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </div>
       </form>
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
    <script>

        $("#actionFilter,#operatedTypeFilter").change(function () {
            $("#currentPageInput").val("1");
            $("#pageForm").submit();
        });

        // 查看详情
        function checkLogBtn(logId) {
            var tr = $('#'+logId+'');
            $('#content').text(tr.children('td').eq(1).text());
            $('#description').text(tr.children('td').eq(6).text());
            $('#handlerName').text(tr.children('td').eq(4).text());
            $('#handlerJob').text(tr.children('td').eq(8).text());
            $('#handlerPhone').text(tr.children('td').eq(9).text());
            $('#handlerEmail').text(tr.children('td').eq(10).text());
            var operatedType = tr.children('td').eq(5).text();
            $('#operatedType').text(operatedType);
            var ul = $("#handler2").children('ul').eq(0);
            ul.html("");
            var td = tr.children('td').eq(11);
            if (operatedType=='用户'){
                ul.append("<li>姓名:"+td.children('span').eq(0).text()+"</li>");
                ul.append("<li>职务:"+td.children('span').eq(1).text()+"</li>");
                ul.append("<li>电话:"+td.children('span').eq(2).text()+"</li>");
                ul.append("<li>邮箱:"+td.children('span').eq(3).text()+"</li>")
            }else if (operatedType=='文件'){
                ul.append("<li>文件名:"+td.children('span').eq(0).text()+"</li>");
                ul.append("<li>文件类型:"+td.children('span').eq(1).text()+"</li>");
                ul.append("<p style='font-weight: bold'>上传者:</p>");
                ul.append("<li>姓名:"+td.children('span').eq(2).text()+"</li>");
                ul.append("<li>职务:"+td.children('span').eq(3).text()+"</li>");
                ul.append("<li>电话:"+td.children('span').eq(4).text()+"</li>");
                ul.append("<li>邮箱:"+td.children('span').eq(5).text()+"</li>")
            }else if (operatedType=='院系'){
                ul.append("<li>院系编码:"+td.children('span').eq(0).text()+"</li>");
                ul.append("<li>院系名称:"+td.children('span').eq(1).text()+"</li>")
            }else if (operatedType=='文件类型'){
                ul.append("<li>类型名称:"+td.children('span').eq(0).text()+"</li>");
                ul.append("<li>所属院系:"+td.children('span').eq(1).text()+"</li>");
                ul.append("<li>所属角色:"+td.children('span').eq(2).text()+"</li>")
            }
            $("#myModal").modal();
        }

        // 恢复文件
        function recover(dataId) {
            $.confirm({
                title: '提示',
                content: '确认恢复本条数据?',
                buttons: {
                    取消:function () {
                    },
                    确定: function () {
                        $.ajax({
                            url:"${ctx}/admin/recoverData?dataId="+dataId,
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
                    }
                }
            })
        }
    </script>
</body>
</html>
