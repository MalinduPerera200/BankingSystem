package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Local;
import lk.jiat.banking.entities.User;

import java.util.Optional;

@Local
public interface UserService {
    Optional<User> findByUsername(String username);
    User getUserById(Long id);
    void updateUser(User user);
    void deleteUser(Long id);
}