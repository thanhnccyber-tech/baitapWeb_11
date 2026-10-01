<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="auth-wrapper">
    <div class="text-center">
        <div class="success-circle">
            <i class="fas fa-check"></i>
        </div>

        <h2 class="text-success fw-bold mb-3">Đặt hàng thành công!</h2>

        <p class="lead mb-1">
            Cảm ơn <b>${sessionScope.user.username}</b> đã tin tưởng mua sắm.
        </p>
        <p class="text-muted">
            Đơn hàng sẽ được giao trong 2–5 ngày làm việc.<br>
            Vui lòng thanh toán <b>tiền mặt khi nhận hàng (COD)</b>.
        </p>

        <c:if test="${not empty sessionScope.cartMsg}">
            <div class="alert alert-success d-inline-block mt-2">
                <i class="fas fa-check-circle"></i> ${sessionScope.cartMsg}
            </div>
            <c:remove var="cartMsg" scope="session"/>
        </c:if>
    </div>
</div>

<c:if test="${order != null}">
    <div class="row justify-content-center mt-4">
        <div class="col-lg-7">
            <div class="card-modern p-4">
                <h5 class="mb-3"><i class="fas fa-file-invoice text-primary"></i> Chi tiết đơn hàng</h5>
                <table class="table table-borderless mb-0">
                    <tr>
                        <td width="35%" class="text-muted">Mã đơn hàng</td>
                        <td><code class="text-primary fw-bold">${order.cartId}</code></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Ngày đặt</td>
                        <td><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Người nhận</td>
                        <td class="fw-semibold">${order.receiverName}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Số điện thoại</td>
                        <td>${order.receiverPhone}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Địa chỉ giao hàng</td>
                        <td>${order.shippingAddress}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Phương thức</td>
                        <td><span class="badge-status badge-active">
                            <i class="fas fa-money-bill-wave"></i> COD
                        </span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</c:if>

<div class="text-center mt-4">
    <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary">
        <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
    </a>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
        <i class="fas fa-home"></i> Về trang chủ
    </a>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>