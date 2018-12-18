package socet;

import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;

public class CloneAbleStringArray extends CloneAble {
    private String[] result;
    @Override
    public void writeExternal(ObjectOutput out) throws IOException {

    }

    @Override
    public String toString() {
        StringBuffer sbf=new StringBuffer();
        if(result!=null){
            for (String st : result) {
                sbf.append(st)
                .append(" ");
            }
        }return sbf.toString();
    }

    @Override
    public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
        result=new String[in.readInt()];
        for (int i = 0; i <result.length ; i++) {
            result[i]=in.readUTF();
        }
    }
    public String[] getResult() {
        return result;
    }
}
