package vn.utepro.controller;

import vn.utepro.entity.Cart_24162115;
import vn.utepro.entity.CartItem_24162115;
import vn.utepro.entity.Product_24162115;
import vn.utepro.entity.Users_24162115;
import vn.utepro.service.CartService_24162115;
import vn.utepro.service.ProductService_24162115;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {
        "/cart",
        "/cart/add",
        "/cart/update",
        "/cart/remove",
        "/cart/checkout",
        "/cart/order-success"
})
public class CartController_24162115 extends HttpServlet {

    private final CartService_24162115 cartService = new CartService_24162115();
    private final ProductService_24162115 prodService = new ProductService_24162115();

    // ========== AUTH HELPERS ==========

    private Users_24162115 currentUser(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s == null ? null : (Users_24162115) s.getAttribute("user");
    }

    private boolean requireLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        if (currentUser(req) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    // ========== GET ==========

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!requireLogin(req, resp)) return;
        Users_24162115 user = currentUser(req);
        String path = req.getServletPath();

        switch (path) {
            case "/cart":
                showCart(req, resp, user);
                break;

            case "/cart/add":
                handleAdd(req, resp, user);
                break;

            case "/cart/remove":
                handleRemove(req, resp, user);
                break;

            case "/cart/checkout":
                showCheckout(req, resp, user);
                break;

            case "/cart/order-success": {
                Cart_24162115 lastOrder = cartService.getLatestOrder(user.getUserId());
                req.setAttribute("order", lastOrder);
                req.getRequestDispatcher("/WEB-INF/views/shop/order-success.jsp")
                   .forward(req, resp);
                break;
            }

            default:
                resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    // ========== POST ==========

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!requireLogin(req, resp)) return;
        req.setCharacterEncoding("UTF-8");

        Users_24162115 user = currentUser(req);
        String path = req.getServletPath();

        if ("/cart/update".equals(path)) {
            handleUpdate(req, resp, user);
        } else if ("/cart/checkout".equals(path)) {
            handleCheckout(req, resp, user);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    // ========== HANDLERS ==========

    private void showCart(HttpServletRequest req, HttpServletResponse resp,
                          Users_24162115 user)
            throws ServletException, IOException {
        Cart_24162115 cart = cartService.getActiveCart(user.getUserId());
        List<CartItem_24162115> items = (cart == null)
                ? List.of()
                : cartService.getCartItems(cart.getCartId());

        Map<Integer, Product_24162115> productMap = new HashMap<>();
        for (CartItem_24162115 it : items) {
            Product_24162115 p = prodService.findById(Product_24162115.class, it.getProductId());
            if (p != null) productMap.put(p.getProductId(), p);
        }

        float total = (cart == null) ? 0f : cartService.getCartTotal(cart.getCartId());

        req.setAttribute("cart", cart);
        req.setAttribute("items", items);
        req.setAttribute("productMap", productMap);
        req.setAttribute("total", total);

        req.getRequestDispatcher("/WEB-INF/views/shop/cart.jsp").forward(req, resp);
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp,
                           Users_24162115 user) throws IOException {
        int productId = parseInt(req.getParameter("productId"), 0);
        int qty       = parseInt(req.getParameter("quantity"), 1);

        String err = cartService.addToCart(user.getUserId(), productId, qty);
        if (err == null) {
            req.getSession().setAttribute("cartMsg", "Đã thêm vào giỏ hàng!");
        } else {
            req.getSession().setAttribute("cartError", err);
        }

        // Quay lại trang trước nếu có, mặc định về /cart
        String back = req.getParameter("back");
        if (back != null && !back.isEmpty()) {
            resp.sendRedirect(back);
        } else {
            String referer = req.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                resp.sendRedirect(referer);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp,
                              Users_24162115 user) throws IOException {
        String itemId = req.getParameter("cartItemId");
        int qty = parseInt(req.getParameter("quantity"), 1);

        String err = cartService.updateQuantity(user.getUserId(), itemId, qty);
        if (err == null) {
            req.getSession().setAttribute("cartMsg", "Đã cập nhật số lượng!");
        } else {
            req.getSession().setAttribute("cartError", err);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleRemove(HttpServletRequest req, HttpServletResponse resp,
                              Users_24162115 user) throws IOException {
        String itemId = req.getParameter("cartItemId");
        String err = cartService.removeItem(user.getUserId(), itemId);
        if (err == null) {
            req.getSession().setAttribute("cartMsg", "Đã xóa sản phẩm khỏi giỏ!");
        } else {
            req.getSession().setAttribute("cartError", err);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void showCheckout(HttpServletRequest req, HttpServletResponse resp,
                              Users_24162115 user)
            throws ServletException, IOException {
        Cart_24162115 cart = cartService.getActiveCart(user.getUserId());
        List<CartItem_24162115> items = (cart == null)
                ? List.of()
                : cartService.getCartItems(cart.getCartId());

        if (items.isEmpty()) {
            req.getSession().setAttribute("cartError", "Giỏ hàng trống, không thể thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        Map<Integer, Product_24162115> productMap = new HashMap<>();
        for (CartItem_24162115 it : items) {
            Product_24162115 p = prodService.findById(Product_24162115.class, it.getProductId());
            if (p != null) productMap.put(p.getProductId(), p);
        }

        req.setAttribute("items", items);
        req.setAttribute("productMap", productMap);
        req.setAttribute("total", cartService.getCartTotal(cart.getCartId()));
        req.getRequestDispatcher("/WEB-INF/views/shop/checkout.jsp").forward(req, resp);
    }

    private void handleCheckout(HttpServletRequest req, HttpServletResponse resp,
                                Users_24162115 user) throws IOException {
        String receiverName  = req.getParameter("fullname");
        String receiverPhone = req.getParameter("phone");
        String address       = req.getParameter("address");

        String err = cartService.checkout(
                user.getUserId(), receiverName, receiverPhone, address);

        if (err == null) {
            req.getSession().setAttribute("cartMsg",
                    "Đặt hàng thành công! Đơn hàng sẽ được giao COD.");
            resp.sendRedirect(req.getContextPath() + "/cart/order-success");
        } else {
            req.getSession().setAttribute("cartError", err);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    // ========== UTIL ==========

    private int parseInt(String s, int def) {
        if (s == null || s.trim().isEmpty()) return def;
        try { return Integer.parseInt(s.trim()); }
        catch (NumberFormatException e) { return def; }
    }
}