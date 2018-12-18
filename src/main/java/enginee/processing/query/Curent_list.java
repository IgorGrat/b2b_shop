package enginee.processing.query;

import socet.GetClientQuery;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

public class Curent_list {
    private HashMap<String, String[]>src=new HashMap<String, String[]>();
    private long lastTimeGetList;
    private long timePeriod =0;
    private String form;
    private String method;
    private String[] param;


    public Curent_list(String form, String method, String[] param) {
        this.form = form;
        this.method = method;
        this.param = param;
        updateSrc();
    }
    public String[] getValue(String val){
        if(timePeriod!=0 &&  (Calendar.getInstance().getTimeInMillis()-lastTimeGetList)> timePeriod){
            updateSrc();
        }return src.get(val);
    }
    public void setTimePeriod(long timePeriod) {
        this.timePeriod = timePeriod;
    }
    private void updateSrc(){
        GetClientQuery getClientQuery=new GetClientQuery(
                new Client(),
                new Client_Query(form, method, param));
        src.clear();
        for(String[] val :  (ArrayList<String[]>)getClientQuery.getResult()){
            src.put(val[0], val);
        }lastTimeGetList = Calendar.getInstance().getTimeInMillis();
    }
}
