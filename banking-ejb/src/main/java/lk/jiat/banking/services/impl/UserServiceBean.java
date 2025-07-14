package lk.jiat.banking.services.impl;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import lk.jiat.banking.dao.UserDAO;
import lk.jiat.banking.entities.User;
import lk.jiat.banking.exceptions.BankingException; // Assuming you have a custom exception
import lk.jiat.banking.security.PasswordService;
import lk.jiat.banking.services.interfaces.UserService;

import java.util.Optional;

@Stateless
public class UserServiceBean implements UserService {

    @EJB
    private UserDAO userDAO;

    @EJB
    private PasswordService passwordService; // Inject PasswordService

    @Override
    public Optional<User> findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    @Override
    public void registerUser(User user) {
        // Before saving, hash the password
        String hashedPassword = passwordService.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        userDAO.save(user);
    }

    @Override
    public User getUserById(Long id) {
        User user = userDAO.findById(id);
        if (user == null) {
            throw new BankingException("User with ID " + id + " not found."); // Custom exception
        }
        return user;
    }

    @Override
    public void updateUser(User user) {
        // If password is changed, hash it again
        if (user.getPassword() != null && !user.getPassword().isEmpty() && !user.getPassword().startsWith("$2a$")) { // Check if it's not already hashed by BCrypt or similar
            String hashedPassword = passwordService.hashPassword(user.getPassword());
            user.setPassword(hashedPassword);
        }
        userDAO.update(user);
    }

    @Override
    public void deleteUser(Long id) {
        User user = userDAO.findById(id);
        if (user != null) {
            userDAO.delete(user);
        } else {
            throw new BankingException("User with ID " + id + " not found for deletion.");
        }
    }
}