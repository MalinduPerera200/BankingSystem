package lk.jiat.banking.dao;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.banking.entities.Account;
import java.util.List;

@Stateless
public class AccountDAO {

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    public void save(Account account) {
        em.persist(account);
    }

    public Account findById(Long id) {
        return em.find(Account.class, id);
    }

    public Account findByAccountNumber(String accountNumber) {
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.accountNumber = :accountNumber", Account.class)
                    .setParameter("accountNumber", accountNumber)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Account> findByCustomerId(Long customerId) {
        return em.createQuery("SELECT a FROM Account a WHERE a.customer.id = :customerId", Account.class)
                .setParameter("customerId", customerId)
                .getResultList();
    }

    public void update(Account account) {
        em.merge(account);
    }

    public void delete(Account account) {
        em.remove(em.contains(account) ? account : em.merge(account));
    }
}