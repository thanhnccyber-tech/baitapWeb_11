package vn.utepro.service;

import vn.utepro.dao.UserDao_24162115;
import vn.utepro.entity.Users_24162115;
import vn.utepro.util.MailUtil_24162115;
import java.util.Random;

public class UserService_24162115 {
    private UserDao_24162115 userDao = new UserDao_24162115();

    public Users_24162115 login(String username, String password) {
        Users_24162115 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
            return user;
        }
        return null;
    }

    public String register(Users_24162115 user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return "Tên đăng nhập đã tồn tại!";
        }
        String otp = String.format("%06d", new Random().nextInt(999999));
        user.setCode(otp);
        user.setStatus(0);
        userDao.save(user);

        String subject = "Kích hoạt tài khoản KTQT";
        String content = "Mã OTP của bạn là: " + otp;
        boolean sent = MailUtil_24162115.sendEmail(user.getEmail(), subject, content);
        return sent
                ? "Đăng ký thành công. Vui lòng kiểm tra email để lấy mã OTP!"
                : "Đăng ký thành công nhưng gửi mail thất bại!";
    }

    public boolean activateAccount(String username, String otp) {
        Users_24162115 user = userDao.findByUsername(username);
        if (user != null && otp != null && otp.equals(user.getCode())) {
            user.setStatus(1);
            userDao.update(user);
            return true;
        }
        return false;
    }
}