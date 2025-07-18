package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Local;
import lk.jiat.banking.entities.Customer;
import lk.jiat.banking.exceptions.BankingException;

import java.util.List;

@Local
public interface CustomerServiceLocal {
    Customer createCustomer(Customer customer) throws BankingException;
    Customer getCustomerById(Long customerId);
    List<Customer> getAllCustomers();
    Customer updateCustomer(Customer customer) throws BankingException;
    void deleteCustomer(Long customerId) throws BankingException;
    Customer findByNic(String nic);
}