package lk.jiat.banking.mdb;

import jakarta.ejb.MessageDriven;
import jakarta.jms.MessageListener;
import jakarta.jms.Message;

@MessageDriven(name = "NotificationMDB", mappedName = "BankingQueue")
public class NotificationMDB implements MessageListener {
    // EJB implementation
    public void onMessage(Message message) {
        // ...
    }
}
