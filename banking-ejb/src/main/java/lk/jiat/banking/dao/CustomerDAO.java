package lk.jiat.banking.dao;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.banking.entities.Customer;

import java.util.List;

@Stateless
public class CustomerDAO {

    @PersistenceContext(unitName = "bankingPU")
    private EntityManager em;

    public void save(Customer customer) {
        em.persist(customer);
    }

    public Customer findById(Long id) {
        return em.find(Customer.class, id);
    }

    public List<Customer> findAll() {
        return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
    }

    public void update(Customer customer) {
        em.merge(customer);
    }

    public void delete(Customer customer) {
        em.remove(em.contains(customer) ? customer : em.merge(customer));
    }
}