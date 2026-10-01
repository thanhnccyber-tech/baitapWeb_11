<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<nav class="breadcrumb-modern">
    <a href="${pageContext.request.contextPath}/admin/category">Quản lý Category</a>
    <span class="text-muted mx-1">/</span>
    <span class="text-muted">${cat == null ? 'Thêm mới' : 'Sửa'}</span>
</nav>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="card-modern p-4">
            <h4 class="mb-4">
                <i class="fas fa-${cat == null ? 'plus-circle' : 'edit'} text-primary"></i>
                ${cat == null ? 'Thêm Category' : 'Sửa Category'}
            </h4>

            <form method="post" action="${pageContext.request.contextPath}/admin/category">
                <input type="hidden" name="id" value="${cat.categoryId}">

                <div class="mb-3">
                    <label class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" name="categoryName" value="${cat.categoryName}"
                           class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Link ảnh</label>
                    <input type="text" name="images" value="${cat.images}"
                           class="form-control" placeholder="https://...">
                </div>

                <div class="mb-4">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="1" ${cat == null || cat.status == 1 ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${cat != null && cat.status == 0 ? 'selected' : ''}>Ẩn</option>
                    </select>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary flex-fill">
                        <i class="fas fa-save"></i> Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary flex-fill">
                        <i class="fas fa-times"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>