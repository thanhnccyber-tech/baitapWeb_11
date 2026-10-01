<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-icon" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
            <i class="fas fa-envelope-open-text"></i>
        </div>
        <h3>Kích hoạt tài khoản</h3>
        <p class="subtitle">Nhập mã OTP đã được gửi về email của bạn</p>

        <c:if test="${not empty msg}">
            <div class="alert alert-info"><i class="fas fa-info-circle"></i> ${msg}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/activate">
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user"></i> Username</label>
                <input type="text" name="username" value="${username}"
                       class="form-control" required>
            </div>
            <div class="mb-4">
                <label class="form-label"><i class="fas fa-key"></i> Mã OTP</label>
                <input type="text" name="otp" class="form-control text-center"
                       style="letter-spacing: .5rem; font-size: 1.25rem; font-weight: 700;"
                       maxlength="6" placeholder="● ● ● ● ● ●" required>
            </div>
            <button class="btn btn-primary w-100 btn-lg">
                <i class="fas fa-check-circle"></i> Kích hoạt
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" class="text-primary fw-semibold">
                <i class="fas fa-arrow-left"></i> Quay lại đăng nhập
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>