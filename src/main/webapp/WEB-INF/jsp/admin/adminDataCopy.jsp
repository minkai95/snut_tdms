<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>数据备份</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <form id="pageForm" action="${ctx}/admin/adminDataCopy" method="get">
            <div class="teacherHeader">
                <p class="publicDataTitle">数据备份</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">已有数据备份列表</p>
                    <button id="manualBackup" type="button" class="btn btn-info upload batchDelete"><i class="icon-save" style="margin-right: 5px;"></i>手动备份</button>
                    <p class="batchDelete saveTitle">自动备份时间：每天23:59</p>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>备份状态</th>
                        <th>备份类型</th>
                        <th>时间</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <c:forEach items="${backupList}" var="backup" varStatus="backupStatus">
                        <tr id="${backup.id}">
                            <td>${backupStatus.index+1+(page.currentPage-1)*10}</td>
                            <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                <c:choose>
                                    <c:when test="${backup.flag==0}">
                                        备份成功
                                    </c:when>
                                    <c:otherwise>
                                        已被覆盖
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${backup.type}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${backup.time}"/></td>
                            <td style="width: 150px;  text-align: center;">
                                <c:choose>
                                    <c:when test="${backup.flag==0}">
                                        <button onclick="recover('${backup.id}')" type="button" class="btn btn-primary btn-sm recoverLogBtn"><i class="icon-wrench"></i> 恢复</button>
                                    </c:when>
                                    <c:otherwise>
                                        已被覆盖
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
            </div>
        </form>
    </div>

    <script>

        function recover(id) {
            var tr = $('#'+id+'');
            var type = tr.children('td').eq(2).text();
            var time = tr.children('td').eq(3).text();
            $.confirm({
                title: '提示',
                content: '您确定恢复本院文件数据到'+time+'吗？<br><br>该操作不会删除已新增文件。',
                buttons: {
                    取消: function () {
                    },
                    确定: function () {
                        $.ajax({
                            url:encodeURI("${ctx}/admin/recoverBackupsDataBase?backupsType="+type+"&id="+id),
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
                                });
                            }
                        })
                    }
                }
            })
        }

        $('#manualBackup').click(function () {
            $.ajax({
                url:encodeURI("${ctx}/admin/backupsData?backupsType=手动备份"),
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
                    });
                }
            })
        });
    </script>
</body>
</html>
