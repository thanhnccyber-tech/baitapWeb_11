package vn.utepro.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil_24162115 {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("KTC_PU");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}