package dat.examproject.model.entities;

public class SFList {
    private int idOrder;
    private int sfid;
    private int amount;
    // Include price and maybe some reference to a list of pieces

    public SFList(int idOrder, int sfid, int amount) {
        this.idOrder = idOrder;
        this.sfid = sfid;
        this.amount = amount;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public int getSfid(){return sfid;}

    public int getAmount() {
        return amount;
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (!(o instanceof Order)) return false;

        SFList order = (SFList) o;
        return getIdOrder() == order.getIdOrder() && getSfid() == order.getSfid() && getAmount() == order.getAmount();
    }

    @Override
    public String toString() {
        return "idOrder: " + idOrder;
    }
}
