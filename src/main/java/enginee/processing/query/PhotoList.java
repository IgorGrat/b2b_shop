package enginee.processing.query;

import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.EntityManager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PhotoList implements PhotoManager {
    private static Map<String, Photo> list=new HashMap<String, Photo>();
    private static boolean refresh=true;

    @Autowired
    private EntityManager entityManager;

    @Override
    public byte[] getPhoto(String name) throws NullPointerException{
        if(refresh) {
            javax.persistence.Query query = entityManager.createQuery("SELECT a FROM Photo a", Photo.class);
            list.clear();
            for (Photo photo : (List<Photo>) query.getResultList()) {
                list.put(photo.getName(), photo);
            }
        }refresh=false;
        Photo photo=list.get(name);
        return photo==null? null : photo.getBody();
    }

    @Override
    public void addPhoto(Photo photo) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(photo);
            entityManager.getTransaction().commit();
            refresh=true;
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void removePhoto(long id) {
        try {
            entityManager.getTransaction().begin();
            Photo photo = entityManager.find(Photo.class, id);
            entityManager.remove(photo);
            entityManager.getTransaction().commit();
            refresh=true;
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }
}
