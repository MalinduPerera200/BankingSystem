package lk.jiat.banking.entities;

import jakarta.persistence.*;
import lk.jiat.banking.enums.TransactionType;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id", nullable = false)
    private Account account;

    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TransactionType transactionType;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private LocalDateTime transactionDate;

    /**
     * Default constructor for JPA.
     */
    public Transaction() {
    }

    /**
     * Constructor to create a new transaction.
     * The transaction date is set automatically.
     *
     * @param account         The account associated with the transaction.
     * @param amount          The amount of the transaction.
     * @param transactionType The type of transaction (DEPOSIT, WITHDRAWAL, TRANSFER).
     * @param description     A brief description of the transaction.
     */
    public Transaction(Account account, BigDecimal amount, TransactionType transactionType, String description) {
        this.account = account;
        this.amount = amount;
        this.transactionType = transactionType;
        this.description = description;
    }

    /**
     * Automatically sets the transactionDate before the entity is persisted.
     */
    @PrePersist
    protected void onCreate() {
        this.transactionDate = LocalDateTime.now();
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDateTime transactionDate) {
        this.transactionDate = transactionDate;
    }
}