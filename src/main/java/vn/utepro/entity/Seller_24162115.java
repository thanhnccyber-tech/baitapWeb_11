package vn.utepro.entity;

import jakarta.persistence.*;

@Entity(name = "Seller")
@Table(name = "Seller")
public class Seller_24162115 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int sellerId;
    private String sellername;
    private String images;
    private int status;

    public Seller_24162115() {}

    public int getSellerId() { return sellerId; }
    public void setSellerId(int sellerId) { this.sellerId = sellerId; }

    public String getSellername() { return sellername; }
    public void setSellername(String sellername) { this.sellername = sellername; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
}