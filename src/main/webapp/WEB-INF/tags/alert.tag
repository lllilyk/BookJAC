<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${not empty message }">
    <div class="container-lg" style="width: 500px; font-size: 20px; text-align: center;">
        <div class="alert alert-secondary alert-dismissible fade show" id="toast" role="alert">${message }</div>
    </div>
</c:if>