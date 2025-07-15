package lk.jiat.banking.dao;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.banking.entities.Transaction;
import java.util.List;

@Stateless
public class TransactionDAO {

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    public void save(Transaction transaction) {
        em.persist(transaction);
    }

    public Transaction findById(Long id) {
        return em.find(Transaction.class, id);
    }

    public List<Transaction> findByAccountId(Long accountId) {
        return em.createQuery("SELECT t FROM Transaction t WHERE t.account.id = :accountId ORDER BY t.transactionDate DESC", Transaction.class)
                .setParameter("accountId", accountId)
                .getResultList();
    }

    public List<Transaction> findRecentTransactions(int limit) {
        return em.createQuery("SELECT t FROM Transaction t ORDER BY t.transactionDate DESC", Transaction.class)
                .setMaxResults(limit)
                .getResultList();
    }
    // No update or delete for transactions, as they are usually immutable records
}