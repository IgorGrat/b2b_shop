package enginee.processing.query;

public interface ClientManager {
    Client getClient(String login);
    void addClient(Client client);
    void removeClient(long id);
}
