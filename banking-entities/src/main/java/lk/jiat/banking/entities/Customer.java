package lk.jiat.banking.entities;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList; // Import ArrayList
import java.util.List;      // Import List

@Entity
@Table(name = "customers")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ✅ NEW: Define the one-to-many relationship
    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Account> accounts = new ArrayList<>();

    // ... (all your other existing fields: firstName, lastName, nic, etc.)
    @Column(nullable = false)
    private String firstName;
    @Column(nullable = false)
    private String lastName;
    @Column(unique = true, nullable = false)
    private String nic;
    private String address;
    private String phoneNumber;
    @Column(unique = true)
    private String email;
    private LocalDate dateOfBirth;

    // Constructors
    public Customer() {}

    public Customer(String firstName, String lastName, String nic, String address, String phoneNumber, String email, LocalDate dateOfBirth) {
        //... constructor body
        this.firstName = firstName;
        this.lastName = lastName;
        this.nic = nic;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.dateOfBirth = dateOfBirth;
    }

    // --- Getters and Setters ---

    // ✅ NEW: Add the getter for the accounts list
    public List<Account> getAccounts() {
        return accounts;
    }

    // ... (all your other existing getters and setters: getId, getFirstName, getNic, etc.)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public void setAccounts(List<Account> accounts) { this.accounts = accounts; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
}