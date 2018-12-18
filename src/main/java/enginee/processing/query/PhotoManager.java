package enginee.processing.query;

public interface PhotoManager {
    byte[] getPhoto(String name);
    void addPhoto(Photo photo);
    void removePhoto(long id);
}
