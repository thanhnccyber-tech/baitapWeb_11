package vn.utepro.service;

import vn.utepro.dao.CartDao_24162115;
import vn.utepro.dao.CartItemDao_24162115;
import vn.utepro.dao.ProductDao_24162115;
import vn.utepro.entity.Cart_24162115;
import vn.utepro.entity.CartItem_24162115;
import vn.utepro.entity.Product_24162115;

import java.util.Date;
import java.util.List;
import java.util.UUID;

public class CartService_24162115 {

    private final CartDao_24162115 cartDao = new CartDao_24162115();
    private final CartItemDao_24162115 itemDao = new CartItemDao_24162115();
    private final ProductDao_24162115 productDao = new ProductDao_24162115();

    // ========== LẤY / TẠO GIỎ ==========

    public Cart_24162115 getOrCreateActiveCart(int userId) {
        Cart_24162115 cart = cartDao.findActiveCartByUserId(userId);
        if (cart == null) {
            cart = new Cart_24162115();
            cart.setCartId(UUID.randomUUID().toString());
            cart.setUserId(userId);
            cart.setStatus(0);
            cart.setBuyDate(null);
            cartDao.save(cart);
        }
        return cart;
    }

    public Cart_24162115 getActiveCart(int userId) {
        return cartDao.findActiveCartByUserId(userId);
    }

    public Cart_24162115 getLatestOrder(int userId) {
        return cartDao.findLatestOrder(userId);
    }

    // ========== THÊM VÀO GIỎ ==========

    /**
     * Thêm sản phẩm vào giỏ.
     * @return null nếu OK, ngược lại là thông báo lỗi.
     */
    public String addToCart(int userId, int productId, int quantity) {
        if (quantity <= 0) quantity = 1;

        Product_24162115 product = productDao.findById(Product_24162115.class, productId);
        if (product == null) return "Sản phẩm không tồn tại!";
        if (product.getStatus() != 1) return "Sản phẩm đã ngừng bán!";

        int maxQty = product.getAmount();
        if (maxQty <= 0) return "Sản phẩm đã hết hàng!";

        Cart_24162115 cart = getOrCreateActiveCart(userId);
        CartItem_24162115 item = itemDao.findByCartAndProduct(cart.getCartId(), productId);

        if (item == null) {
            item = new CartItem_24162115();
            item.setCartItemId(UUID.randomUUID().toString());
            item.setCartId(cart.getCartId());
            item.setProductId(productId);
            item.setUnitPrice(product.getPrice());
            item.setQuantity(Math.min(quantity, maxQty));
            itemDao.save(item);
        } else {
            int newQty = item.getQuantity() + quantity;
            if (newQty > maxQty) newQty = maxQty;
            item.setQuantity(newQty);
            itemDao.update(item);
        }
        return null;
    }

    // ========== CẬP NHẬT SỐ LƯỢNG ==========

    /**
     * Cập nhật số lượng 1 item. Số lượng sẽ tự kẹp trong [1, product.amount].
     * @return null nếu OK, ngược lại là thông báo lỗi.
     */
    public String updateQuantity(int userId, String cartItemId, int quantity) {
        CartItem_24162115 item = itemDao.findById(CartItem_24162115.class, cartItemId);
        if (item == null) return "Không tìm thấy sản phẩm trong giỏ!";

        Cart_24162115 cart = cartDao.findById(Cart_24162115.class, item.getCartId());
        if (cart == null || cart.getUserId() != userId || cart.getStatus() != 0)
            return "Bạn không có quyền thao tác giỏ hàng này!";

        Product_24162115 product = productDao.findById(Product_24162115.class, item.getProductId());
        if (product == null) return "Sản phẩm không còn tồn tại!";

        int maxQty = product.getAmount();
        if (quantity < 1) quantity = 1;
        if (quantity > maxQty) quantity = maxQty;

        item.setQuantity(quantity);
        itemDao.update(item);
        return null;
    }

    // ========== XÓA ITEM ==========

    public String removeItem(int userId, String cartItemId) {
        CartItem_24162115 item = itemDao.findById(CartItem_24162115.class, cartItemId);
        if (item == null) return "Không tìm thấy sản phẩm trong giỏ!";

        Cart_24162115 cart = cartDao.findById(Cart_24162115.class, item.getCartId());
        if (cart == null || cart.getUserId() != userId)
            return "Bạn không có quyền thao tác giỏ hàng này!";

        itemDao.delete(CartItem_24162115.class, cartItemId);
        return null;
    }

    // ========== TIỆN ÍCH ==========

    public List<CartItem_24162115> getCartItems(String cartId) {
        return itemDao.findByCartId(cartId);
    }

    public float getCartTotal(String cartId) {
        float total = 0f;
        for (CartItem_24162115 it : itemDao.findByCartId(cartId)) {
            total += it.getQuantity() * it.getUnitPrice();
        }
        return total;
    }

    public int getCartCount(int userId) {
        Cart_24162115 cart = cartDao.findActiveCartByUserId(userId);
        if (cart == null) return 0;
        int count = 0;
        for (CartItem_24162115 it : itemDao.findByCartId(cart.getCartId())) {
            count += it.getQuantity();
        }
        return count;
    }

    // ========== THANH TOÁN COD ==========

    /**
     * Đặt hàng COD:
     *  - validate thông tin giao hàng
     *  - kiểm tra tồn kho, trừ kho
     *  - lưu receiverName / receiverPhone / shippingAddress vào Cart
     *  - chuyển cart.status = 1 và set buyDate = now
     * @return null nếu thành công, ngược lại là thông báo lỗi.
     */
    public String checkout(int userId,
                           String receiverName,
                           String receiverPhone,
                           String shippingAddress) {
        // 1) Validate thông tin giao hàng
        if (receiverName == null || receiverName.trim().isEmpty())
            return "Vui lòng nhập họ tên người nhận!";
        if (receiverPhone == null || receiverPhone.trim().isEmpty())
            return "Vui lòng nhập số điện thoại!";
        if (!receiverPhone.trim().matches("\\d{9,11}"))
            return "Số điện thoại không hợp lệ (phải là 9–11 chữ số)!";
        if (shippingAddress == null || shippingAddress.trim().isEmpty())
            return "Vui lòng nhập địa chỉ giao hàng!";

        // 2) Lấy giỏ hàng đang hoạt động
        Cart_24162115 cart = cartDao.findActiveCartByUserId(userId);
        if (cart == null) return "Giỏ hàng trống!";

        List<CartItem_24162115> items = itemDao.findByCartId(cart.getCartId());
        if (items == null || items.isEmpty()) return "Giỏ hàng trống!";

        // 3) Kiểm tra tồn kho
        for (CartItem_24162115 it : items) {
            Product_24162115 p = productDao.findById(Product_24162115.class, it.getProductId());
            if (p == null || p.getStatus() != 1)
                return "Sản phẩm ID=" + it.getProductId() + " không còn bán!";
            if (p.getAmount() < it.getQuantity())
                return "Sản phẩm [" + p.getProductName() + "] không đủ số lượng!";
        }

        // 4) Trừ tồn kho
        for (CartItem_24162115 it : items) {
            Product_24162115 p = productDao.findById(Product_24162115.class, it.getProductId());
            p.setAmount(p.getAmount() - it.getQuantity());
            productDao.update(p);
        }

        // 5) Lưu thông tin giao hàng + đánh dấu đã đặt
        cart.setReceiverName(receiverName.trim());
        cart.setReceiverPhone(receiverPhone.trim());
        cart.setShippingAddress(shippingAddress.trim());
        cart.setStatus(1);
        cart.setBuyDate(new Date());
        cartDao.update(cart);
        return null;
    }

    public List<Cart_24162115> getOrderHistory(int userId) {
        return cartDao.findOrderHistory(userId);
    }
}