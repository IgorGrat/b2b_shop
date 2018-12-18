package socet;

import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.util.ArrayList;
import java.util.List;

public class QuickObjectArray {

    private List<CloneAble> result;
    private CloneAble mask;

    public QuickObjectArray(CloneAble mask){
        result=new ArrayList<CloneAble>();
        this.mask=mask;
    }
    public void writeExternal(ObjectOutput out){}

    public void readExternal(ObjectInput in) {
        try {
            int size=in.readInt();
            for (int i = 0; i <size ; i++) {
                CloneAble CloneAble = mask.clone();
                CloneAble.readExternal(in);
                result.add(CloneAble);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    public List<CloneAble> getResultList(){
        return result;
    }
}
