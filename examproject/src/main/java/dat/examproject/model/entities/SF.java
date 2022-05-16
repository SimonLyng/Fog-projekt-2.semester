package dat.examproject.model.entities;

public class SF {
    private int sfid;
    private String type;
    private String description;
    private String unit;
    private int amount;
    // Include price


    public SF(int sfid, String type, String description, String unit, int amount) {
        this.sfid = sfid;
        this.type = type;
        this.description = description;
        this.unit = unit;
        this.amount = amount;
    }

    public int getSfid() {
        return sfid;
    }

    public void setSfid(int sfid) {
        this.sfid = sfid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

//    @Override
//    public boolean equals(Object o)
//    {
//        if (this == o) return true;
//        if (!(o instanceof Order)) return false;
//
//        RTList order = (RTList) o;
//        return getIdOrder() == order.getIdOrder() && getRtid() == order.getRtid() && getAmount() == order.getAmount();
//    }
}
