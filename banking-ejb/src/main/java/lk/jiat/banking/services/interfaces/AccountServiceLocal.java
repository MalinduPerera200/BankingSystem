package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Local;
import lk.jiat.banking.entities.Account;
import lk.jiat.banking.exceptions.BankingException;
import java.math.BigDecimal;
import java.util.List;

@Local
public interface AccountServiceLocal {
    Account createAccount(Account account) throws BankingException;
    Account getAccountById(Long accountId);
    List<Account> getAccountsByCustomerId(Long customerId);
    Account updateAccount(Account account) throws BankingException;
    void deleteAccount(Long accountId) throws BankingException;
    void deposit(String accountNumber, BigDecimal amount) throws BankingException;
    void withdraw(String accountNumber, BigDecimal amount) throws BankingException;
    void transfer(String fromAccountNumber, String toAccountNumber, BigDecimal amount) throws BankingException;
}