<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>学院日志</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherCurrentWrapper">
            <div class="teacherHeader">
                <p class="publicDataTitle">学院日志</p>
            </div>
            <div class="teacherPublicDataList">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>#</th>
                        <th>日志内容</th>
                        <th>操作行为</th>
                        <th>时间</th>
                        <th>操作者</th>
                        <th>操作对象</th>
                        <th>描述</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">新增体育学院</td>
                        <td>新增</td>
                        <td>2017-01-01</td>
                        <td>superAdmin</td>
                        <td>  </td>
                        <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">新增学院，体育学院</td>
                        <td style="width: 250px;  text-align: center;">
                            <button class="btn btn-info btn-sm checkLogBtn"><i class="icon-search"></i>查看</button>
                            <button class="btn btn-primary btn-sm recoverLogBtn"><i class="icon-wrench"></i>恢复</button>
                        </td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">新增体育学院</td>
                        <td>新增</td>
                        <td>2017-01-01</td>
                        <td>superAdmin</td>
                        <td>  </td>
                        <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">新增学院，体育学院>新增学院，体育学院>新增学院，体育学院>新增学院，体育学院>新增学院，体育学院</td>
                        <td style="width: 250px;  text-align: center;">
                            <button class="btn btn-info btn-sm checkLogBtn"><i class="icon-search"></i>查看</button>
                            <button class="btn btn-primary btn-sm recoverLogBtn"><i class="icon-wrench"></i>恢复</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
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
                        <label for="name">日志内容</label>
                        <div id="name">请按时上传期末试卷</div>
                    </div>
                    <div class="form-group">
                        <label for="content">描述</label>
                        <div id="content">请按时上传期末试卷请按时上传期末试卷请按时上传期末试卷请按时上传期末试卷请按时上传期末试卷请按时上传期末试卷请按时上传期末试卷</div>
                    </div>
                    <div class="form-group">
                        <label for="handler">操作者</label>
                        <div id="handler">
                            <ul>
                                <li>姓名:<span id="handlerName">大壮</span></li>
                                <li>职务:<span id="handlerJob">学办教师</span></li>
                                <li>电话:<span id="handlerPhone">15050505500</span></li>
                                <li>邮箱:<span id="handlerEmail">136@163.com</span></li>
                            </ul>
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
        $(".checkLogBtn").on("click", function(){
            $("#myModal").modal();
        });

        $(".recoverLogBtn").click(function(){
            $.confirm({
                title: '提示',
                content: '确认删除该条日志？',
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
