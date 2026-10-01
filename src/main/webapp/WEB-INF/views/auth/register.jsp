<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="auth-wrapper">
    <div class="auth-card" style="max-width: 520px;">
        <div class="auth-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        <h3>Đăng ký tài khoản</h3>
        <p class="subtitle">Tạo tài khoản để bắt đầu mua sắm</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${msg}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="row g-3">
                <div class="col-12">
                    <label class="form-label"><i class="fas fa-user"></i> Username <span class="text-danger">*</span></label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="col-12">
                    <label class="form-label"><i class="fas fa-lock"></i> Password <span class="text-danger">*</span></label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="col-12">
                    <label class="form-label"><i class="fas fa-envelope"></i> Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control"
                           placeholder="OTP sẽ được gửi về email này" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-id-card"></i> Fullname</label>
                    <input type="text" name="fullname" class="form-control">
                </div>
                <div class="col-md-6">
                    <label class="form-label"><i class="fas fa-phone"></i> Phone</label>
                    <input type="text" name="phone" class="form-control">
                </div>
            </div>

            <button class="btn btn-success w-100 btn-lg mt-4">
                <i class="fas fa-user-plus"></i> Đăng ký
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" class="text-primary fw-semibold">
                Đã có tài khoản? Đăng nhập
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>