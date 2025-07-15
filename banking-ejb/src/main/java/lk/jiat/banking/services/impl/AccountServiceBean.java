package lk.jiat.banking.services.impl;

import jakarta.ejb.Stateless;
import jakarta.ejb.EJB;
import lk.jiat.banking.dao.AccountDAO;
import lk.jiat.banking.dao.TransactionDAO;
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

    @EJB
    private AccountDAO accountDAO;
    @EJB
    private TransactionDAO transactionDAO;

    @Override
    public Account createAccount(Account account) throws BankingException {
        // Add validation logic (e.g., account number format, initial balance)
        if (account.getAccountNumber() == null || account.getAccountNumber().isEmpty()) {
            throw new BankingException("Account number cannot be empty.");
        }
        if (account.getBalance() == null || account.getBalance().compareTo(BigDecimal.ZERO) < 0) {
            throw new BankingException("Initial balance cannot be negative.");
        }
        accountDAO.save(account);
        return account;
    }

    @Override
    public Account getAccountById(Long accountId) {
        Account account = accountDAO.findById(accountId);
        if (account == null) {
            throw new AccountNotFoundException("Account with ID " + accountId + " not found.");
        }
        return account;
    }

    @Override
    public List<Account> getAccountsByCustomerId(Long customerId) {
        // Implement this in AccountDAO
        return accountDAO.findByCustomerId(customerId);
    }

    @Override
    public Account updateAccount(Account account) throws BankingException {
        if (account.getId() == null) {
            throw new BankingException("Account ID is required for update.");
        }
        accountDAO.update(account);
        return account;
    }

    @Override
    public void deleteAccount(Long accountId) throws BankingException {
        Account account = accountDAO.findById(accountId);
        if (account != null) {
            accountDAO.delete(account);
        } else {
            throw new AccountNotFoundException("Account with ID " + accountId + " not found for deletion.");
        }
    }

    @Override
    public void deposit(String accountNumber, BigDecimal amount) throws BankingException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Deposit amount must be positive.");
        }
        Account account = accountDAO.findByAccountNumber(accountNumber);
        if (account == null) {
            throw new AccountNotFoundException("Account " + accountNumber + " not found.");
        }

        account.setBalance(account.getBalance().add(amount));
        accountDAO.update(account);

        Transaction transaction = new Transaction();
        transaction.setAccount(account);
        transaction.setAmount(amount);
        transaction.setTransactionType(TransactionType.DEPOSIT);
        transaction.setTransactionDate(LocalDateTime.now());
        transaction.setDescription("Deposit to account " + accountNumber);
        transactionDAO.save(transaction);
    }

    @Override
    public void withdraw(String accountNumber, BigDecimal amount) throws BankingException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Withdrawal amount must be positive.");
        }
        Account account = accountDAO.findByAccountNumber(accountNumber);
        if (account == null) {
            throw new AccountNotFoundException("Account " + accountNumber + " not found.");
        }

        if (account.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException("Insufficient funds in account " + accountNumber);
        }

        account.setBalance(account.getBalance().subtract(amount));
        accountDAO.update(account);

        Transaction transaction = new Transaction();
        transaction.setAccount(account);
        transaction.setAmount(amount);
        transaction.setTransactionType(TransactionType.WITHDRAWAL);
        transaction.setTransactionDate(LocalDateTime.now());
        transaction.setDescription("Withdrawal from account " + accountNumber);
        transactionDAO.save(transaction);
    }

    @Override
    public void transfer(String fromAccountNumber, String toAccountNumber, BigDecimal amount) throws BankingException {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Transfer amount must be positive.");
        }
        if (fromAccountNumber.equals(toAccountNumber)) {
            throw new BankingException("Cannot transfer to the same account.");
        }

        Account fromAccount = accountDAO.findByAccountNumber(fromAccountNumber);
        if (fromAccount == null) {
            throw new AccountNotFoundException("Source account " + fromAccountNumber + " not found.");
        }

        Account toAccount = accountDAO.findByAccountNumber(toAccountNumber);
        if (toAccount == null) {
            throw new AccountNotFoundException("Destination account " + toAccountNumber + " not found.");
        }

        if (fromAccount.getBalance().compareTo(amount) < 0) {
            throw new InsufficientFundsException("Insufficient funds in source account " + fromAccountNumber);
        }

        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        toAccount.setBalance(toAccount.getBalance().add(amount));

        accountDAO.update(fromAccount);
        accountDAO.update(toAccount);

        Transaction debitTransaction = new Transaction();
        debitTransaction.setAccount(fromAccount);
        debitTransaction.setAmount(amount);
        debitTransaction.setTransactionType(TransactionType.TRANSFER_OUT);
        debitTransaction.setTransactionDate(LocalDateTime.now());
        debitTransaction.setDescription("Transfer to account " + toAccountNumber);
        transactionDAO.save(debitTransaction);

        Transaction creditTransaction = new Transaction();
        creditTransaction.setAccount(toAccount);
        creditTransaction.setAmount(amount);
        creditTransaction.setTransactionType(TransactionType.TRANSFER_IN);
        creditTransaction.setTransactionDate(LocalDateTime.now());
        creditTransaction.setDescription("Transfer from account " + fromAccountNumber);
        transactionDAO.save(creditTransaction);
    }
}