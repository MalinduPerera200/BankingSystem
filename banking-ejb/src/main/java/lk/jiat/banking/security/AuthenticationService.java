package lk.jiat.banking.security;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import lk.jiat.banking.dao.UserDAO;
import lk.jiat.banking.entities.User;
import lk.jiat.banking.enums.UserRole;

import java.util.Optional;
import java.util.logging.Logger;

@Stateless
public class AuthenticationService {

    private static final Logger LOGGER = Logger.getLogger(AuthenticationService.class.getName());

    @EJB
    private UserDAO userDAO;

    @EJB
    private PasswordService passwordService;

    /**
     * Authenticates a user based on username and password.
     */
    public Optional<User> authenticate(String username, String password) {
        LOGGER.info("Attempting to authenticate user: " + username);

        Optional<User> userOptional = userDAO.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            LOGGER.info("User found: " + user.getUsername() + ", Role: " + user.getRole());
            LOGGER.info("Verifying password for user: " + user.getUsername());

            // This is where the issue might be - make sure we're calling the right method
            boolean passwordMatches = passwordService.verifyPasswordDebug(password, user.getPasswordHash());

            if (passwordMatches) {
                LOGGER.info("Authentication successful for user: " + user.getUsername());
                return Optional.of(user);
            } else {
                LOGGER.warning("Password verification failed for user: " + user.getUsername());
            }
        } else {
            LOGGER.warning("User not found in database: " + username);
        }
        return Optional.empty();
    }

    // Add these helper methods for debugging
    public String hashPassword(String plainPassword) {
        return passwordService.hashPassword(plainPassword);
    }

    public boolean verifyPassword(String plainPassword, String hashedPassword) {
        return passwordService.verifyPasswordDebug(plainPassword, hashedPassword);
    }
}