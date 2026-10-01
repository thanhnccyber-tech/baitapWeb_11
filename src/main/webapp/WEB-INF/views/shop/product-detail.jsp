<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<nav class="breadcrumb-modern">
    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
    <span class="text-muted mx-1">/</span>
    <a href="${pageContext.request.contextPath}/seller/products">Sản phẩm</a>
    <span class="text-muted mx-1">/</span>
    <span class="text-muted">Chi tiết</span>
</nav>

<c:choose>
    <c:when test="${prod != null}">
        <div class="row g-4 align-items-start">
            <!-- Ảnh -->
            <div class="col-lg-6">
                <img src="${not empty prod.images ? prod.images : 'https://via.placeholder.com/600x480?text=No+Image'}"
                     class="product-detail-img" alt="${prod.productName}">
            </div>

            <!-- Thông tin -->
            <div class="col-lg-6">
                <h2 class="mb-2">${prod.productName}</h2>

                <div class="d-flex align-items-center gap-3 mb-3 text-muted small">
                    <span><i class="fas fa-barcode"></i> Mã SP: <b>${prod.productCode}</b></span>
                    <span><i class="fas fa-folder"></i> Danh mục: <b>${prod.categoryId}</b></span>
                </div>

                <div class="product-detail-price mb-3">
                    <fmt:formatNumber value="${prod.price}" type="number" maxFractionDigits="0"/> đ
                </div>

                <div class="mb-3">
                    <c:choose>
                        <c:when test="${prod.amount > 0}">
                            <span class="badge-status badge-active">
                                <i class="fas fa-check-circle"></i> Còn hàng (${prod.amount})
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-status badge-inactive">
                                <i class="fas fa-times-circle"></i> Hết hàng
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mb-4">
                    <h6 class="text-muted text-uppercase small fw-bold">Mô tả sản phẩm</h6>
                    <p>${empty prod.description ? 'Chưa có mô tả cho sản phẩm này.' : prod.description}</p>
                </div>

                <!-- Form thêm giỏ -->
                <c:if test="${prod.status == 1 && prod.amount > 0 && sessionScope.user != null}">
                    <form method="get" action="${pageContext.request.contextPath}/cart/add"
                          class="d-flex align-items-center gap-2 mb-3">
                        <input type="hidden" name="productId" value="${prod.productId}" />
                        <input type="hidden" name="back"
                               value="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" />
                        <div class="input-group" style="max-width: 140px;">
                            <span class="input-group-text bg-light border-0">
                                <i class="fas fa-sort-numeric-up"></i>
                            </span>
                            <input type="number" name="quantity" value="1" min="1" max="${prod.amount}"
                                   class="form-control quantity-input" />
                        </div>
                        <button class="btn btn-success btn-lg flex-grow-1">
                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                        </button>
                    </form>
                </c:if>

                <c:if test="${prod.amount <= 0}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i> Sản phẩm đã hết hàng.
                    </div>
                </c:if>

                <c:if test="${sessionScope.user == null}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Vui lòng <a href="${pageContext.request.contextPath}/login" class="fw-bold">đăng nhập</a>
                        để thêm vào giỏ hàng.
                    </div>
                </c:if>

                <a href="${pageContext.request.contextPath}/seller/products"
                   class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-state">
            <i class="fas fa-search"></i>
            <h5>Không tìm thấy sản phẩm</h5>
            <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary mt-2">
                Về danh sách sản phẩm
            </a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />