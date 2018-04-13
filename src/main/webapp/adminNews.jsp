<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>消息通告</title>
</head>
<body>
    <div class="adminCurrentWrapper">
        <p class="publicDataTitle">消息公告</p>
        <div class="teacherUpload">
            <p class="uploadTitle">已有消息通告列表</p>
            <button class="btn btn-success upload batchDelete" data-toggle="modal" data-target="#myModal2"><i class="icon-upload" style="margin-right: 5px;"></i>发布通告</button>
        </div>
        <div class="mainCont">
            <table class="table table-bordered table-striped">
                <tr>
                    <th>#</th>
                    <th>标题</th>
                    <th>内容</th>
                    <th>时间</th>
                    <th>职务</th>
                    <th>发布者</th>
                    <th style="text-align: center;">操作</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">请按时提交期末考试试卷</td>
                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">请按时提交期末考试试卷请按时提交期末考试试卷请按时提交期末考试试卷请按时提交期末考试试卷</td>
                    <td>2018-05-31&emsp;23:11:02</td>
                    <td>教务处</td>
                    <td>大壮</td>
                    <td style="width: 140px; text-align: center;">
                        <button type="button" class="btn btn-info btn-sm newsContent"><i class="icon-search"></i>查看</button>
                        <button type="button" class="btn btn-danger btn-sm newsDeleteBtn"><i class=" icon-remove-circle"></i>删除</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 通告详情Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">详细信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="content">标题</label>
                        <div id="content">文件被删除</div>
                    </div>
                    <div class="form-group">
                        <label for="description">内容</label>
                        <div id="description">数学试卷由于不符合许愿要求，被删除数学试卷由于不符合许愿要求，被删除数学试卷由于不符合许愿要求，被删除数学试卷由于不符合许愿要求，被删除</div>
                    </div>
                    <div class="form-group">
                        <p class="date" style="text-align: right; margin-top: 30px; font-weight: bold;">
                            <span class="date">2017/09/23</span>
                            <span id="username">何大壮</span>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 发布通告Modal -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">详细信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="newsTitle">标题</label>
                        <input id="newsTitle" class="form-control" type="text">
                    </div>
                    <div class="form-group">
                        <label for="newsContent">内容</label>
                        <textarea id="newsContent" class="textareaStyle"></textarea>
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
        $(".newsContent").on("click", function(){
            $("#myModal").modal();
        });

        $("#resetBtn").click(function(){
            $("#newsTitle").val("");
            $("#newsContent").val("");
        });

        $(".newsDeleteBtn").on("click", function(){
            $.confirm({
                title: '提示',
                content: '确认删除该条消息通告？',
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
