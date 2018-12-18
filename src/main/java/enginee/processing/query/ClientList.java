package enginee.processing.query;

import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ClientList implements ClientManager {

    private static Map<String, Client>list=new HashMap<String, Client>();
    private static boolean refresh=true;
    @Autowired
    private EntityManager entityManager;

    @Override
    public Client getClient(String login) {
        if(refresh) {
            javax.persistence.Query query = entityManager.createQuery("SELECT a FROM Client a", Client.class);
            list.clear();
            for (Client client : (List<Client>) query.getResultList()) {
                list.put(client.getLogin(), client);
            }
        }refresh=false;
        return list.get(login);
    }

    @Override
    public void addClient(Client client) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(client);
            entityManager.getTransaction().commit();
            refresh=true;
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void removeClient(long id) {
        try {
            entityManager.getTransaction().begin();
            Client client = entityManager.find(Client.class, id);
            entityManager.remove(client);
            entityManager.getTransaction().commit();
            refresh=true;
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }
}
