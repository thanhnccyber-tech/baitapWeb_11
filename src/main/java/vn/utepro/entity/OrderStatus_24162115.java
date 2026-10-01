package vn.utepro.entity;

/**
 * Định nghĩa các trạng thái đơn hàng (dùng cho Cart.status khi status >= 1).
 *  - 0: Giỏ hàng đang hoạt động (chưa đặt)
 *  - 1..7: các trạng thái đơn hàng
 */
public final class OrderStatus_24162115 {

    public static final int CART        = 0;  // Giỏ hàng (chưa đặt)
    public static final int NEW         = 1;  // Đơn hàng mới
    public static final int CONFIRMED   = 2;  // Đã xác nhận
    public static final int PREPARING   = 3;  // Chuẩn bị hàng
    public static final int SHIPPING    = 4;  // Vận chuyển
    public static final int DELIVERED   = 5;  // Đã giao
    public static final int CANCELLED   = 6;  // Đơn hàng hủy
    public static final int RETURNED    = 7;  // Đơn hàng hoàn

    private OrderStatus_24162115() {}

    /** Tên hiển thị tiếng Việt */
    public static String getName(int status) {
        switch (status) {
            case NEW:       return "Đơn hàng mới";
            case CONFIRMED: return "Đã xác nhận";
            case PREPARING: return "Chuẩn bị hàng";
            case SHIPPING:  return "Vận chuyển";
            case DELIVERED: return "Đã giao";
            case CANCELLED: return "Đơn hàng hủy";
            case RETURNED:  return "Đơn hàng hoàn";
            default:        return "Không xác định";
        }
    }

    /** Class CSS cho badge (định nghĩa trong style.css) */
    public static String getBadgeClass(int status) {
        switch (status) {
            case NEW:       return "badge-new";
            case CONFIRMED: return "badge-confirmed";
            case PREPARING: return "badge-preparing";
            case SHIPPING:  return "badge-shipping";
            case DELIVERED: return "badge-delivered";
            case CANCELLED: return "badge-cancelled";
            case RETURNED:  return "badge-returned";
            default:        return "badge-inactive";
        }
    }

    /** Icon Font Awesome */
    public static String getIcon(int status) {
        switch (status) {
            case NEW:       return "fa-clock";
            case CONFIRMED: return "fa-check";
            case PREPARING: return "fa-box";
            case SHIPPING:  return "fa-truck";
            case DELIVERED: return "fa-check-circle";
            case CANCELLED: return "fa-times-circle";
            case RETURNED:  return "fa-undo";
            default:        return "fa-question";
        }
    }
}