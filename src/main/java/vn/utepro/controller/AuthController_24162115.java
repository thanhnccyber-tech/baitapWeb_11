package vn.utepro.controller;

import vn.utepro.entity.Users_24162115;
import vn.utepro.service.UserService_24162115;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout", "/activate"})
public class AuthController_24162115 extends HttpServlet {
    private UserService_24162115 userService = new UserService_24162115();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/logout":
                req.getSession().invalidate();
                resp.sendRedirect(req.getContextPath() + "/login");
                break;
            case "/login":
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                break;
            case "/register":
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                break;
            case "/activate":
                req.getRequestDispatcher("/WEB-INF/views/auth/activate.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/login".equals(path)) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            Users_24162115 u = userService.login(username, password);
            if (u != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", u);
                if (u.getRoleId() == 1) {
                    resp.sendRedirect(req.getContextPath() + "/admin/category");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            } else {
                req.setAttribute("error", "Sai tài khoản/mật khẩu hoặc chưa kích hoạt!");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            }
        } else if ("/register".equals(path)) {
            Users_24162115 u = new Users_24162115();
            u.setUsername(req.getParameter("username"));
            u.setPassword(req.getParameter("password"));
            u.setEmail(req.getParameter("email"));
            u.setFullname(req.getParameter("fullname"));
            u.setPhone(req.getParameter("phone"));
            u.setRoleId(2);
            u.setSellerId(0);
            String msg = userService.register(u);
            req.setAttribute("msg", msg);
            req.setAttribute("username", u.getUsername());
            req.getRequestDispatcher("/WEB-INF/views/auth/activate.jsp").forward(req, resp);
        } else if ("/activate".equals(path)) {
            String username = req.getParameter("username");
            String otp = req.getParameter("otp");
            if (userService.activateAccount(username, otp)) {
                req.setAttribute("msg", "Kích hoạt thành công! Hãy đăng nhập.");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Mã OTP không đúng!");
                req.setAttribute("username", username);
                req.getRequestDispatcher("/WEB-INF/views/auth/activate.jsp").forward(req, resp);
            }
        }
    }
}