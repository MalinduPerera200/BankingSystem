package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Local;
import lk.jiat.banking.entities.User;

import java.util.Optional;

@Local // Or @Remote if accessed from a different JVM
public interface UserService {
    Optional<User> findByUsername(String username);
    void registerUser(User user); // Add a method to register new users
    User getUserById(Long id);
    void updateUser(User user);
    void deleteUser(Long id);
}