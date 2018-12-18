package enginee.processing.query;

public class MoneyList extends Curent_list {
    public MoneyList() {super("Report", "carencyList", new String[0]);
    }
    public String getCource(String id){
        return getValue(id)[3];
    }
    public String getShortName(String id){
        return getValue(id)[2];
    }
}
