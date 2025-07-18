package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.banking.entities.Account;
import lk.jiat.banking.exceptions.AccountNotFoundException;
import lk.jiat.banking.exceptions.BankingException;
import lk.jiat.banking.exceptions.InsufficientFundsException;

import java.math.BigDecimal;
import java.util.List;

@Stateless
public class AccountService implements AccountServiceLocal {

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    private static final BigDecimal MINIMUM_BALANCE = new BigDecimal("1000.00");

    @Override
    public void createAccount(Account account) {
        em.persist(account);
    }

    @Override
    public Account findAccountByNumber(String accountNumber) throws AccountNotFoundException {

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Account number cannot be null or empty.");
        }
        try {
            TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.accountNumber = :accountNumber", Account.class);
            query.setParameter("accountNumber", accountNumber);
            return query.getSingleResult();
        } catch (NoResultException e) {
            throw new AccountNotFoundException("Account not found with number: " + accountNumber);
        }
    }

    @Override
    public List<Account> findAccountsByCustomerId(Long customerId) throws BankingException {
        return List.of();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deposit(String accountNumber, BigDecimal amount) throws BankingException {
        Account account = findAccountByNumber(accountNumber);
        BigDecimal newBalance = account.getBalance().add(amount);
        account.setBalance(newBalance);
        em.merge(account);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void withdraw(String accountNumber, BigDecimal amount) throws BankingException {
        Account account = findAccountByNumber(accountNumber);

        BigDecimal remainingBalance = account.getBalance().subtract(amount);

        if (amount.compareTo(account.getBalance()) > 0) {
            throw new InsufficientFundsException("Insufficient funds for withdrawal.");
        }

        if (remainingBalance.compareTo(MINIMUM_BALANCE) < 0) {
            throw new InsufficientFundsException(String.format(
                    "Withdrawal not allowed. A minimum balance of LKR %.2f must be maintained.",
                    MINIMUM_BALANCE
            ));
        }

        account.setBalance(remainingBalance);
        em.merge(account);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void transfer(String fromAccountNumber, String toAccountNumber, BigDecimal amount) throws BankingException {
        Account fromAccount = findAccountByNumber(fromAccountNumber);
        Account toAccount = findAccountByNumber(toAccountNumber);

        BigDecimal remainingBalance = fromAccount.getBalance().subtract(amount);

        if (amount.compareTo(fromAccount.getBalance()) > 0) {
            throw new InsufficientFundsException("Insufficient funds in the source account.");
        }

        if (remainingBalance.compareTo(MINIMUM_BALANCE) < 0) {
            throw new InsufficientFundsException(String.format(
                    "Transfer not allowed. A minimum balance of LKR %.2f must be maintained in the source account.",
                    MINIMUM_BALANCE
            ));
        }

        fromAccount.setBalance(remainingBalance);
        toAccount.setBalance(toAccount.getBalance().add(amount));

        em.merge(fromAccount);
        em.merge(toAccount);
    }
}