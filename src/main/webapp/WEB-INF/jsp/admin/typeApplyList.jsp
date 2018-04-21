<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>申请列表</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">申请列表</p>
        <div class="teacherUpload">
            <p class="uploadTitle">类目申请列表</p>
        </div>
    </div>
    <div class="teacherPublicDataList">
        <form id="pageForm" action="${ctx}/admin/typeApplyList" method="get">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center">#</th>
                    <th>类目名称</th>
                    <th>所属角色</th>
                    <th>申请人</th>
                    <th>属性1</th>
                    <th>属性2</th>
                    <th>属性3</th>
                    <th style="text-align: center">操作</th>
                </tr>
                <c:forEach items="${dataClassHelpList}" var="dataClassHelp" varStatus="dataClassStatus">
                    <tr id="${dataClassHelp.dataClass.id}">
                        <td style="text-align: center">1</td>
                        <td>${dataClassHelp.dataClass.name}</td>
                        <td>${dataClassHelp.userRole.role.name}</td>
                        <td>${dataClassHelp.userInfo.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${dataClassHelp.classTypeList.size()>0 && dataClassHelp.classTypeList.get(0)!=null && dataClassHelp.classTypeList.get(0)!=''}">
                                    ${dataClassHelp.classTypeList.get(0).name}
                                </c:when>
                                <c:otherwise>
                                    暂无属性
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${dataClassHelp.classTypeList.size()>1 && dataClassHelp.classTypeList.get(1)!=null && dataClassHelp.classTypeList.get(1)!=''}">
                                    ${dataClassHelp.classTypeList.get(1).name}
                                </c:when>
                                <c:otherwise>
                                    暂无属性
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${dataClassHelp.classTypeList.size()>2 && dataClassHelp.classTypeList.get(2)!=null && dataClassHelp.classTypeList.get(2)!=''}">
                                    ${dataClassHelp.classTypeList.get(2).name}
                                </c:when>
                                <c:otherwise>
                                    暂无属性
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="width: 250px;  text-align: center;">
                            <c:choose>
                                <c:when test="${dataClassHelp.dataClass.flag==0}">
                                    <button type="button" class="btn btn-info btn-sm" onclick="handleDataClass('${dataClassHelp.dataClass.id}',1)"><i class="icon-pencil"> 同意</i></button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="handleDataClass('${dataClassHelp.dataClass.id}',3)"><i class="icon-remove-circle"></i> 驳回</button>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${dataClassHelp.dataClass.flag==1}">
                                            <button type="button" class="btn btn-info btn-sm" disabled><i class="icon-pencil"> 已同意</i></button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-info btn-sm" disabled><i class="icon-pencil"> 已驳回</i></button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <%@ include file="/WEB-INF/jsp/include/dataPage.jsp" %>
        </form>
    </div>
</div>

<script>
    // 同意/拒绝
    function handleDataClass(dataClassId,flag) {
        if (flag==3){
            $.confirm({
                title: '提示',
                content: '您确认驳回吗？<input style="margin-top:5px;" class="form-control" type="text" id="deleteReason" placeholder="请输入驳回原因(选填)"/>',
                buttons: {
                    确认: function () {
                        var description = $('#deleteReason').val();
                        $.ajax({
                            url:"${ctx}/admin/updateDataClass?flag="+flag+"&dataClassId="+dataClassId+"&description="+description,
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
                    },
                    关闭: function () {
                        $('#myModal').modal("hide");
                    }
                }
            })
        }else {
            $.ajax({
                url:"${ctx}/admin/updateDataClass?flag="+flag+"&dataClassId="+dataClassId,
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
</script>
</body>
</html>
