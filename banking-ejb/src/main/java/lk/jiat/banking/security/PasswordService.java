package lk.jiat.banking.security;

import jakarta.ejb.Stateless;
import org.mindrot.jbcrypt.BCrypt; // You'll need to add this library as a dependency
import java.util.logging.Logger; // Import the Logger


/**
 * Service for securely hashing and verifying passwords using BCrypt.
 * BCrypt is a strong, slow hashing algorithm designed to make brute-force
 * attacks computationally expensive, even with powerful hardware.
 *
 * To use BCrypt, you need to add a dependency to your project.
 * For Maven, you can add:
 * <dependency>
 * <groupId>org.mindrot</groupId>
 * <artifactId>jbcrypt</artifactId>
 * <version>0.4</version> * </dependency>
 */
@Stateless // <<< IMPORTANT: ADD THIS ANNOTATION
public class PasswordService {

    private static final Logger LOGGER = Logger.getLogger(PasswordService.class.getName()); // Initialize logger

    /**
     * Hashes a plain-text password using BCrypt.
     * A salt is automatically generated and embedded within the hash.
     *
     * @param plainPassword The password in plain text.
     * @return The BCrypt hashed password.
     */
    public String hashPassword(String plainPassword) {
        // BCrypt.hashpw(password, BCrypt.gensalt()) handles both salting and hashing.
        // BCrypt.gensalt() generates a random salt and determines the workload factor.
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * Verifies a plain-text password against a BCrypt hashed password.
     * The salt is extracted from the hashed password during the verification process.
     *
     * @param plainPassword The password in plain text to verify.
     * @param hashedPassword The BCrypt hashed password from the database.
     * @return true if the plain password matches the hashed password, false otherwise.
     */
//    public boolean verifyPassword(String plainPassword, String hashedPassword) {
//        if (plainPassword == null || hashedPassword == null) {
//            LOGGER.warning("PasswordService: Plain password or hashed password is null during verification.");
//            return false;
//        }
//
//        LOGGER.info("PasswordService: Verifying. Plain text length: " + plainPassword.length() + ", Hashed password length: " + hashedPassword.length());
//        LOGGER.info("Plain password (first 5 chars for debug): " + plainPassword.substring(0, Math.min(plainPassword.length(), 5)));
//        LOGGER.info("Hashed password (first 5 chars for debug): " + hashedPassword.substring(0, Math.min(hashedPassword.length(), 5)));
//
//        boolean isMatch = BCrypt.checkpw(plainPassword, hashedPassword);
//        LOGGER.info("PasswordService: BCrypt.checkpw result: " + isMatch);
//
//        return isMatch;
//    }
    // Add this temporary debugging method to your PasswordService.java

    public boolean verifyPasswordDebug(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            LOGGER.warning("PasswordService: Plain password or hashed password is null during verification.");
            return false;
        }

        LOGGER.info("=== DETAILED PASSWORD DEBUG ===");
        LOGGER.info("Plain password: '" + plainPassword + "'");
        LOGGER.info("Plain password length: " + plainPassword.length());
        LOGGER.info("Plain password bytes: " + java.util.Arrays.toString(plainPassword.getBytes()));

        LOGGER.info("Hashed password: '" + hashedPassword + "'");
        LOGGER.info("Hashed password length: " + hashedPassword.length());
        LOGGER.info("Hashed password bytes: " + java.util.Arrays.toString(hashedPassword.getBytes()));

        // Check if hash is valid BCrypt format
        if (!hashedPassword.startsWith("$2a$") && !hashedPassword.startsWith("$2b$") && !hashedPassword.startsWith("$2y$")) {
            LOGGER.warning("Invalid BCrypt hash format!");
            return false;
        }

        // Test with a fresh hash of the same password
        String testHash = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        LOGGER.info("Fresh hash of same password: " + testHash);
        boolean testVerify = BCrypt.checkpw(plainPassword, testHash);
        LOGGER.info("Fresh hash verification: " + testVerify);

        boolean isMatch = BCrypt.checkpw(plainPassword, hashedPassword);
        LOGGER.info("Original hash verification: " + isMatch);
        LOGGER.info("=== END DEBUG ===");

        return isMatch;
    }
}