package vn.utepro.dao;

import vn.utepro.entity.Cart_24162115;
import vn.utepro.util.JpaUtil_24162115;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CartDao_24162115 extends GenericDaoImpl_24162115<Cart_24162115> {

    /** Tìm giỏ hàng đang hoạt động (status = 0) của user. */
    public Cart_24162115 findActiveCartByUserId(int userId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            List<Cart_24162115> list = em.createQuery(
                    "SELECT c FROM Cart c WHERE c.userId = :uid AND c.status = 0",
                    Cart_24162115.class)
                    .setParameter("uid", userId)
                    .setMaxResults(1)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    /** Lấy TẤT CẢ đơn hàng (status >= 1) — dùng cho tab "Tất cả". */
    public List<Cart_24162115> findOrderHistory(int userId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM Cart c WHERE c.userId = :uid AND c.status >= 1 "
                  + "ORDER BY c.buyDate DESC",
                    Cart_24162115.class)
                    .setParameter("uid", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    /** Lọc đơn hàng theo 1 trạng thái cụ thể. */
    public List<Cart_24162115> findOrderHistoryByStatus(int userId, int status) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM Cart c WHERE c.userId = :uid AND c.status = :status "
                  + "ORDER BY c.buyDate DESC",
                    Cart_24162115.class)
                    .setParameter("uid", userId)
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    /** Đơn hàng mới đặt gần nhất — dùng cho trang order-success.jsp */
    public Cart_24162115 findLatestOrder(int userId) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            List<Cart_24162115> list = em.createQuery(
                    "SELECT c FROM Cart c WHERE c.userId = :uid AND c.status >= 1 "
                  + "ORDER BY c.buyDate DESC",
                    Cart_24162115.class)
                    .setParameter("uid", userId)
                    .setMaxResults(1)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }
}