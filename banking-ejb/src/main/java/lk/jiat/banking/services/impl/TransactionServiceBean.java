package lk.jiat.banking.services.impl;

import jakarta.ejb.Stateless;
import jakarta.ejb.EJB;
import lk.jiat.banking.dao.TransactionDAO;
import lk.jiat.banking.entities.Transaction;
import lk.jiat.banking.services.interfaces.TransactionServiceLocal;
import java.util.List;

@Stateless
public class TransactionServiceBean implements TransactionServiceLocal {

    @EJB
    private TransactionDAO transactionDAO;

    @Override
    public Transaction getTransactionById(Long transactionId) {
        return transactionDAO.findById(transactionId);
    }

    @Override
    public List<Transaction> getTransactionsByAccountId(Long accountId) {
        // Implement this method in TransactionDAO
        return transactionDAO.findByAccountId(accountId);
    }

    @Override
    public List<Transaction> getRecentTransactions(int limit) {
        // Implement this method in TransactionDAO to get recent transactions
        return transactionDAO.findRecentTransactions(limit);
    }
}