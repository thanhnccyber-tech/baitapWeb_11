<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- HERO -->
<section class="hero-modern">
    <div class="container text-center position-relative" style="z-index:1;">
        <h1>Chào mừng đến với HelloTest Shop</h1>
        <p class="mb-4">Khám phá hàng ngàn sản phẩm công nghệ chất lượng cao từ các seller uy tín</p>
        <a href="${pageContext.request.contextPath}/seller/products" class="hero-btn">
            <i class="fas fa-shopping-bag"></i> Mua sắm ngay
        </a>
    </div>
</section>

<!-- DANH MỤC -->
<c:if test="${not empty categories}">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h3 class="m-0"><i class="fas fa-th-large text-primary"></i> Danh mục sản phẩm</h3>
    </div>
    <div class="row g-3 mb-section">
        <c:forEach var="cat" items="${categories}">
            <div class="col-6 col-md-4 col-lg-3">
                <a href="${pageContext.request.contextPath}/seller/products?categoryId=${cat.categoryId}"
                   class="category-chip">
                    <div>
                        <i class="fas fa-tag"></i>
                        <div>${cat.categoryName}</div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</c:if>

<!-- SẢN PHẨM NỔI BẬT -->
<div class="d-flex align-items-center justify-content-between mb-3">
    <h3 class="m-0"><i class="fas fa-fire text-danger"></i> Sản phẩm nổi bật</h3>
    <a href="${pageContext.request.contextPath}/seller/products" class="text-primary fw-semibold">
        Xem tất cả <i class="fas fa-arrow-right"></i>
    </a>
</div>

<c:choose>
    <c:when test="${empty featuredProducts}">
        <div class="empty-state">
            <i class="fas fa-box-open"></i>
            <p>Chưa có sản phẩm nào.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-4">
            <c:forEach var="p" items="${featuredProducts}">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                            <img src="${not empty p.images ? p.images : 'https://via.placeholder.com/300x220?text=No+Image'}"
                                 class="product-card-img" alt="${p.productName}">
                        </a>
                        <div class="product-card-body">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                               class="product-title">${p.productName}</a>
                            <div class="mt-auto">
                                <div class="product-price mb-2">
                                    <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-muted small">
                                        <i class="fas fa-cubes"></i> Còn ${p.amount}
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                                   class="btn btn-primary btn-sm w-100">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>