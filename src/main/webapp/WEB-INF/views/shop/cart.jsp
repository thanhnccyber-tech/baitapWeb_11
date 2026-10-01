<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div>
        <h3><i class="fas fa-shopping-cart text-primary"></i> Giỏ hàng của bạn</h3>
        <div class="subtitle">Kiểm tra và cập nhật số lượng trước khi thanh toán</div>
    </div>
</div>

<c:if test="${not empty sessionScope.cartMsg}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> ${sessionScope.cartMsg}
    </div>
    <c:remove var="cartMsg" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.cartError}">
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i> ${sessionScope.cartError}
    </div>
    <c:remove var="cartError" scope="session"/>
</c:if>

<c:choose>
    <c:when test="${empty items}">
        <div class="empty-state">
            <i class="fas fa-shopping-basket"></i>
            <h5>Giỏ hàng đang trống</h5>
            <p>Hãy thêm sản phẩm vào giỏ để tiếp tục mua sắm.</p>
            <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary mt-2">
                <i class="fas fa-shopping-bag"></i> Mua sắm ngay
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-responsive table-modern mb-4">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th width="100">Ảnh</th>
                        <th>Sản phẩm</th>
                        <th width="140">Đơn giá</th>
                        <th width="220">Số lượng</th>
                        <th width="160">Thành tiền</th>
                        <th width="80"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="it" items="${items}">
                        <c:set var="p" value="${productMap[it.productId]}"/>
                        <tr>
                            <td>
                                <img src="${empty p.images ? 'https://via.placeholder.com/80x80?text=No' : p.images}"
                                     class="cart-item-img"/>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                                   class="fw-semibold text-dark d-block mb-1">
                                    ${p.productName}
                                </a>
                                <span class="text-muted small">
                                    <i class="fas fa-cubes"></i> Tồn kho: ${p.amount}
                                </span>
                            </td>
                            <td class="text-danger fw-bold">
                                <fmt:formatNumber value="${it.unitPrice}" type="number" maxFractionDigits="0"/> đ
                            </td>
                            <td>
                                <form method="post"
                                      action="${pageContext.request.contextPath}/cart/update"
                                      class="d-flex gap-2">
                                    <input type="hidden" name="cartItemId" value="${it.cartItemId}"/>
                                    <input type="number" name="quantity"
                                           value="${it.quantity}"
                                           min="1" max="${p.amount}"
                                           class="form-control form-control-sm quantity-input"/>
                                    <button class="btn btn-warning btn-sm">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </form>
                            </td>
                            <td class="fw-bold text-primary">
                                <fmt:formatNumber value="${it.unitPrice * it.quantity}"
                                                  type="number" maxFractionDigits="0"/> đ
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart/remove?cartItemId=${it.cartItemId}"
                                   onclick="return confirm('Xóa sản phẩm này khỏi giỏ?');"
                                   class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="cart-total-row">
                        <td colspan="4" class="text-end fs-6">
                            <i class="fas fa-calculator"></i> TỔNG CỘNG:
                        </td>
                        <td colspan="2" class="text-danger fs-4 fw-bold">
                            <fmt:formatNumber value="${total}" type="number" maxFractionDigits="0"/> đ
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="d-flex flex-wrap justify-content-between gap-2">
            <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
            </a>
            <a href="${pageContext.request.contextPath}/cart/checkout" class="btn btn-success btn-lg">
                <i class="fas fa-credit-card"></i> Thanh toán COD
            </a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>