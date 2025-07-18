package lk.jiat.banking.services.interfaces;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.banking.entities.Customer;
import lk.jiat.banking.exceptions.BankingException;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Stateless
public class CustomerService implements CustomerServiceLocal {

    // Logger එකක් එකතු කරනවා log පණිවිඩ සටහන් කරන්න
    private static final Logger LOGGER = Logger.getLogger(CustomerService.class.getName());

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    /**
     * UPDATED: Find a customer by their NIC, with added logging for debugging.
     */
    @Override
    public Customer findByNic(String nic) {
        // 1. මුලින්ම log කරනවා method එකට ආපු NIC එක
        LOGGER.log(Level.INFO, "Searching for customer with NIC: ''{0}''", nic);

        if (nic == null || nic.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "NIC parameter is null or empty. Aborting search.");
            return null;
        }

        String trimmedNic = nic.trim();
        LOGGER.log(Level.INFO, "Trimmed NIC for query: ''{0}''", trimmedNic);

        try {
            TypedQuery<Customer> query = em.createQuery("SELECT c FROM Customer c WHERE c.nic = :nicValue", Customer.class);
            query.setParameter("nicValue", trimmedNic);

            LOGGER.log(Level.INFO, "Executing JPQL query: SELECT c FROM Customer c WHERE c.nic = {0}", trimmedNic);

            Customer customer = query.getSingleResult();

            // 3. Customer කෙනෙක් හම්බුනොත් ඒකත් log කරනවා
            if (customer != null) {
                LOGGER.log(Level.INFO, "Customer found: {0} {1}", new Object[]{customer.getFirstName(), customer.getLastName()});
            }
            return customer;

        } catch (NoResultException e) {
            // 2. Customer කෙනෙක් හම්බුනේ නැත්නම් ඒක පැහැදිලිව log කරනවා
            LOGGER.log(Level.WARNING, "No customer found in the database for NIC: {0}", trimmedNic);
            return null; // Customer හම්බුනේ නැත්නම් null return කරනවා
        } catch (Exception e) {
            // 4. වෙනත් ඕනෑම error එකක් log කරනවා
            LOGGER.log(Level.SEVERE, "An unexpected error occurred while searching for NIC: " + trimmedNic, e);
            return null;
        }
    }

    // --- Your other existing methods remain unchanged ---
    @Override
    public Customer createCustomer(Customer customer) throws BankingException {
        em.persist(customer);
        return customer;
    }

    @Override
    public Customer getCustomerById(Long customerId) {
        return em.find(Customer.class, customerId);
    }

    @Override
    public List<Customer> getAllCustomers() {
        return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
    }

    @Override
    public Customer updateCustomer(Customer customer) throws BankingException {
        return em.merge(customer);
    }

    @Override
    public void deleteCustomer(Long customerId) throws BankingException {
        Customer customer = getCustomerById(customerId);
        if (customer != null) {
            em.remove(customer);
        }
    }
}