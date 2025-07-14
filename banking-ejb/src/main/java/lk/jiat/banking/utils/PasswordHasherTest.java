package lk.jiat.banking.utils;

// Temporary utility for testing password hashing
import lk.jiat.banking.security.PasswordService;

public class PasswordHasherTest {
    public static void main(String[] args) {
        PasswordService ps = new PasswordService();
        String plainPassword = "admin123"; // e.g., "admin123"
        String hashedPassword = ps.hashPassword(plainPassword);
        System.out.println("Hashed password: " + hashedPassword);
        // Copy this hashed password to use in your SQL INSERT statement
    }
}