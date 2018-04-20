<%--@elvariable id="page" type="com.utm.model.vo.Page"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" name="currentPage" id="currentPageInput" value="${page.currentPage}">
<c:choose>
    <c:when test="${page.totalNumber == 0}">
        <p class="alert alert-info" style="text-align: center;font-size:16px;font-weight: bold;margin-top: -10px;">暂无数据</p>
    </c:when>
    <c:otherwise>
        <div class="pull-right" style="margin-bottom: 15px">
            <span>共 ${page.totalNumber} 条</span>
            <span>当前第${page.currentPage}/${page.totalPage}页</span>
            <c:if test="${page.currentPage != 1}">
                <a style="margin-left: 15px;" class="btn btn-default btn-xs" href="javascript:changeCurrentPage('1')">首页</a>
                <a class="btn btn-default btn-xs" href="javascript:changeCurrentPage('${page.currentPage-1}')">上一页</a>
            </c:if>
            <c:if test="${page.currentPage != page.totalPage}">
                <a class="btn btn-default btn-xs" href="javascript:changeCurrentPage('${page.currentPage+1}')">下一页</a>
                <a style="margin-right: 15px;" class="btn btn-default btn-xs" href="javascript:changeCurrentPage('${page.totalPage}')">末页</a>
            </c:if>
        </div>
    </c:otherwise>
</c:choose>
