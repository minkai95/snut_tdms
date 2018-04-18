/**
 * 系统通用js
 * Created by duanzeyao on 2017/2/15.
 */

/**
 * 分页工具
 * @param currentPage
 */
function changeCurrentPage(currentPage) {
    $("#currentPageInput").val(currentPage);
    $("#pageForm").submit();
}