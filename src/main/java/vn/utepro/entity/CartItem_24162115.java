package vn.utepro.entity;

import jakarta.persistence.*;

@Entity(name = "CartItem")
@Table(name = "CartItem")
public class CartItem_24162115 {
    @Id
    private String cartItemId;
    private int quantity;
    private float unitPrice;
    private int productId;
    private String cartId;

    public CartItem_24162115() {}

    public String getCartItemId() { return cartItemId; }
    public void setCartItemId(String cartItemId) { this.cartItemId = cartItemId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public float getUnitPrice() { return unitPrice; }
    public void setUnitPrice(float unitPrice) { this.unitPrice = unitPrice; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getCartId() { return cartId; }
    public void setCartId(String cartId) { this.cartId = cartId; }
}