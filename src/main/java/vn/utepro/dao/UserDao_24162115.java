package vn.utepro.dao;

import vn.utepro.entity.Users_24162115;
import vn.utepro.util.JpaUtil_24162115;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class UserDao_24162115 extends GenericDaoImpl_24162115<Users_24162115> {
    public Users_24162115 findByUsername(String username) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u FROM Users u WHERE u.username = :username",
                    Users_24162115.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}