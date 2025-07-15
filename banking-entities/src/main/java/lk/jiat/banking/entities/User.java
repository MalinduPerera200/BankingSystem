package lk.jiat.banking.entities;

import jakarta.persistence.*;
import lk.jiat.banking.enums.UserRole;

import java.io.Serializable;

@Entity
@Table(name = "users") // Assuming your user table is named 'users'
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private String passwordHash; // Stores the BCrypt hashed password

    @Enumerated(EnumType.STRING) // Store enum as String in DB
    @Column(nullable = false)
    private UserRole role; // e.g., ADMIN, CUSTOMER, TELLER, AUDITOR

    // Default constructor
    public User() {
    }

    // Constructor with fields
    public User(String username, String passwordHash, UserRole role) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", role=" + role +
                '}';
    }
}