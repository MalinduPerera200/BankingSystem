package lk.jiat.banking.entities;

import jakarta.persistence.*;
import lk.jiat.banking.enums.AccountStatus; // Import the new enum
import lk.jiat.banking.enums.AccountType;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "accounts")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String accountNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal balance;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AccountType accountType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AccountStatus accountStatus;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    public Account() {}

    public Account(String accountNumber, Customer customer, BigDecimal balance, AccountType accountType, LocalDateTime createdAt) {
        this.accountNumber = accountNumber;
        this.customer = customer;
        this.balance = balance;
        this.accountType = accountType;
        this.createdAt = createdAt;
        this.accountStatus = AccountStatus.ACTIVE;
    }

    public LocalDateTime getOpenedDate() {
        return createdAt;
    }


    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) { this.id = id; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public BigDecimal getBalance() { return balance; }
    public void setBalance(BigDecimal balance) { this.balance = balance; }
    public AccountType getAccountType() { return accountType; }
    public void setAccountType(AccountType accountType) { this.accountType = accountType; }
    public void setAccountStatus(AccountStatus accountStatus) { this.accountStatus = accountStatus; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}