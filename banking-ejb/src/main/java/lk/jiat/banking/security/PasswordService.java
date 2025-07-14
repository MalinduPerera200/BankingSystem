package lk.jiat.banking.security;


import jakarta.ejb.Stateless;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Service for hashing and verifying passwords.
 * For production, consider using BCrypt or Argon2 for stronger security.
 */
@Stateless
public class PasswordService {

    private static final int SALT_LENGTH = 16; // 16 bytes for salt

    /**
     * Hashes a plain-text password with a randomly generated salt.
     * @param password The plain-text password.
     * @return The hashed password string in format "salt:hash".
     * @throws RuntimeException if hashing fails.
     */
    public String hashPassword(String password) {
        try {
            // Generate a random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[SALT_LENGTH];
            random.nextBytes(salt);

            // Hash the password with the salt
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // You can use "SHA-512" or other algorithms
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());

            // Combine salt and hash, then encode to Base64
            String saltStr = Base64.getEncoder().encodeToString(salt);
            String hashStr = Base64.getEncoder().encodeToString(hashedPassword);

            return saltStr + ":" + hashStr;

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password: " + e.getMessage(), e);
        }
    }

    /**
     * Verifies a plain-text password against a hashed password.
     * @param plainPassword The plain-text password provided by the user.
     * @param storedHashedPassword The hashed password retrieved from the database (format "salt:hash").
     * @return true if passwords match, false otherwise.
     */
    public boolean verifyPassword(String plainPassword, String storedHashedPassword) {
        if (storedHashedPassword == null || !storedHashedPassword.contains(":")) {
            return false; // Invalid stored format
        }

        try {
            String[] parts = storedHashedPassword.split(":");
            if (parts.length != 2) {
                return false; // Invalid format
            }

            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedHash = Base64.getDecoder().decode(parts[1]);

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] newHash = md.digest(plainPassword.getBytes());

            // Compare the newly generated hash with the stored hash
            return MessageDigest.isEqual(newHash, storedHash);

        } catch (NoSuchAlgorithmException | IllegalArgumentException e) {
            System.err.println("Error verifying password: " + e.getMessage());
            return false;
        }
    }
}