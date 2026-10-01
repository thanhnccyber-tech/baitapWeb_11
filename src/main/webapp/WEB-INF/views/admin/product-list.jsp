<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div>
        <h3><i class="fas fa-box text-primary"></i> Quản lý Product</h3>
        <div class="subtitle">Danh sách sản phẩm trong hệ thống</div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/product?action=new" class="btn btn-primary">
        <i class="fas fa-plus"></i> Thêm mới
    </a>
</div>

<c:if test="${not empty sessionScope.adminMsg}">
    <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.adminMsg}</div>
    <c:remove var="adminMsg" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.adminError}">
    <div class="alert alert-danger"><i class="fas fa-exclamation-circle"></i> ${sessionScope.adminError}</div>
    <c:remove var="adminError" scope="session"/>
</c:if>

<c:choose>
    <c:when test="${empty list}">
        <div class="empty-state">
            <i class="fas fa-box-open"></i>
            <h5>Chưa có sản phẩm nào</h5>
            <a href="${pageContext.request.contextPath}/admin/product?action=new" class="btn btn-primary mt-2">
                <i class="fas fa-plus"></i> Thêm sản phẩm đầu tiên
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-responsive table-modern">
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th width="70">ID</th>
                        <th width="90">Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th width="110">Mã SP</th>
                        <th width="140">Giá</th>
                        <th width="100">Tồn</th>
                        <th width="140">Danh mục</th>
                        <th width="180" class="text-end">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${list}">
                        <tr>
                            <td class="fw-bold text-muted">#${p.productId}</td>
                            <td>
                                <img src="${empty p.images ? 'https://via.placeholder.com/60x60?text=No' : p.images}"
                                     width="56" height="56"
                                     style="object-fit:cover;border-radius:8px;border:1px solid #e2e8f0;"/>
                            </td>
                            <td class="fw-semibold">${p.productName}</td>
                            <td><code>${p.productCode}</code></td>
                            <td class="text-danger fw-bold">
                                <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/> đ
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.amount > 0}">
                                        <span class="badge-status badge-active">${p.amount}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-inactive">0</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty categoryMap[p.categoryId]}">
                                        <span class="text-muted">${categoryMap[p.categoryId]}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">ID: ${p.categoryId}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${p.productId}"
                                   class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product?action=delete&id=${p.productId}"
                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm [${p.productName}]?')"
                                   class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <p class="text-center text-muted small">Trang ${currentPage} / ${totalPages} — ${totalItems} mục</p>
        </c:if>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>