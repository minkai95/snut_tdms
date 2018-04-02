<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>资料追踪</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <p class="publicDataTitle">资料追踪</p>
        <div class="mainCont">
            <table class="table table-bordered table-striped">
                <tr>
                    <th>#</th>
                    <th>内容</th>
                    <th>动作</th>
                    <th>时间</th>
                    <th>操作者</th>
                    <th>描述</th>
                    <th style="text-align: center;">操作</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">教务处删除文件</td>
                    <td>删除</td>
                    <td>2018-05-31&emsp;23:11:02</td>
                    <td>大壮</td>
                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">数学试卷由于内容不符合学校要求，被删除数学试卷由于内容不符合学校要求，被删除数学试卷由于内容不符合学校要求，被删除数学试卷由于内容不符合学校要求，被删除</td>
                    <td style="width: 140px; text-align: center;">
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">
                            <i class="icon-search"></i>查看详情
                        </button>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">详细信息</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">标题</label>
                            <div id="name">请按时上传期末试卷</div>
                        </div>
                        <div class="form-group">
                            <label for="content">内容</label>
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
    </div>
</body>
</html>
