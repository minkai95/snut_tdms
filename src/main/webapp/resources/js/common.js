/**
 * 系统通用js
 * Created by duanzeyao on 2017/2/15.
 */

/**
 * 分页工具
 * @param currentPage
 */
function changeCurrentPage(currentPage) {
    var t1 = $('#typeContentStrFilter1').val();
    var t2 = $('#typeContentStrFilter2').val();
    var t3 = $('#typeContentStrFilter3').val();
    var str = [];
    if ('undefined'==t1){
        str[0]="";
    }else {
        str[0]=t1;
    }
    if ('undefined'==t2){
        str[1]="";
    }else {
        str[1]=t2;
    }
    if ('undefined'==t3){
        str[2]="";
    }else {
        str[2]=t3;
    }
    $('#typeContentStr').val(str.join("/"));
    $("#currentPageInput").val(currentPage);
    $("#pageForm").submit();
}