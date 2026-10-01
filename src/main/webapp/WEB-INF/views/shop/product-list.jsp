<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<nav class="breadcrumb-modern">
    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
    <span class="text-muted mx-1">/</span>
    <span class="text-muted">Sản phẩm</span>
</nav>

<div class="page-header">
    <div>
        <h3><i class="fas fa-box-open text-primary"></i> Danh sách sản phẩm</h3>
        <div class="subtitle">Cửa hàng #${sellerId}</div>
    </div>
</div>

<c:choose>
    <c:when test="${empty products}">
        <div class="empty-state">
            <i class="fas fa-search"></i>
            <h5>Không có sản phẩm nào</h5>
            <p>Seller #${sellerId} chưa có sản phẩm nào trong cửa hàng.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-4">
            <c:forEach var="p" items="${products}">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                            <img src="${not empty p.images ? p.images : 'https://via.placeholder.com/300x220?text=No'}"
                                 class="product-card-img" alt="${p.productName}">
                        </a>
                        <div class="product-card-body">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                               class="product-title">${p.productName}</a>

                            <div class="d-flex justify-content-between align-items-center mb-2 small text-muted">
                                <span><i class="fas fa-barcode"></i> ${p.productCode}</span>
                                <c:choose>
                                    <c:when test="${p.amount > 0}">
                                        <span class="text-success">
                                            <i class="fas fa-check-circle"></i> Còn ${p.amount}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger">
                                            <i class="fas fa-times-circle"></i> Hết hàng
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="mt-auto">
                                <div class="product-price mb-3">
                                    <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>
                                </div>

                                <div class="d-flex gap-2">
                                    <a class="btn btn-info btn-sm flex-fill"
                                       href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                                        <i class="fas fa-eye"></i> Chi tiết
                                    </a>
                                    <c:if test="${sessionScope.user != null && p.amount > 0 && p.status == 1}">
                                        <a class="btn btn-success btn-sm flex-fill"
                                           href="${pageContext.request.contextPath}/cart/add?productId=${p.productId}&quantity=1&back=${pageContext.request.contextPath}/seller/products">
                                            <i class="fas fa-cart-plus"></i> Thêm
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />