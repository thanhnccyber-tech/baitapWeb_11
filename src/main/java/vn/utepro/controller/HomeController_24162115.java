package vn.utepro.controller;

import vn.utepro.entity.Category_24162115;
import vn.utepro.entity.Product_24162115;
import vn.utepro.service.CategoryService_24162115;
import vn.utepro.service.ProductService_24162115;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home"})
public class HomeController_24162115 extends HttpServlet {

    private ProductService_24162115 prodService = new ProductService_24162115();
    private CategoryService_24162115 catService = new CategoryService_24162115();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product_24162115> featuredProducts =
                prodService.findPaginated(Product_24162115.class, 1, 8);

        List<Category_24162115> categories =
                catService.findAll(Category_24162115.class);

        req.setAttribute("featuredProducts", featuredProducts);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/WEB-INF/views/shop/home.jsp").forward(req, resp);
    }
}