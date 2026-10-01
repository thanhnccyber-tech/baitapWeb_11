<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div>
        <h3><i class="fas fa-history text-primary"></i> Lịch sử đặt hàng</h3>
        <div class="subtitle">Theo dõi trạng thái tất cả đơn hàng của bạn</div>
    </div>
    <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary">
        <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
    </a>
</div>

<!-- ===== TAB LỌC TRẠNG THÁI ===== -->
<ul class="nav nav-pills flex-wrap gap-2 mb-4 order-status-tabs">
    <li class="nav-item">
        <a class="nav-link ${empty currentStatus ? 'active' : ''}"
           href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-list"></i> Tất cả
        </a>
    </li>
    <c:forEach var="s" items="${statusOptions}">
        <li class="nav-item">
            <a class="nav-link ${currentStatus == s.key ? 'active' : ''}"
               href="${pageContext.request.contextPath}/orders?status=${s.key}">
                ${s.value}
            </a>
        </li>
    </c:forEach>
</ul>

<!-- ===== DANH SÁCH ĐƠN ===== -->
<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-state">
            <i class="fas fa-receipt"></i>
            <h5>Không có đơn hàng nào</h5>
            <p>Không tìm thấy đơn hàng phù hợp với bộ lọc hiện tại.</p>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary mt-2">
                <i class="fas fa-undo"></i> Xem tất cả đơn hàng
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="d-flex flex-column gap-3">
            <c:forEach var="order" items="${orders}">
                <div class="card-modern order-card">
                    <!-- Header đơn hàng -->
                    <div class="order-card-header">
                        <div class="d-flex flex-wrap align-items-center gap-3">
                            <span class="text-muted small">
                                <i class="fas fa-receipt"></i>
                                Mã đơn: <code class="text-primary">${order.cartId}</code>
                            </span>
                            <span class="text-muted small">
                                <i class="fas fa-calendar-alt"></i>
                                <fmt:formatDate value="${order.buyDate}"
                                                pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                        <span class="badge-status ${order.statusBadgeClass}">
                            <i class="fas ${order.statusIcon}"></i>
                            ${order.statusName}
                        </span>
                    </div>

                    <!-- Thông tin giao hàng -->
                    <div class="order-card-info">
                        <div><i class="fas fa-user text-muted"></i>
                            <b>${order.receiverName}</b></div>
                        <div><i class="fas fa-phone text-muted"></i>
                            ${order.receiverPhone}</div>
                        <div><i class="fas fa-map-marker-alt text-muted"></i>
                            ${order.shippingAddress}</div>
                    </div>

                    <!-- Danh sách sản phẩm -->
                    <div class="table-responsive">
                        <table class="table align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th width="90" class="text-center">SL</th>
                                    <th width="130" class="text-end">Đơn giá</th>
                                    <th width="140" class="text-end">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="it"
                                           items="${orderItemsMap[order.cartId]}">
                                    <c:set var="p" value="${productMap[it.productId]}"/>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <img src="${empty p.images
                                                        ? 'https://via.placeholder.com/50x50?text=No'
                                                        : p.images}"
                                                     width="44" height="44"
                                                     style="object-fit:cover;border-radius:6px;border:1px solid #e2e8f0;"/>
                                                <span class="fw-semibold">
                                                    ${empty p ? 'Sản phẩm đã xóa' : p.productName}
                                                </span>
                                            </div>
                                        </td>
                                        <td class="text-center">${it.quantity}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${it.unitPrice}"
                                                              type="number"
                                                              maxFractionDigits="0"/> đ
                                        </td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber
                                                value="${it.unitPrice * it.quantity}"
                                                type="number"
                                                maxFractionDigits="0"/> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr class="cart-total-row">
                                    <td colspan="3" class="text-end">TỔNG CỘNG:</td>
                                    <td class="text-end text-danger fs-5">
                                        <fmt:formatNumber
                                            value="${orderTotalMap[order.cartId]}"
                                            type="number" maxFractionDigits="0"/> đ
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Footer đơn hàng -->
                    <div class="order-card-footer">
                        <span class="badge-status badge-active">
                            <i class="fas fa-money-bill-wave"></i> Thanh toán COD
                        </span>

                        <c:if test="${order.status == 1}">
                            <span class="text-muted small">
                                <i class="fas fa-info-circle"></i>
                                Đơn hàng đang chờ xác nhận
                            </span>
                        </c:if>
                        <c:if test="${order.status == 6}">
                            <span class="text-danger small">
                                <i class="fas fa-times-circle"></i>
                                Đơn hàng đã bị hủy
                            </span>
                        </c:if>
                        <c:if test="${order.status == 7}">
                            <span class="text-warning small">
                                <i class="fas fa-undo"></i>
                                Đơn hàng đã hoàn trả
                            </span>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <p class="text-center text-muted small mt-3">
            Tổng: <b>${orders.size()}</b> đơn hàng
        </p>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>