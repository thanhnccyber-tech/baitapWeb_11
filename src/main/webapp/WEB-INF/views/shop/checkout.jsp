<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div>
        <h3><i class="fas fa-credit-card text-primary"></i> Thanh toán đơn hàng</h3>
        <div class="subtitle">Phương thức: Thanh toán khi nhận hàng (COD)</div>
    </div>
</div>

<c:if test="${not empty sessionScope.cartError}">
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i> ${sessionScope.cartError}
    </div>
    <c:remove var="cartError" scope="session"/>
</c:if>

<div class="row g-4">
    <!-- Cột trái: Sản phẩm -->
    <div class="col-lg-7">
        <div class="card-modern p-4">
            <h5 class="mb-3"><i class="fas fa-box text-primary"></i> Sản phẩm trong đơn</h5>
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th width="70" class="text-center">SL</th>
                            <th width="120" class="text-end">Đơn giá</th>
                            <th width="130" class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="it" items="${items}">
                            <c:set var="p" value="${productMap[it.productId]}"/>
                            <tr>
                                <td class="fw-semibold">${p.productName}</td>
                                <td class="text-center">${it.quantity}</td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${it.unitPrice}" type="number" maxFractionDigits="0"/> đ
                                </td>
                                <td class="text-end fw-bold text-danger">
                                    <fmt:formatNumber value="${it.unitPrice * it.quantity}"
                                                      type="number" maxFractionDigits="0"/> đ
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="cart-total-row">
                            <td colspan="3" class="text-end">TỔNG CỘNG:</td>
                            <td class="text-end text-danger fs-4">
                                <fmt:formatNumber value="${total}" type="number" maxFractionDigits="0"/> đ
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <!-- Cột phải: Form giao hàng -->
    <div class="col-lg-5">
        <div class="card-modern p-4">
            <h5 class="mb-3"><i class="fas fa-truck text-primary"></i> Thông tin giao hàng</h5>

            <form method="post"
                  action="${pageContext.request.contextPath}/cart/checkout"
                  onsubmit="return confirm('Xác nhận đặt hàng?');">

                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-user"></i> Họ tên người nhận <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="fullname" class="form-control"
                           value="${sessionScope.user.fullname}"
                           maxlength="100" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-phone"></i> Số điện thoại <span class="text-danger">*</span>
                    </label>
                    <input type="tel" name="phone" class="form-control"
                           value="${sessionScope.user.phone}"
                           pattern="\d{9,11}" maxlength="11"
                           title="Số điện thoại phải gồm 9–11 chữ số"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-map-marker-alt"></i> Địa chỉ giao hàng <span class="text-danger">*</span>
                    </label>
                    <textarea name="address" rows="3" class="form-control"
                              maxlength="500" required
                              placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành..."></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-money-bill-wave"></i> Phương thức thanh toán
                    </label>
                    <input type="text" class="form-control bg-light"
                           value="Thanh toán khi nhận hàng (COD)" disabled/>
                </div>

                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    Bạn sẽ thanh toán
                    <b><fmt:formatNumber value="${total}" type="number" maxFractionDigits="0"/> đ</b>
                    bằng tiền mặt khi nhận hàng.
                </div>

                <button type="submit" class="btn btn-success btn-lg w-100 mb-2">
                    <i class="fas fa-check-circle"></i> Đặt hàng COD
                </button>
                <a href="${pageContext.request.contextPath}/cart"
                   class="btn btn-secondary w-100">
                    <i class="fas fa-arrow-left"></i> Quay lại giỏ
                </a>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>