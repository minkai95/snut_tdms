<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>类目管理——学办</title>
</head>
<body>
<div class="adminCurrentWrapper">
    <div class="teacherHeader">
        <p class="publicDataTitle">类目属性——学办</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已有类目属性列表</p>
            <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign" style="margin-right: 5px;"></i>新增类目</button>
        </div>
    </div>
    <div class="typePropertyContent">
        <div id="type001" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            检讨
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type002" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            材料证明
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type003" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            获奖证书
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type004" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷试试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type006" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type007" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷试试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type008" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type009" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷试试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
        <div id="type010" class="typeWrapper">
            <i class="icon-angle-down dropDown"></i>
            试卷
            <div class="propertyNameCont">
                <ul>
                    <li>属性1：专业专业专业</li>
                    <li>属性2：班级</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 添加类目Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabe">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增类目</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="typePropertyName">类目名称:</label>
                    <input id="typePropertyName" class="form-control" type="text">
                </div>
                <div class="form-group">
                    <label>类目属性:</label>
                    <button id="addProperty" class="btn btn-success btn-sm" style="margin-left: -30px;">添加属性</button>
                    <button id="removeProperty" class="btn btn-warning btn-sm">删除属性</button>
                    <div id="selectProperty" class="form-group">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="resetBtn" class="btn btn-default">取消</button>
                <button type="button" class="btn btn-info">确定</button>
            </div>
        </div>
    </div>
</div>

<script>
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

    $(".typeWrapper:nth-child(4n-3)").css("backgroundColor","#5cb85c");
    $(".typeWrapper:nth-child(4n-3)").children("div").css("border","1px solid #5cb85c");
    $(".typeWrapper:nth-child(4n-2)").css("backgroundColor","#5bc0de");
    $(".typeWrapper:nth-child(4n-2)").children("div").css("border","1px solid #5bc0de");
    $(".typeWrapper:nth-child(4n-1)").css("backgroundColor","#f0ad4e");
    $(".typeWrapper:nth-child(4n-1)").children("div").css("border","1px solid #f0ad4e");
    $(".typeWrapper:nth-child(4n)").css("backgroundColor","#d9534f");
    $(".typeWrapper:nth-child(4n)").children("div").css("border","1px solid #d9534f");

    $("#addProperty").click(function(){
        var propertyLength = $("#selectProperty").find("select").length;
        console.log(propertyLength);
        if(propertyLength < "3"){
            $("#selectProperty").append("<div class='selectPropertyWrapper'><label class='propertyLabel'></label><select class='form-control'><option value='专业'>专业</option><option value='班级'>班级</option></select></div>");
            $("#selectProperty select").attr("id",function(i) {
                return "property_" + ++i;
            });
            $("#selectProperty label").attr("for",function(i) {
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
    });
    $("#removeProperty").click(function(){
        $("#selectProperty label").last().remove();
        $("#selectProperty select").last().remove();
    });
</script>
</body>
</html>
