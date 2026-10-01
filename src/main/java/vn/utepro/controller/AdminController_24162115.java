package vn.utepro.controller;

import vn.utepro.entity.Category_24162115;
import vn.utepro.entity.Product_24162115;
import vn.utepro.entity.Users_24162115;
import vn.utepro.service.CategoryService_24162115;
import vn.utepro.service.ProductService_24162115;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/category", "/admin/product"})
public class AdminController_24162115 extends HttpServlet {

    private CategoryService_24162115 catService = new CategoryService_24162115();
    private ProductService_24162115 prodService = new ProductService_24162115();

    /** Kiểm tra user đã đăng nhập và có roleId == 1 (Admin). */
    private boolean checkAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        Users_24162115 user = (Users_24162115) session.getAttribute("user");
        if (user == null || user.getRoleId() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;

        String path = req.getServletPath();
        String action = req.getParameter("action");
        if (action == null) action = "list";
        int pageSize = 5;

        try {
            if ("/admin/category".equals(path)) {
                handleCategoryGet(req, resp, action, pageSize);
            } else if ("/admin/product".equals(path)) {
                handleProductGet(req, resp, action, pageSize);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError", "Lỗi: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }

    // ==================== CATEGORY ====================

    private void handleCategoryGet(HttpServletRequest req, HttpServletResponse resp,
                                   String action, int pageSize)
            throws ServletException, IOException {
        switch (action) {
            case "new":
                req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp")
                   .forward(req, resp);
                break;

            case "edit": {
                int id = parseInt(req.getParameter("id"), 0);
                Category_24162115 cat = catService.findById(Category_24162115.class, id);
                if (cat == null) {
                    req.getSession().setAttribute("adminError",
                            "Không tìm thấy category ID=" + id);
                    resp.sendRedirect(req.getContextPath() + "/admin/category");
                    return;
                }
                req.setAttribute("cat", cat);
                req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp")
                   .forward(req, resp);
                break;
            }

            case "delete": {
                int id = parseInt(req.getParameter("id"), 0);
                catService.delete(Category_24162115.class, id);
                req.getSession().setAttribute("adminMsg", "Đã xóa category ID=" + id);
                resp.sendRedirect(req.getContextPath() + "/admin/category");
                break;
            }

            default: {
                int page = parseInt(req.getParameter("page"), 1);
                List<Category_24162115> list =
                        catService.findPaginated(Category_24162115.class, page, pageSize);
                long total = catService.countAll(Category_24162115.class);
                int totalPages = (int) Math.ceil((double) total / pageSize);

                req.setAttribute("list", list);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("totalItems", total);

                req.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp")
                   .forward(req, resp);
            }
        }
    }

    private void saveOrUpdateCategory(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Category_24162115 cat = new Category_24162115();
        String idStr = req.getParameter("id");
        boolean isUpdate = (idStr != null && !idStr.isEmpty());

        if (isUpdate) {
            cat.setCategoryId(parseInt(idStr, 0));
        }
        cat.setCategoryName(req.getParameter("categoryName"));
        cat.setImages(req.getParameter("images"));
        cat.setStatus(parseInt(req.getParameter("status"), 1));

        if (isUpdate) {
            catService.update(cat);
            req.getSession().setAttribute("adminMsg",
                    "Đã cập nhật category: " + cat.getCategoryName());
        } else {
            catService.save(cat);
            req.getSession().setAttribute("adminMsg",
                    "Đã thêm category: " + cat.getCategoryName());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }

    // ==================== PRODUCT ====================

    private void handleProductGet(HttpServletRequest req, HttpServletResponse resp,
                                  String action, int pageSize)
            throws ServletException, IOException {
        switch (action) {
            case "new":
            case "edit": {
                if ("edit".equals(action)) {
                    int id = parseInt(req.getParameter("id"), 0);
                    Product_24162115 prod =
                            prodService.findById(Product_24162115.class, id);
                    if (prod == null) {
                        req.getSession().setAttribute("adminError",
                                "Không tìm thấy product ID=" + id);
                        resp.sendRedirect(req.getContextPath() + "/admin/product");
                        return;
                    }
                    req.setAttribute("prod", prod);
                }
                req.setAttribute("categories",
                        catService.findAll(Category_24162115.class));
                req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp")
                   .forward(req, resp);
                break;
            }

            case "delete": {
                int id = parseInt(req.getParameter("id"), 0);
                prodService.delete(Product_24162115.class, id);
                req.getSession().setAttribute("adminMsg", "Đã xóa product ID=" + id);
                resp.sendRedirect(req.getContextPath() + "/admin/product");
                break;
            }

            default: {
                int page = parseInt(req.getParameter("page"), 1);
                List<Product_24162115> list =
                        prodService.findPaginated(Product_24162115.class, page, pageSize);
                long total = prodService.countAll(Product_24162115.class);
                int totalPages = (int) Math.ceil((double) total / pageSize);

                // Map categoryId -> categoryName
                Map<Integer, String> categoryMap = new HashMap<>();
                List<Category_24162115> categories =
                        catService.findAll(Category_24162115.class);
                for (Category_24162115 c : categories) {
                    categoryMap.put(c.getCategoryId(), c.getCategoryName());
                }

                req.setAttribute("list", list);
                req.setAttribute("categoryMap", categoryMap);
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("totalItems", total);

                req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp")
                   .forward(req, resp);
            }
        }
    }

    /**
     * Lưu/cập nhật Product.
     * ĐÃ FIX LỖI: xử lý trường hợp productCode/price rỗng/null.
     */
    private void saveOrUpdateProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Product_24162115 prod = new Product_24162115();
        String idStr = req.getParameter("id");
        boolean isUpdate = (idStr != null && !idStr.isEmpty());

        if (isUpdate) {
            prod.setProductId(parseInt(idStr, 0));
        }

        prod.setProductName(trim(req.getParameter("productName")));

        // FIX: productCode có thể rỗng -> dùng helper parseLong
        prod.setProductCode(parseLong(req.getParameter("productCode"), 0L));

        // FIX: categoryId có thể rỗng -> mặc định 1
        prod.setCategoryId(parseInt(req.getParameter("categoryId"), 1));

        prod.setDescription(trim(req.getParameter("description")));

        // FIX: price có thể rỗng -> dùng helper parseFloat
        prod.setPrice(parseFloat(req.getParameter("price"), 0f));

        prod.setAmount(parseInt(req.getParameter("amount"), 0));
        prod.setStock(parseInt(req.getParameter("stock"), 0));
        prod.setImages(trim(req.getParameter("images")));
        prod.setStatus(1);
        prod.setSellerId(parseInt(req.getParameter("sellerId"), 1));

        if (!isUpdate) {
            prod.setCreateDate(new java.util.Date());
        }

        if (isUpdate) {
            prodService.update(prod);
            req.getSession().setAttribute("adminMsg",
                    "Đã cập nhật product: " + prod.getProductName());
        } else {
            prodService.save(prod);
            req.getSession().setAttribute("adminMsg",
                    "Đã thêm product: " + prod.getProductName());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        try {
            if ("/admin/category".equals(path)) {
                saveOrUpdateCategory(req, resp);
            } else if ("/admin/product".equals(path)) {
                saveOrUpdateProduct(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError",
                    "Lỗi lưu dữ liệu: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + path);
        }
    }

    // ==================== HELPERS ====================

    private int parseInt(String s, int defaultValue) {
        if (s == null || s.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(s.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private long parseLong(String s, long defaultValue) {
        if (s == null || s.trim().isEmpty()) return defaultValue;
        try {
            return Long.parseLong(s.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private float parseFloat(String s, float defaultValue) {
        if (s == null || s.trim().isEmpty()) return defaultValue;
        try {
            return Float.parseFloat(s.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}