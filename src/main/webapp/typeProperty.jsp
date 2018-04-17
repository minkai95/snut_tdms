<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>类目属性</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">类目属性</p>
            <div class="teacherUpload">
                <p class="uploadTitle">已有类目属性列表</p>
                <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign" style="margin-right: 5px;"></i>新增类目属性</button>
            </div>
        </div>
        <div class="typePropertyContent">
            <div id="type001" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                专业
            </div>
            <div id="type002" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                班级
            </div>
            <div id="type003" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                科室科室科室科室科室科室
            </div>
            <div id="type004" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                部门
            </div>
            <div id="type005" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                科室科室科室科室科室科室
            </div>
            <div id="type006" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                部门
            </div>
            <div id="type007" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                科室科室科室
            </div>
            <div id="type008" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                部门
            </div>
            <div id="type009" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                科室科室科室科室
            </div>
            <div id="type010" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                部门
            </div>
            <div id="type011" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                科室科室科
            </div>
            <div id="type012" class="propertyWrapper">
                <i class="icon-remove-sign iconPosition"></i>
                部门
            </div>
        </div>
    </div>

    <!-- 添加类目Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabe">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增类目属性</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="typePropertyName">属性名称:</label>
                        <input id="typePropertyName" class="form-control" type="text">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="resetBtn" class="btn btn-default">重置</button>
                    <button type="button" class="btn btn-info">发布</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(".iconPosition").click(function() {
            $(this).each(function(){
                var typeId = $(this).parent("div").attr("id");
                var typeText = $("#" + typeId).text();
                $.confirm({
                    title: '提示',
                    content: '确认删除' + typeText + '类目属性？',
                    buttons: {
                        确定: function(){

                        },
                        取消: function() {

                        }
                    }
                });
            })
        });

        $(".propertyWrapper:nth-child(4n-3)").css("backgroundColor","#5cb85c");
        $(".propertyWrapper:nth-child(4n-2)").css("backgroundColor","#5bc0de");
        $(".propertyWrapper:nth-child(4n-1)").css("backgroundColor","#f0ad4e");
        $(".propertyWrapper:nth-child(4n)").css("backgroundColor","#d9534f");

        $("#resetBtn").click(function() {
            $("#typePropertyName").val('');
        });
    </script>
</body>
</html>
