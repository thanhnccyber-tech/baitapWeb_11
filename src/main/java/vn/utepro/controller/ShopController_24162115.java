package vn.utepro.controller;

import vn.utepro.entity.Product_24162115;
import vn.utepro.service.ProductService_24162115;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/product/detail", "/seller/products"})
public class ShopController_24162115 extends HttpServlet {
    private ProductService_24162115 prodService = new ProductService_24162115();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/seller/products".equals(path)) {
            // Câu 3: Hiển thị sản phẩm theo seller
            String sellerIdStr = req.getParameter("sellerId");
            int sellerId = (sellerIdStr != null) ? Integer.parseInt(sellerIdStr) : 1;
            List<Product_24162115> list = prodService.getProductsBySeller(sellerId);
            req.setAttribute("products", list);
            req.setAttribute("sellerId", sellerId);
            req.getRequestDispatcher("/WEB-INF/views/shop/product-list.jsp").forward(req, resp);
        } else if ("/product/detail".equals(path)) {
            // Câu 4: Chi tiết 1 sản phẩm
            int id = Integer.parseInt(req.getParameter("id"));
            Product_24162115 prod = prodService.findById(Product_24162115.class, id);
            req.setAttribute("prod", prod);
            req.getRequestDispatcher("/WEB-INF/views/shop/product-detail.jsp").forward(req, resp);
        }
    }
}