<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>院系管理员管理</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">院系管理员管理</p>
                <div class="teacherUpload">
                    <p class="uploadTitle">院系管理员列表</p>
                    <a href="#" class="upload" data-toggle="modal" data-target="#myModal"><i class="icon-plus-sign"></i>新增管理员</a>
                </div>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>所属院系</th>
                        <th>联系方式</th>
                        <th>E-mail</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>000001</td>
                        <td>教师1</td>
                        <td>男</td>
                        <td>管理学院</td>
                        <td>12345678901</td>
                        <td>123456@163.com</td>
                        <td style="width: 250px;  text-align: center;">
                            <button class="btn btn-primary btn-sm" id="modification"><i class="icon-pencil"></i>修改</button>
                            <button id="deleteDepartmentAdmin" class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>000002</td>
                        <td>教师2</td>
                        <td>男</td>
                        <td>数计学院</td>
                        <td>12345678901</td>
                        <td>123456@163.com</td>
                        <td style="width: 250px;  text-align: center;">
                            <button class="btn btn-primary btn-sm"><i class="icon-pencil"></i>修改</button>
                            <button class="btn btn-danger btn-sm"><i class="icon-remove-circle"></i>删除</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- 新增管理员Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增管理员</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="departmentAdminId" style="letter-spacing: 8px;">用户名:</label>
                        <input type="text" id="departmentAdminId" class="form-control applyDataName" name="departmentAdminId">
                    </div>
                    <div class="form-group">
                        <label for="departmentName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="departmentName" class="form-control applyDataName" name="departmentName">
                    </div>
                    <div class="form-group">
                        <label for="departmentAdminSex" style="letter-spacing: 19px;">性别:</label>
                        <select name="departmentAdminSex" id="departmentAdminSex" class="form-control applyDataName">
                            <option value="man">男</option>
                            <option value="woman">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="departmentLocation" style="letter-spacing: 2.5px;">所属院系:</label>
                        <select name="departmentLocation" id="departmentLocation" class="form-control applyDataName">
                            <option value="glxy">管理学院</option>
                            <option value="sjxy">数计学院</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="departmentAdminPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="departmentAdminPhone" class="form-control applyDataName" name="departmentAdminPhone">
                    </div>
                    <div class="form-group">
                        <label for="departmentAdminEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="departmentAdminEmail" class="form-control applyDataName" name="departmentAdminEmail">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改管路员信息Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改管理员信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="amendDepartmentAdminId" style="letter-spacing: 8px;">用户名:</label>
                        <span id="amendDepartmentAdminId" class="form-control applyDataName">00001</span>
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentName" style="letter-spacing: 19px;">姓名:</label>
                        <input type="text" id="amendDepartmentName" class="form-control applyDataName" value="教师1">
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentAdminSex" style="letter-spacing: 19px;">性别:</label>
                        <select name="departmentAdminSex" id="amendDepartmentAdminSex" class="form-control applyDataName">
                            <option value="man">男</option>
                            <option value="woman">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentLocation" style="letter-spacing: 2.5px;">所属院系:</label>
                        <select name="departmentLocation" id="amendDepartmentLocation" class="form-control applyDataName">
                            <option value="glxy">管理学院</option>
                            <option value="sjxy">数计学院</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentAdminPhone" style="letter-spacing: 2.5px;">联系方式:</label>
                        <input type="text" id="amendDepartmentAdminPhone" class="form-control applyDataName" value="12345678901">
                    </div>
                    <div class="form-group">
                        <label for="amendDepartmentAdminEmail" style="letter-spacing: 19px;">邮箱:</label>
                        <input type="text" id="amendDepartmentAdminEmail" class="form-control applyDataName" value="123456@163.com">
                    </div>
                    <div class="form-group">
                        <label for="resetPassword" style="letter-spacing: 2.5px;">重置密码:</label>
                        <div class="switchBtnWrapper switchBtnMove" id="resetPassword">
                            <div class="switchBtnLeft cont"></div>
                            <div class="switchBtnMiddle cont">否</div>
                            <div class="switchBtnRight cont"></div>
                            <div class="switchBtn" id="btn"></div>
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
        $("#modification").on("click", function(){
            $("#myModal2").modal();
        });

        /*按钮js*/
        $("#btn").mousedown(function() {
            if($("#btn").css("left") === "0px"){
                $("#btn").animate({left:'60px'},"2000");
                $(".cont").addClass("addStyle");
                $(".switchBtnMiddle").text("是");
            }else{
                $("#btn").animate({left:'0'},"2000");
                $(".switchBtnWrapper div").removeClass("addStyle");
                $(".switchBtnMiddle").text("否");
            }
        })

        $("#deleteDepartmentAdmin").click(function() {
            $.confirm({
                title: '提示',
                content: '确认删除该管理员？',
                buttons: {
                    确定: function(){

                    },
                    取消: function() {

                    }
                }
            });
        })
    </script>
</body>
</html>
