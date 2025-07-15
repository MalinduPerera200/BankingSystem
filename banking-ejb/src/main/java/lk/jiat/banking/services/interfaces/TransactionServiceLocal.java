package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Local;
import lk.jiat.banking.entities.Transaction;
import java.util.List;

@Local
public interface TransactionServiceLocal {
    Transaction getTransactionById(Long transactionId);
    List<Transaction> getTransactionsByAccountId(Long accountId);
    List<Transaction> getRecentTransactions(int limit);
}