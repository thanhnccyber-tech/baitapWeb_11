<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-icon">
            <i class="fas fa-sign-in-alt"></i>
        </div>
        <h3>Đăng nhập</h3>
        <p class="subtitle">Chào mừng bạn quay trở lại HelloTest Shop</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${msg}
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user"></i> Username</label>
                <input type="text" name="username" class="form-control"
                       placeholder="Nhập username" required autofocus>
            </div>
            <div class="mb-4">
                <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                <input type="password" name="password" class="form-control"
                       placeholder="Nhập password" required>
            </div>
            <button class="btn btn-primary w-100 btn-lg">
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/register" class="text-primary fw-semibold">
                Chưa có tài khoản? Đăng ký ngay
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>