package vn.utepro.service;

import vn.utepro.dao.ProductDao_24162115;
import vn.utepro.entity.Product_24162115;
import java.util.List;

public class ProductService_24162115 extends ProductDao_24162115 {
    public List<Product_24162115> getProductsBySeller(int sellerId) {
        return findBySellerId(sellerId);
    }
}