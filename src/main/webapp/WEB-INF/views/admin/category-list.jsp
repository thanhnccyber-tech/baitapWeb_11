<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div>
        <h3><i class="fas fa-folder text-primary"></i> Quản lý Category</h3>
        <div class="subtitle">Danh mục sản phẩm trong hệ thống</div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/category?action=new" class="btn btn-primary">
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
            <i class="fas fa-folder-open"></i>
            <h5>Chưa có danh mục nào</h5>
            <a href="${pageContext.request.contextPath}/admin/category?action=new" class="btn btn-primary mt-2">
                <i class="fas fa-plus"></i> Thêm danh mục đầu tiên
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-responsive table-modern">
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th width="80">ID</th>
                        <th width="100">Ảnh</th>
                        <th>Tên danh mục</th>
                        <th width="140">Trạng thái</th>
                        <th width="200" class="text-end">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${list}">
                        <tr>
                            <td class="fw-bold text-muted">#${c.categoryId}</td>
                            <td>
                                <img src="${empty c.images ? 'https://via.placeholder.com/60x60?text=No' : c.images}"
                                     width="56" height="56"
                                     style="object-fit:cover;border-radius:8px;border:1px solid #e2e8f0;"/>
                            </td>
                            <td class="fw-semibold">${c.categoryName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.status == 1}">
                                        <span class="badge-status badge-active">
                                            <i class="fas fa-check"></i> Hoạt động
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-inactive">
                                            <i class="fas fa-eye-slash"></i> Ẩn
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/admin/category?action=edit&id=${c.categoryId}"
                                   class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${c.categoryId}"
                                   onclick="return confirm('Bạn có chắc muốn xóa category [${c.categoryName}]?')"
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