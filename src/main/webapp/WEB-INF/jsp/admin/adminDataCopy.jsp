<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>数据备份</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">数据备份</p>
            <div class="teacherUpload">
                <p class="uploadTitle">已有数据备份列表</p>
                <button class="btn btn-info upload batchDelete" data-toggle="modal" data-target="#myModal2"><i class="icon-save" style="margin-right: 5px;"></i>手动备份</button>
                <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-cogs" style="margin-right: 5px;"></i>自动备份</button>
                <p class="upload batchDelete saveTitle">当前备份时间：每天23:59:00</p>
            </div>
        </div>
        <div class="teacherPublicDataList">
            <table class="table table-bordered table-striped">
                <tr>
                    <th>#</th>
                    <th>备份状态</th>
                    <th>备份类型</th>
                    <th>操作者</th>
                    <th>时间</th>
                    <th style="text-align: center">操作</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">success</td>
                    <td>未知</td>
                    <td>admin</td>
                    <td>2017-01-01</td>
                    <td style="width: 150px;  text-align: center;">
                        <button class="btn btn-primary btn-sm recoverLogBtn"><i class="icon-wrench"></i>恢复</button>
                    </td>
                </tr>
                <tr>
                    <td>1</td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">失败</td>
                    <td>备份</td>
                    <td>系统</td>
                    <td>2017-01-01</td>
                    <td style="width: 150px;  text-align: center;">
                        <button class="btn btn-primary btn-sm recoverLogBtn"><i class="icon-wrench"></i>恢复</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 自动备份Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" id="closeDate">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">自动备份时间设置</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="saveOften">备份频率:</label>
                        <select id="saveOften" class="form-control">
                            <option value="每天">每天</option>
                            <option value="每天">三天</option>
                            <option value="每天">一周</option>
                            <option value="每天">每月</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for=dateChoose>备份时间:</label>
                        <span id="dateChoose" class="form-control"></span>
                        <div id="dateWrapper" class="dateWrapper">
                            <p class="tittle">请选择时间</p>
                            <div class="dateTittleCont">
                                <div class="hourTittle">小时</div>
                                <div class="minuteTittle">分钟</div>
                            </div>
                            <div class="dateCont">
                                <div class="hourCont">
                                    <ul id="dateHourList">
                                    </ul>
                                </div>
                                <div class="minuteCont">
                                    <ul id="dateMinuteList">
                                    </ul>
                                </div>
                            </div>
                            <div class="dateSpan">
                                <span id="chooseTime" class="chooseTime"></span>
                                <button id="resetTimeBtn" class="resetTimeBtn">清除</button>
                                <button id="confirmTimeBtn" class="confirmTimeBtn">确定</button>
                            </div>
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
        /*循环输出li*/
        var liHourText = 0;
        for(var i = 0; i < 24; i++){
            $("#dateHourList").append("<li></li>");

        }
        $("#dateHourList li").each(function(){
            if(liHourText < 10){
                $(this).text("0" + liHourText++);
            }else{
                $(this).text(liHourText++);
            }
        });
        var liMinuteText = 0;
        for(var j = 0; j < 60; j++){
            $("#dateMinuteList").append("<li></li>");

        }
        $("#dateMinuteList li").each(function(){
            if(liMinuteText < 10){
                $(this).text("0" + liMinuteText++);
            }else{
                $(this).text(liMinuteText++);
            }
        });


        var spanDateHour = "00";
        var spanDateMinute = "00";
        /*选中li居中并加样式*/
        $("#dateHourList li").click(function(){
            var hourLiIndex = $("#dateHourList li").index($(this));
            if(hourLiIndex <= "3"){
                $(this).addClass("liAddClass");
                $(this).siblings().removeClass("liAddClass");
            } else{
                $(this).addClass("liAddClass");
                $(this).siblings().removeClass("liAddClass");
                $(this).parents(".hourCont").scrollTop("25" * (hourLiIndex-3));
            }

            spanDateHour = $(this).text();
            $("#chooseTime").text(spanDateHour + ":" + spanDateMinute);

        });
        $("#dateMinuteList li").click(function(){
            var minuteLiIndex = $("#dateMinuteList li").index($(this));
            if(minuteLiIndex <= "3"){
                $(this).addClass("liAddClass");
                $(this).siblings().removeClass("liAddClass");

            } else{
                $(this).addClass("liAddClass");
                $(this).siblings().removeClass("liAddClass");
                $(this).parents(".minuteCont").scrollTop("25" * (minuteLiIndex-3));
            }

            spanDateMinute = $(this).text();
            $("#chooseTime").text(spanDateHour + ":" + spanDateMinute);
        });
        /*点击span让时间选择器出现*/
        $("#dateChoose").click(function(){
            $("#dateWrapper").slideToggle();

        });
        /*点击清除按钮*/
        $("#resetTimeBtn").click(function(){
            $("#dateWrapper").slideUp();
            $("#dateHourList li").removeClass("liAddClass");
            $(".hourCont").scrollTop("0");
            $("#dateMinuteList li").removeClass("liAddClass");
            $(".minuteCont").scrollTop("0");
            $("#chooseTime").text("");
            $("#dateChoose").text("");
        });
        /*点击确定按钮*/
        $("#confirmTimeBtn").click(function(){
            if($("#chooseTime").text() == "" || $("#chooseTime").text() == null){
                alert("时间不能为空！");
            }else{
                $("#dateChoose").text($("#chooseTime").text() + ":00");
                $("#dateWrapper").slideUp();
            }
        });

        $("#closeDate").click(function(){
            $("#dateWrapper").slideUp();
        });
        $(".fade").mousedown(function(event){
            event.stopPropagation();
            $("#dateWrapper").slideUp();
        });
    </script>
</body>
</html>
