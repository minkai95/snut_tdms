<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">用户管理</p>
            <div class="teacherUpload">
                <p class="uploadTitle">学院用户资料列表</p>
                <button id="batchDelete" class="btn btn-danger batchDelete"><i class="icon-trash" style="margin-right: 5px;"></i>批量删除</button>
                <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal"><i class="icon-upload" style="margin-right: 5px;"></i>新增用户</button>
            </div>
        </div>
        <div class="teacherPublicDataList">
            <table class="table table-bordered table-striped">
                <tr>
                    <th style="text-align: center"><input id="allCheckBtn" class="checkBtn" type="checkbox">#</th>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>职务</th>
                    <th>联系方式</th>
                    <th>邮箱</th>
                    <th style="text-align: center">操作</th>
                </tr>
                <tr id="uesr001">
                    <td style="text-align: center"></td>
                    <td>00001</td>
                    <td>杨帆</td>
                    <td>男</td>
                    <td>教师</td>
                    <td>12345678901</td>
                    <td>163@163.com</td>
                    <td style="width: 250px;  text-align: center;">
                        <button class="btn btn-info btn-sm updateUserInfo"><i class="icon-pencil"></i>修改</button>
                        <button class="btn btn-danger btn-sm  deleteUser"><i class="icon-remove-circle"></i>删除</button>
                    </td>
                </tr>
                <tr id="uesr002">
                    <td style="text-align: center"><input class="checkBtn checkedBtn" type="checkbox">2</td>
                    <td>00001</td>
                    <td>杨帆</td>
                    <td>男</td>
                    <td>教师</td>
                    <td>12345678901</td>
                    <td>163@163.com</td>
                    <td style="width: 250px;  text-align: center;">
                        <button class="btn btn-info btn-sm updateUserInfo"><i class="icon-pencil"></i>修改</button>
                        <button class="btn btn-danger btn-sm deleteUser"><i class="icon-remove-circle"></i>删除</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 新增用户Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增用户</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addUserId" style="letter-spacing: 8px;">用户名:</label>
                        <input type="text" id="addUserId" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addUsername" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="addUsername" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addUserSex" style="letter-spacing: 19px;">性别:</label>
                        <select id="addUserSex" class="form-control applyDataName">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addUserJob" style="letter-spacing: 19px;">职务:</label>
                        <select id="addUserJob" class="form-control applyDataName">
                            <option value="教师">教师</option>
                            <option value="学办">学办</option>
                            <option value="教务处">教务处</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addUserPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="addUserPhone" class="form-control applyDataName">
                    </div>
                    <div class="form-group">
                        <label for="addUserEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="addUserEmail" class="form-control applyDataName">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改用户信息Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改管理员信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="updateUserId" style="letter-spacing: 8px;">用户名:</label>
                        <span id="updateUserId" class="form-control applyDataName">00001</span>
                    </div>
                    <div class="form-group">
                        <label for="updateUsername" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="updateUsername" class="form-control applyDataName" value="教师1">
                    </div>
                    <div class="form-group">
                        <label for="updateUserSex" style="letter-spacing: 19px;">性别:</label>
                        <select id="updateUserSex" class="form-control applyDataName">
                            <option value="man">男</option>
                            <option value="woman">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateUserJob" style="letter-spacing: 19px;">职务:</label>
                        <select id="updateUserJob" class="form-control applyDataName">
                            <option value="glxy">管理学院</option>
                            <option value="sjxy">数计学院</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateUserPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="updateUserPhone" class="form-control applyDataName" value="12345678901">
                    </div>
                    <div class="form-group">
                        <label for="updateUserEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="updateUserEmail" class="form-control applyDataName" value="123456@163.com">
                    </div>
                    <div class="form-group">
                        <label for="resetPassword" style="letter-spacing: 2.5px;">重置密码:</label>
                        <div class="switchBtnWrapper switchBtnMove" id="resetPassword">
                            <div class="switchBtnLeft cont" onmousedown="btnMove()"></div>
                            <div class="switchBtnMiddle cont" onmousedown="btnMove()"></div>
                            <div class="switchBtnRight cont" onmousedown="btnMove()"></div>
                            <div class="switchBtn" id="btn" onmousedown="btnMove()"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <script>
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
        });

        /*按钮js*/
        function btnMove() {
            if ($("#btn").css("left") === "0px") {
                $("#btn").animate({left: '29px'}, "fast");
                $(".cont").addClass("addStyle");
            } else {
                $("#btn").animate({left: '0'}, "fast");
                $(".switchBtnWrapper div").removeClass("addStyle");
            }
        }


        /*修改用户信息js*/
        $(".updateUserInfo").on("click", function() {
            $("#myModal2").modal();
        })


        /*弹窗js*/
        $(".deleteUser").click(function() {
            $.confirm({
                title: '提示',
                content: '确认删除该用户？',
                buttons: {
                    确定: function(){

                    },
                    取消: function() {

                    }
                }
            });
        });
    </script>
</body>

</html>
