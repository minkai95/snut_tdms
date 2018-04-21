<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- 标签库及根路径 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%-- 引入CSS --%>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/Font-Awesome/font-awesome.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap-datetimepicker.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/confirm/jquery-confirm.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/common.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/dateChoose.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/users/teacherIndex.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/users/teacherCurrent.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/users/teacherPublicData.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/users/applyAddDataClass.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/users/adminCurrent.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/personCenter.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/switchBtn.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/typeProperty.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/forgetPsw.css"/>
<%-- 引入JS --%>
<script type="text/javascript" src="${ctx}/resources/js/jquery/jquery-3.1.1.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/confirm/jquery-confirm.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validator/jquery.validator.min.js?local=zh-CN"></script>
