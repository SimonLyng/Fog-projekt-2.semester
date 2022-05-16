package dat.examproject.model.entities;

import java.util.ArrayList;

public class RTList {
    private int idOrder;
    private int rtid;
    private int amount;

    // Include price and maybe some reference to a list of pieces

    public RTList(int idOrder, int rtid, int amount) {
        this.idOrder = idOrder;
        this.rtid = rtid;
        this.amount = amount;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public int getRtid(){return rtid;}

    public int getAmount() {
        return amount;
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (!(o instanceof Order)) return false;

        RTList order = (RTList) o;
        return getIdOrder() == order.getIdOrder() && getRtid() == order.getRtid() && getAmount() == order.getAmount();
    }

    @Override
    public String toString() {
        return "idOrder: " + idOrder;
    }
}
