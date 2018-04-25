<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>全校日志</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <form id="pageForm" action="${ctx}/superAdmin/superAdminLog" method="get">
            <div class="teacherCurrentWrapper">
                <div class="teacherHeader">
                    <p class="publicDataTitle">全校日志管理</p>
                    <label for="departmentFilter" class="chooseLabel" style="margin-left: 0;">院系:</label>
                    <select id="departmentFilter" name="departmentCode" class="chooseSelectStyle">
                        <option value="">全部</option>
                        <c:forEach items="${departmentList}" var="department">
                            <option value="${department.code}" <c:if test="${page.selectParam[0]==department.code}">selected</c:if>>${department.name}</option>
                        </c:forEach>
                    </select>
                    <label for="actionFilter" class="chooseLabel">操作行为:</label>
                    <select id="actionFilter" name="action" class="chooseSelectStyle">
                        <option value="">全部</option>
                        <option value="登录" <c:if test="${page.selectParam[1]=='登录'}">selected</c:if>>登录</option>
                        <option value="新增" <c:if test="${page.selectParam[1]=='新增'}">selected</c:if>>新增</option>
                        <option value="删除" <c:if test="${page.selectParam[1]=='删除'}">selected</c:if>>删除</option>
                        <option value="更新" <c:if test="${page.selectParam[1]=='更新'}">selected</c:if>>更新</option>
                        <option value="恢复" <c:if test="${page.selectParam[1]=='恢复'}">selected</c:if>>恢复</option>
                        <option value="逻辑删除" <c:if test="${page.selectParam[1]=='逻辑删除'}">selected</c:if>>逻辑删除</option>
                    </select>
                    <label for="operatedTypeFilter" class="chooseLabel">操作对象:</label>
                    <select id="operatedTypeFilter" name="operatedType" class="chooseSelectStyle">
                        <option value="">全部</option>
                        <option value="文件" <c:if test="${page.selectParam[2]=='文件'}">selected</c:if>>文件</option>
                        <option value="用户" <c:if test="${page.selectParam[2]=='用户'}">selected</c:if>>用户</option>
                        <option value="院系" <c:if test="${page.selectParam[2]=='院系'}">selected</c:if>>院系</option>
                        <option value="公告" <c:if test="${page.selectParam[2]=='公告'}">selected</c:if>>公告</option>
                        <option value="文件类型" <c:if test="${page.selectParam[2]=='文件类型'}">selected</c:if>>文件类型</option>
                        <option value="类目属性" <c:if test="${page.selectParam[2]=='类目属性'}">selected</c:if>>类目属性</option>
                        <option value="类目属性内容" <c:if test="${page.selectParam[2]=='类目属性内容'}">selected</c:if>>类目属性内容</option>
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
                                <td>${logHelpStatus.index+1+(page.currentPage-1)*10}</td>
                                <td style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.content}</td>
                                <td>${logHelp.log.action}</td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${logHelp.log.time}"/></td>
                                <td>${logHelp.operationUserInfo.name}</td>
                                <td>${logHelp.operatedType}</td>
                                <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${logHelp.log.description}</td>
                                <td style="width: 250px;  text-align: center;">
                                    <button class="btn btn-info btn-sm" type="button" onclick="checkLogBtn('${logHelp.log.id}')"><i class="icon-search"></i>查看详情</button>
                                    <c:if test="${logHelp.log.action == '逻辑删除'}">
                                        <c:choose>
                                            <c:when test="${logHelp.operatedData.flag==1}">
                                                <button class="btn btn-info btn-sm" onclick="recover('${logHelp.operatedData.id}')"><i class="icon-search"></i>恢复</button>
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
                                        <span>${logHelp.log.operatedId}<c:if test="${logHelp.log.operatedId==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedUserInfo.name}<c:if test="${logHelp.operatedUserInfo.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedUserRole.role.name}<c:if test="${logHelp.operatedUserRole.role.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedUserInfo.phone}<c:if test="${logHelp.operatedUserInfo.phone==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedUserInfo.email}<c:if test="${logHelp.operatedUserInfo.email==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '文件'}">
                                    <td style="display:none;">
                                        <span>${logHelp.operatedData.fileName}<c:if test="${logHelp.operatedData.fileName==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedData.dataClass.name}<c:if test="${logHelp.operatedData.dataClass.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedDataUserInfo.user.username}<c:if test="${logHelp.operatedDataUserInfo.user.username==null}">暂无</c:if></span>
                                        <span>${logHelp.operatedDataUserInfo.name}<c:if test="${logHelp.operatedDataUserInfo.name==null}">暂无</c:if></span>
                                        <span>${logHelp.operatedDataUserRole.role.name}<c:if test="${logHelp.operatedDataUserRole.role.name==null}">暂无</c:if></span>
                                        <span>${logHelp.operatedDataUserInfo.phone}<c:if test="${logHelp.operatedDataUserInfo.phone==null}">暂无</c:if></span>
                                        <span>${logHelp.operatedDataUserInfo.email}<c:if test="${logHelp.operatedDataUserInfo.email==null}">暂无</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '院系'}">
                                    <td style="display:none">
                                        <span>${logHelp.operatedDepartment.code}<c:if test="${logHelp.operatedDepartment.code==null}">${logHelp.log.operatedId}</c:if></span>
                                        <span>${logHelp.operatedDepartment.name}<c:if test="${logHelp.operatedDepartment.name==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '文件类型'}">
                                    <td style="display:none">
                                        <span>${logHelp.operatedDataClass.name}<c:if test="${logHelp.operatedDataClass.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedDataClass.department.name}<c:if test="${logHelp.operatedDataClass.department.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.operatedDataClass.role.name}<c:if test="${logHelp.operatedDataClass.role.name==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '公告'}">
                                    <td style="display:none">
                                        <span>${logHelp.noticeHelpClass.systemNotice.name}<c:if test="${logHelp.noticeHelpClass.systemNotice.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.noticeHelpClass.systemNotice.content}<c:if test="${logHelp.noticeHelpClass.systemNotice.content==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '类目属性'}">
                                    <td style="display:none">
                                        <span>${logHelp.classType.name}<c:if test="${logHelp.classType.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.classType.department.name}<c:if test="${logHelp.classType.department.name==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <c:if test="${logHelp.operatedType == '类目属性内容'}">
                                    <td style="display:none">
                                        <span>${logHelp.typeContent.name}<c:if test="${logHelp.typeContent.name==null}">已被删除</c:if></span>
                                        <span>${logHelp.typeContent.classType.name}<c:if test="${logHelp.typeContent.classType.name==null}">已被删除</c:if></span>
                                    </td>
                                </c:if>
                                <td style="display: none">${logHelp.operationUserInfo.user.username}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
                </div>
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
                        <span id="content" class="spanControl"></span>
                    </div>
                    <div class="form-group">
                        <label for="description">描述</label>
                        <span id="description" class="spanControl"></span>
                    </div>
                    <div class="form-group">
                        <label for="handler">操作者</label>
                        <div id="handler">
                            <table class="table table-bordered">
                                <tbody>
                                <tr>
                                    <th>用户名</th>
                                    <th>姓名</th>
                                    <th>职务</th>
                                    <th>电话</th>
                                    <th>邮箱</th>
                                </tr>
                                <tr>
                                    <td><span id="handlerUsername"></span></td>
                                    <td><span id="handlerName"></span></td>
                                    <td><span id="handlerJob"></span></td>
                                    <td><span id="handlerPhone"></span></td>
                                    <td><span id="handlerEmail"></span></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <label for="handler2">被操作对象:<span id="operatedType"></span></label>
                            <div id="handler2">
                                <%--<ul></ul>--%>
                            </div>
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

        $("#departmentFilter,#actionFilter,#operatedTypeFilter").change(function () {
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
            $('#handlerUsername').text(tr.children('td').eq(12).text());
            var operatedType = tr.children('td').eq(5).text();
            $('#operatedType').text(operatedType);
            var ul = $("#handler2");
            ul.html("");
            var td = tr.children('td').eq(11);
            if (operatedType=='用户'){
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>用户名</th><th>姓名</th><th>职务</th><th>电话</th><th>邮箱</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(0).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td> <td>"+td.children('span').eq(2).text()+"</td><td>"+td.children('span').eq(3).text()+"</td><td>"+td.children('span').eq(4).text()+"</td></tr>");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
            }else if (operatedType=='文件'){
                ul.append("<p><span style='font-weight: bold'>文件名：</span>"+ td.children('span').eq(0).text()+ "</p>");
                ul.append("<p><span style='font-weight: bold'>文件类型：</span>"+ td.children('span').eq(1).text()+ "</p>");
                ul.append("<p style='font-weight: bold'>上传者:</p>");
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>用户名</th><th>姓名</th><th>职务</th><th>电话</th><th>邮箱</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(2).text()+"</td> <td>"+td.children('span').eq(3).text()+"</td> <td>"+td.children('span').eq(4).text()+"</td><td>"+td.children('span').eq(5).text()+"</td><td>"+td.children('span').eq(6).text()+"</td></tr>");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
            }else if (operatedType=='院系'){
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>院系编码</th><th>院系名称</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(0).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td> ");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
            }else if (operatedType=='文件类型'){
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>类型名称</th><th>所属院系</th><th>所属角色</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(0).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td> ");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
            }else if (operatedType=='公告'){
                ul.append("<p><span style='font-weight: bold'>公共标题：</span>"+ td.children('span').eq(0).text()+ "</p>");
                ul.append("<p><span style='font-weight: bold'>公共内容：</span></p>");
                ul.append("<span class='spanControl'>"+ td.children('span').eq(1).text() +"</span>");
            }else if (operatedType=='类目属性'){
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>属性名称</th><th>所属院系</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(0).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td>");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
            }else if (operatedType=='类目属性内容'){
                ul.append("<table id='handlerTable' class='table table-bordered'></table>");
                var handlerTable = $("#handlerTable");
                handlerTable.append("<tr><th>属性内容名称</th><th>所属类目属性</th></tr>");
                handlerTable.append("<tr><td>"+ td.children('span').eq(0).text()+"</td> <td>"+td.children('span').eq(1).text()+"</td>");
                handlerTable.children("tr").children("th").each(function(){
                    $(this).addClass("tableThStyle");
                });
                handlerTable.children("tr").children("td").each(function(){
                    $(this).addClass("tableThStyle");
                });
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
                            url:"${ctx}/superAdmin/recoverData?dataId="+dataId,
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
