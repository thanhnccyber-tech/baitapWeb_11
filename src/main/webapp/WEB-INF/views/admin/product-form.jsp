<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<nav class="breadcrumb-modern">
    <a href="${pageContext.request.contextPath}/admin/product">Quản lý Product</a>
    <span class="text-muted mx-1">/</span>
    <span class="text-muted">${prod == null ? 'Thêm mới' : 'Sửa'}</span>
</nav>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="card-modern p-4">
            <h4 class="mb-4">
                <i class="fas fa-${prod == null ? 'plus-circle' : 'edit'} text-primary"></i>
                ${prod == null ? 'Thêm Product' : 'Sửa Product'}
            </h4>

            <form method="post" action="${pageContext.request.contextPath}/admin/product">
                <input type="hidden" name="id" value="${prod.productId}">

                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="productName" value="${prod.productName}"
                               class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Mã sản phẩm</label>
                        <input type="number" name="productCode" value="${prod.productCode}"
                               class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Danh mục</label>
                        <select name="categoryId" class="form-select">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.categoryId}"
                                    ${prod != null && prod.categoryId == c.categoryId ? 'selected' : ''}>
                                    ${c.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Seller ID</label>
                        <input type="number" name="sellerId"
                               value="${prod != null ? prod.sellerId : 1}"
                               class="form-control">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-control" rows="3">${prod.description}</textarea>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" name="price" value="${prod.price}"
                               class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Số lượng (amount)</label>
                        <input type="number" name="amount"
                               value="${prod != null ? prod.amount : 0}"
                               class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tồn kho (stock)</label>
                        <input type="number" name="stock"
                               value="${prod != null ? prod.stock : 0}"
                               class="form-control">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Link ảnh</label>
                        <input type="text" name="images" value="${prod.images}"
                               class="form-control" placeholder="https://...">
                    </div>
                </div>

                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary flex-fill">
                        <i class="fas fa-save"></i> Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-secondary flex-fill">
                        <i class="fas fa-times"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>