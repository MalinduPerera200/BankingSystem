package lk.jiat.banking.security;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import lk.jiat.banking.dao.UserDAO;
import lk.jiat.banking.entities.User;

import java.util.Optional;
import java.util.logging.Logger;

@Stateless
public class AuthenticationService {

    private static final Logger LOGGER = Logger.getLogger(AuthenticationService.class.getName());

    @EJB
    private UserDAO userDAO;

    @EJB
    private PasswordService passwordService;

    public Optional<User> authenticate(String username, String password) {
        LOGGER.info("Attempting to authenticate user: " + username);

        Optional<User> userOptional = userDAO.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            LOGGER.info("User found: " + user.getUsername() + ", Role: " + user.getRole());
            LOGGER.info("Verifying password for user: " + user.getUsername());

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

    public String hashPassword(String plainPassword) {
        return passwordService.hashPassword(plainPassword);
    }

    public boolean verifyPassword(String plainPassword, String hashedPassword) {
        return passwordService.verifyPasswordDebug(plainPassword, hashedPassword);
    }
}
