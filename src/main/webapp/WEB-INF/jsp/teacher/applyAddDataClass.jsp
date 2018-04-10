<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>申请新增类目</title>
</head>
<body>
    <div class="teacherCurrentWrapper">
        <div class="teacherHeader">
            <p class="publicDataTitle">教师公共资料类目</p>
            <div class="teacherUpload">
                <p class="uploadTitle">管理学院已有公共资料类目</p>
                <a href="javaScript: void(0)" class="upload" data-toggle="modal" data-target="#myModal"><i class=" icon-plus-sign"></i>申请新增公共资料类目</a>
            </div>
        </div>
        <div class="existPublicDataList">
            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
             </div>
            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">论文</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>

            <div class="dataClass">
                <div class="icon">
                    <i class="icon-circle iconLogo"></i>
                </div>
                <div class="dataClassCont">
                    <div class="className">试卷试卷试卷试卷</div>
                </div>
            </div>
            <div class="applying">
                <p class="uploadTitle">待审核类目</p>
                <div class="applyingDataClass">
                    <div class="icon">
                        <i class="icon-circle iconLogo"></i>
                    </div>
                    <div class="dataClassCont">
                        <div class="className">试卷试卷试卷试卷</div>
                    </div>
                </div>
                <div class="applyingDataClass">
                    <div class="icon">
                        <i class="icon-circle iconLogo"></i>
                    </div>
                    <div class="dataClassCont">
                        <div class="className">试卷试卷试卷试卷</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">申请新增类目</h4>
                    </div>
                    <div class="modal-body">
                        <label for="applyDataName">申请类目名称:</label>
                        <input type="text" id="applyDataName" class="applyDataName">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('.dataClass:nth-child(3n-1)').addClass('bgcOne');
            $('.dataClass:nth-child(3n+1)').addClass('bgcTwo');
            $('.dataClass:nth-child(3n)').addClass('bgcThree');

            $('.applyingDataClass').addClass('bgcApplying');
        })
    </script>
</body>
</html>
