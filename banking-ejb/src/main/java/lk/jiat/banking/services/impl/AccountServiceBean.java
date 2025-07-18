package lk.jiat.banking.services.impl;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.banking.entities.Account;
import lk.jiat.banking.entities.Transaction;
import lk.jiat.banking.enums.TransactionType;
import lk.jiat.banking.exceptions.AccountNotFoundException;
import lk.jiat.banking.exceptions.BankingException;
import lk.jiat.banking.exceptions.InsufficientFundsException;
import lk.jiat.banking.services.interfaces.AccountServiceLocal;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Stateless
public class AccountServiceBean implements AccountServiceLocal {

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    @Override
    public void createAccount(Account account) throws BankingException {
        // Find by account number instead of primary key if account number is not the primary key
        TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.accountNumber = :accountNumber", Account.class);
        query.setParameter("accountNumber", account.getAccountNumber());
        if (!query.getResultList().isEmpty()) {
            throw new BankingException("An account with this number already exists.");
        }
        em.persist(account);
    }

    @Override
    public void deposit(String accountNumber, BigDecimal amount) throws BankingException {
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Deposit amount must be positive.");
        }
        Account account = findAccountByNumber(accountNumber);
        account.setBalance(account.getBalance().add(amount));
        em.merge(account);

        // CORRECTED CONSTRUCTOR CALL
        Transaction transaction = new Transaction(account, amount, TransactionType.DEPOSIT, "Teller Deposit");
        em.persist(transaction);
    }

    @Override
    public void withdraw(String accountNumber, BigDecimal amount) throws BankingException {
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Withdrawal amount must be positive.");
        }
        Account account = findAccountByNumber(accountNumber);
        if (account.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException("Insufficient funds for this withdrawal.");
        }
        account.setBalance(account.getBalance().subtract(amount));
        em.merge(account);

        // CORRECTED CONSTRUCTOR CALL
        Transaction transaction = new Transaction(account, amount, TransactionType.WITHDRAWAL, "Teller Withdrawal");
        em.persist(transaction);
    }

    @Override
    public void transfer(String fromAccountNumber, String toAccountNumber, BigDecimal amount) throws BankingException {
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Transfer amount must be positive.");
        }
        Account fromAccount = findAccountByNumber(fromAccountNumber);
        Account toAccount = findAccountByNumber(toAccountNumber);

        if (fromAccount.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException("Insufficient funds for this transfer.");
        }

        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        toAccount.setBalance(toAccount.getBalance().add(amount));

        em.merge(fromAccount);
        em.merge(toAccount);

        // CORRECTED CONSTRUCTOR CALLS
        Transaction fromTransaction = new Transaction(fromAccount, amount, TransactionType.TRANSFER_IN, "Transfer to " + toAccountNumber);
        Transaction toTransaction = new Transaction(toAccount, amount, TransactionType.DEPOSIT, "Transfer from " + fromAccountNumber);
        em.persist(fromTransaction);
        em.persist(toTransaction);
    }

    @Override
    public Account findAccountByNumber(String accountNumber) throws BankingException {
        TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.accountNumber = :accountNumber", Account.class);
        query.setParameter("accountNumber", accountNumber);
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            throw new AccountNotFoundException("Account with number " + accountNumber + " not found.");
        }
    }

    @Override
    public List<Account> findAccountsByCustomerId(Long customerId) throws BankingException {
        TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.customer.id = :customerId", Account.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }
}