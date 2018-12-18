package socet;

import enginee.processing.query.Client;
import enginee.processing.query.Client_Query;
import transimpex.CommandQuery;
import transimpex.Title;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class GetClientQuery {
    private List result=new ArrayList();

    public List getResult() {
        return result;
    }

    public GetClientQuery(Client client, Client_Query qr) {
        SocketTobase socket=new SocketTobase(qr.getUrl(), qr.getPort());
        String queryTime = getTimeQuery();
        List multyTask=new ArrayList();
        multyTask.add(new Title(client.getUser(), queryTime, "", (byte)1, (byte)1, (byte)12, (byte)31));
        multyTask.add(new CommandQuery(qr.getForm(), qr.getMethod(), qr.getParam()));

        QuickObjectArray array=new QuickObjectArray(new CloneAbleStringArray());
        try {
            ObjectOutputStream objectOutputStream=new ObjectOutputStream(socket.getOs());
            objectOutputStream.writeObject(multyTask);

            array.readExternal(new ObjectInputStream(socket.getIs()));
            socket.closeConnection();
            for (CloneAble cab : array.getResultList()) {
                CloneAbleStringArray casa=(CloneAbleStringArray)cab;
                result.add(casa.getResult());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private String getTimeQuery() {
        Calendar date=Calendar.getInstance();
        String h=String.valueOf(date.get(11));
        String m=String.valueOf(date.get(12));
        String s=String.valueOf(date.get(13));
        h=("00"+h).substring(h.length());
        m=("00"+m).substring(m.length());
        s=("00"+s).substring(s.length());
        return h+m+s;
    }
}
