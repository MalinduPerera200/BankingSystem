package lk.jiat.banking.security;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import lk.jiat.banking.entities.User;
import lk.jiat.banking.services.interfaces.UserService;

import java.util.Optional;

@Stateless
public class AuthenticationService {

    @EJB
    private UserService userService;

    @EJB
    private PasswordService passwordService;

    /**
     * Authenticates a user based on username and plain-text password.
     * @param username The user's username.
     * @param password The user's plain-text password.
     * @return An Optional containing the authenticated User object if successful, or empty if authentication fails.
     */
    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOptional = userService.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (passwordService.verifyPassword(password, user.getPassword())) {
                return Optional.of(user); // Authentication successful
            }
        }
        return Optional.empty(); // Authentication failed
    }
}