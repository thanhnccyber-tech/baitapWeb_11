package vn.utepro.dao;

import vn.utepro.util.JpaUtil_24162115;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class GenericDaoImpl_24162115<T> implements GenericDao_24162115<T> {

    /**
     * Lấy tên Entity từ annotation @Entity(name = "...")
     * Nếu @Entity không có name, dùng tên class.
     */
    private String getEntityName(Class<T> clazz) {
        jakarta.persistence.Entity entityAnno =
                clazz.getAnnotation(jakarta.persistence.Entity.class);
        if (entityAnno != null && entityAnno.name() != null && !entityAnno.name().isEmpty()) {
            return entityAnno.name();
        }
        return clazz.getSimpleName();
    }

    @Override
    public void save(T entity) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(entity);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(T entity) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(entity);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Class<T> clazz, Object id) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T entity = em.find(clazz, id);
            if (entity != null) em.remove(entity);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public T findById(Class<T> clazz, Object id) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            return em.find(clazz, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findAll(Class<T> clazz) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            String entityName = getEntityName(clazz);
            String jpql = "SELECT e FROM " + entityName + " e";
            return em.createQuery(jpql, clazz).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findPaginated(Class<T> clazz, int page, int pageSize) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            String entityName = getEntityName(clazz);
            String jpql = "SELECT e FROM " + entityName + " e";
            return em.createQuery(jpql, clazz)
                     .setFirstResult((page - 1) * pageSize)
                     .setMaxResults(pageSize)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll(Class<T> clazz) {
        EntityManager em = JpaUtil_24162115.getEntityManager();
        try {
            String entityName = getEntityName(clazz);
            String jpql = "SELECT COUNT(e) FROM " + entityName + " e";
            return em.createQuery(jpql, Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
}