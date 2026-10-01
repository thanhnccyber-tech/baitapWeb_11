package vn.utepro.dao;

import java.util.List;

public interface GenericDao_24162115<T> {
    void save(T entity);
    void update(T entity);
    void delete(Class<T> clazz, Object id);
    T findById(Class<T> clazz, Object id);
    List<T> findAll(Class<T> clazz);
    List<T> findPaginated(Class<T> clazz, int page, int pageSize);
    long countAll(Class<T> clazz);
}