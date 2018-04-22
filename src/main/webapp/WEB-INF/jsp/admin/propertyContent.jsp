<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>属性内容</title>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理</title>
</head>
<body>
<div class="teacherCurrentWrapper">
    <div class="teacherCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">属性内容管理</p>
            <div class="teacherUpload">
                <p class="uploadTitle">已有属性内容列表</p>
                <label for="chooseSelect" class="chooseLabel">属性名称:</label>
                <select id="chooseSelect" class="form-control chooseSelect">
                    <option value="全部">全部</option>
                    <option value="试卷">班级</option>
                    <option value="实验报告">专业</option>
                </select>
                <button id="openModel" class="btn btn-success upload batchDelete" onclick="openMyModal()"><i class="icon-upload" style="margin-right: 5px;"></i>新增属性内容</button>
                <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
            </div>
        </div>
        <div class="teacherPublicDataList">
            <form id="pageForm" action="<%--${ctx}/superAdmin/departmentManage--%>" method="get">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th style="text-align: center; width: 5%;"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                        <th>属性名称</th>
                        <th>属性内容</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <tr id="">
                        <td style="text-align: center; width: 5%;"><input class="checkBtn checkedBtn" type="checkbox">1</td>
                        <td>班级</td>
                        <td>1401</td>
                        <td style="width: 250px;  text-align: center;">
                            <button type="button" class="btn btn-primary btn-sm" onclick="openMyModal2()"><i class="icon-pencil"></i>修改</button>
                            <button type="button"  class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<!-- 新增院系Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增属性内容</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="propertyName">属性名称:</label>
                    <select id="propertyName" class="form-control applyDataName">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="propertyCont">属性内容:</label>
                    <input type="text" id="propertyCont" class="form-control applyDataName">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<!-- 属性内容Modal -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改属性内容</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="amendPropertyName">属性名称:</label>
                    <span id="amendPropertyName" class="form-control applyDataName">班级</span>
                </div>
                <div class="form-group">
                    <label for="amendPropertyCont">属性内容:</label>
                    <input type="text" id="amendPropertyCont" class="form-control applyDataName" value="1401">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button onclick="updateDepartment()" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<script>
    /*打开新增Modal*/
    function openMyModal(){
        $("#myModal").modal();
    }

    /*打开修改Modal*/
    function openMyModal2(){
        $("#myModal2").modal();
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
        console.log(checkedTrId);
    });
</script>
</body>
</html>

</body>
</html>
