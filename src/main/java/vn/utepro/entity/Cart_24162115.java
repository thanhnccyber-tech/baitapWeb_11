package vn.utepro.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity(name = "Cart")
@Table(name = "Cart")
public class Cart_24162115 {
    @Id
    private String cartId;
    private int userId;
    @Temporal(TemporalType.TIMESTAMP)
    private Date buyDate;
    private int status;

    // ===== Thông tin giao hàng (COD) =====
    private String receiverName;
    private String receiverPhone;
    @Column(length = 500)
    private String shippingAddress;

    public Cart_24162115() {}

    public String getCartId() { return cartId; }
    public void setCartId(String cartId) { this.cartId = cartId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Date getBuyDate() { return buyDate; }
    public void setBuyDate(Date buyDate) { this.buyDate = buyDate; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
}