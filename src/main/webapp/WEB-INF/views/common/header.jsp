<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page import="vn.utepro.service.CartService_24162115" %>
<%@ page import="vn.utepro.entity.Users_24162115" %>
<%
    int cartCount = 0;
    Users_24162115 _u = (Users_24162115) session.getAttribute("user");
    if (_u != null) {
        try {
            cartCount = new CartService_24162115().getCartCount(_u.getUserId());
        } catch (Exception ex) { /* ignore */ }
    }
    request.setAttribute("cartCount", cartCount);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>HelloTest Shop</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-store"></i> HelloTest Shop
        </a>

        <button class="navbar-toggler border-0" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto ms-3">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/products">
                        <i class="fas fa-box-open"></i> Sản Phẩm
                    </a>
                </li>
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item position-relative">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i> Giỏ hàng
                            <c:if test="${cartCount > 0}">
                                <span class="cart-badge">${cartCount}</span>
                            </c:if>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                            <i class="fas fa-history"></i> Đơn hàng của tôi
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user != null && sessionScope.user.roleId == 1}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button"
                           data-bs-toggle="dropdown">
                            <i class="fas fa-cog"></i> Quản Trị
                        </a>
                        <ul class="dropdown-menu shadow border-0">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category">
                                    <i class="fas fa-folder text-primary"></i> Quản lý Category
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product">
                                    <i class="fas fa-box text-success"></i> Quản lý Product
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus"></i> Đăng ký
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <span class="nav-link">
                                <i class="fas fa-user-circle"></i>
                                <b>${sessionScope.user.username}</b>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<main class="main-content">
<div class="container py-4">