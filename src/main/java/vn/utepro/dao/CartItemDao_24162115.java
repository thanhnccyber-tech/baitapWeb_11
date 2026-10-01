package vn.utepro.dao;

import vn.utepro.entity.CartItem_24162115;
import vn.utepro.util.JpaUtil_24162115;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class CartItemDao_24162115 extends GenericDaoImpl_24162115<CartItem_24162115> {

    public List<CartItem_24162115> findByCartId(String cartId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT ci FROM CartItem ci WHERE ci.cartId = :cid",
                    CartItem_24162115.class)
                    .setParameter("cid", cartId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public CartItem_24162115 findByCartAndProduct(String cartId, int productId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            List<CartItem_24162115> list = em.createQuery(
                    "SELECT ci FROM CartItem ci WHERE ci.cartId = :cid AND ci.productId = :pid",
                    CartItem_24162115.class)
                    .setParameter("cid", cartId)
                    .setParameter("pid", productId)
                    .setMaxResults(1)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    /** Xóa toàn bộ item của 1 cart. */
    public void deleteByCartId(String cartId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("DELETE FROM CartItem ci WHERE ci.cartId = :cid")
              .setParameter("cid", cartId)
              .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}