package lk.jiat.banking.security;

import jakarta.ejb.Stateless;
import org.mindrot.jbcrypt.BCrypt;
import java.util.logging.Logger;

@Stateless
public class PasswordService {

    private static final Logger LOGGER = Logger.getLogger(PasswordService.class.getName());

    public String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

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

        if (!hashedPassword.startsWith("$2a$") && !hashedPassword.startsWith("$2b$") && !hashedPassword.startsWith("$2y$")) {
            LOGGER.warning("Invalid BCrypt hash format!");
            return false;
        }

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
