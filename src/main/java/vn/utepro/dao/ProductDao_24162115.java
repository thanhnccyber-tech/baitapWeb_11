package vn.utepro.dao;

import vn.utepro.entity.Product_24162115;
import vn.utepro.util.JpaUtil_24162115;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ProductDao_24162115 extends GenericDaoImpl_24162115<Product_24162115> {
    public List<Product_24162115> findBySellerId(int sellerId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Product p WHERE p.sellerId = :sellerId",
                    Product_24162115.class)
                    .setParameter("sellerId", sellerId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}