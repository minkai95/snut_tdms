<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>申请类目</title>
    <style>
        .n-error{top: 5px !important;left: -125px !important;  }
    </style>
</head>
<body>
<div class="adminCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">申请类目</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已有类目属性列表</p>
            <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign" style="margin-right: 5px;"></i>申请新增类目</button>
        </div>
    </div>
    <div class="typePropertyContent">
        <c:forEach items="${haveDataClassList}" var="dataClassHelp">
            <div class="typeWrapper">
                <i class="icon-angle-down dropDown"></i>
                    ${dataClassHelp.dataClass.name}
                <div class="propertyNameCont">
                    <ul>
                        <c:choose>
                            <c:when test="${dataClassHelp.classTypeHelpClassList!=null && dataClassHelp.classTypeHelpClassList.size()!=0 && dataClassHelp.classTypeHelpClassList.get(0)!=null}">
                                <c:forEach items="${dataClassHelp.classTypeHelpClassList}" var="classTypeHelp">
                                    <li>${classTypeHelp.classType.name}</li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li style="text-align: center">暂无属性</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="waitCheckWrapper">
        <p class="uploadTitle">待审核类目属性列表</p>
        <div class="waitCheckCont">
            <c:forEach items="${applyingDataClassList}" var="dataClassHelp">
                <div class="waitCheckTypeWrapper">
                    <i class="icon-angle-down dropDown"></i>
                        ${dataClassHelp.dataClass.name}
                    <div class="waitCheckNameCont">
                        <ul>
                            <c:choose>
                                <c:when test="${dataClassHelp.classTypeHelpClassList!=null && dataClassHelp.classTypeHelpClassList.size()!=0 && dataClassHelp.classTypeHelpClassList.get(0)!=null}">
                                    <c:forEach items="${dataClassHelp.classTypeHelpClassList}" var="classTypeHelp">
                                        <li>${classTypeHelp.classType.name}</li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li style="text-align: center">暂无属性</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- 添加类目Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="applyTypeForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增类目</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="typePropertyName">类目名称:</label>
                        <input id="typePropertyName" class="form-control" type="text"
                               data-rule="required;typePropertyName;"
                               data-rule-typePropertyName="[/^([\u4e00-\u9fa5]){2,12}$/, '请输入2-12位汉字']">
                    </div>
                    <div class="form-group">
                        <label>类目属性:</label>
                        <a id="addProperty" class="btn btn-success btn-sm" href="javascript: void(0);" style="margin-left: 5px;">添加属性</a>
                        <a id="removeProperty" class="btn btn-warning btn-sm" href="javascript: void(0);">删除属性</a>
                        <div id="selectProperty" class="form-group"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-default">取消</button>
                    <button type="submit" class="btn btn-info">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 展开/关闭类目属性菜单
    $(".typeWrapper").click(function(){
        if($(this).children("i").attr("class") == "icon-angle-down dropDown"){
            $(this).children("i").attr("class","icon-angle-up dropDown");
            $(this).children("i").siblings("div").slideDown();
            $(this).siblings().children("div").slideUp();
            $(this).siblings().children("i").attr("class","icon-angle-down dropDown");
        } else{
            $(this).children("i").attr("class","icon-angle-down dropDown");
            $(this).children("i").siblings("div").slideUp();
        }
    });
    $(".waitCheckTypeWrapper").click(function(){
        if($(this).children("i").attr("class") == "icon-angle-down dropDown"){
            $(this).children("i").attr("class","icon-angle-up dropDown");
            $(this).children("i").siblings("div").slideDown();
            $(this).siblings().children("div").slideUp();
            $(this).siblings().children("i").attr("class","icon-angle-down dropDown");
        } else{
            $(this).children("i").attr("class","icon-angle-down dropDown");
            $(this).children("i").siblings("div").slideUp();
        }
    });

    $(".typeWrapper:nth-child(4n-3)").css("backgroundColor","#5cb85c");
    $(".typeWrapper:nth-child(4n-3)").children("div").css("border","1px solid #5cb85c");
    $(".typeWrapper:nth-child(4n-2)").css("backgroundColor","#5bc0de");
    $(".typeWrapper:nth-child(4n-2)").children("div").css("border","1px solid #5bc0de");
    $(".typeWrapper:nth-child(4n-1)").css("backgroundColor","#f0ad4e");
    $(".typeWrapper:nth-child(4n-1)").children("div").css("border","1px solid #f0ad4e");
    $(".typeWrapper:nth-child(4n)").css("backgroundColor","#d9534f");
    $(".typeWrapper:nth-child(4n)").children("div").css("border","1px solid #d9534f");

    $("#addProperty").click(function(){
        $.ajax({
            url:"${ctx}/user/selectClassType",
            type:"GET",
            dataType:"json",
            success: function (result) {
                var sp = $("#selectProperty");
                var propertyLength = sp.find("select").length;
                if(propertyLength < 3){
                    sp.append("<div class='selectPropertyWrapper'>" +
                        "<label class='propertyLabel'></label>" +
                        "<select class='form-control'></select>"+
                        "</div>");
                    for(var m=0; m<result['classTypeList'].length; m++){
                        sp.children('div').eq(propertyLength).children('select').append("<option value='" + result['classTypeList'][m]['id'] + "'>" + result['classTypeList'][m]['name'] + "</option >");
                    }
                    sp.children("select").attr("id",function(i) {
                        return "property_" + ++i;
                    });
                    sp.children("label").attr("for",function(i) {
                        return "property_" + ++i;
                    });
                    $("#selectProperty label").text(function(i) {
                        return "属性" + ++i + "：";
                    });
                } else{
                    $.alert({
                        title: '提示',
                        content: '最多只能添加三个属性！',
                        buttons: {
                            确定: function () {

                            }
                        }
                    })
                }
            }
        })
    });
    $("#removeProperty").click(function(){
        $(".selectPropertyWrapper").last().remove();
    });

    // 提交申请新增类目
    $("#applyTypeForm").on('valid.form', function () {
        var sp = $('#selectProperty');
        var name = $('#typePropertyName').val();
        var spLength = sp.find("select").length;
        var property1Id = null;
        var property2Id = null;
        var property3Id = null;
        if (spLength>0){
            property1Id = sp.find('select').eq(0).val();
            property2Id = sp.find('select').eq(1).val();
            property3Id = sp.find('select').eq(2).val();
        }
        $.ajax({
            url:encodeURI("${ctx}/user/addDataClass?name="+name+"&property1Id="+property1Id+"&property2Id="+property2Id+"&property3Id="+property3Id),
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
