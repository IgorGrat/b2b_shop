package socet;

import java.io.Externalizable;

public abstract class CloneAble implements Externalizable, Cloneable{
    @Override
    protected CloneAble clone() throws CloneNotSupportedException {
        return (CloneAble)super.clone();
    }
}
