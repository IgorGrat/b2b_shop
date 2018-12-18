package socet;

import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketTimeoutException;

public class SocketTobase {
    private Socket socket;
    private InputStream is;
    private OutputStream os;

    public void closeConnection() {
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public SocketTobase(@NotNull String url, int port) {
        try {
            this.socket =  new Socket( url, port);
            socket.setSoTimeout(2000);
        } catch (SocketTimeoutException ste) {
            ste.printStackTrace();
        }catch (IOException e ){
            e.printStackTrace();
        }
    }

    public InputStream getIs() {
        try {
            return socket.getInputStream();
        } catch (IOException e) {
            e.printStackTrace(); return null;
        }
    }

    public OutputStream getOs() {
        try {
            return socket.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace(); return null;
        }
    }
}
