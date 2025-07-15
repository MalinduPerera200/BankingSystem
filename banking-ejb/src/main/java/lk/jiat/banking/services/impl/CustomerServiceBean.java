package lk.jiat.banking.services.impl;

import jakarta.ejb.Stateless;
import jakarta.ejb.EJB;
import lk.jiat.banking.dao.CustomerDAO;
import lk.jiat.banking.entities.Customer;
import lk.jiat.banking.exceptions.BankingException;
import lk.jiat.banking.services.interfaces.CustomerServiceLocal;
import java.util.List;

@Stateless
public class CustomerServiceBean implements CustomerServiceLocal {

    @EJB
    private CustomerDAO customerDAO;

    @Override
    public Customer createCustomer(Customer customer) throws BankingException {
        // Add validation logic here
        if (customer.getNic() == null || customer.getNic().isEmpty()) {
            throw new BankingException("Customer NIC cannot be empty.");
        }
        // Further validation for uniqueness, format, etc.
        customerDAO.save(customer);
        return customer;
    }

    @Override
    public Customer getCustomerById(Long customerId) {
        Customer customer = customerDAO.findById(customerId);
        if (customer == null) {
            throw new BankingException("Customer with ID " + customerId + " not found.");
        }
        return customer;
    }

    @Override
    public List<Customer> getAllCustomers() {
        // Implement method in CustomerDAO
        return customerDAO.findAll();
    }

    @Override
    public Customer updateCustomer(Customer customer) throws BankingException {
        if (customer.getId() == null) {
            throw new BankingException("Customer ID is required for update.");
        }
        // Add validation logic here
        customerDAO.update(customer);
        return customer;
    }

    @Override
    public void deleteCustomer(Long customerId) throws BankingException {
        Customer customer = customerDAO.findById(customerId);
        if (customer != null) {
            customerDAO.delete(customer);
        } else {
            throw new BankingException("Customer with ID " + customerId + " not found for deletion.");
        }
    }
}