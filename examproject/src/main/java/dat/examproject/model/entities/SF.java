package dat.examproject.model.entities;

public class SF {
    private int sfid;
    private String type;
    private String description;
    private String unit;
    private int amount;
    private int price;
    // Include price


    public SF(int sfid, String type, String description, String unit, int amount, int price) {
        this.sfid = sfid;
        this.type = type;
        this.description = description;
        this.unit = unit;
        this.amount = amount;
        this.price = price;
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

    public int getPrice() {
        return price*amount;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public boolean equals(Object sf)
    {
        if (this == sf) return true;
        if (!(sf instanceof SF)) return false;

        SF sfList = (SF) sf;
        return getSfid() == sfList.getSfid() && getType().equals(((SF) sf).getType()) &&
                getDescription().equals(((SF) sf).getDescription()) && getUnit().equals(((SF) sf).getUnit()) &&
                getAmount() == ((SF) sf).getAmount() && getPrice() == ((SF) sf).getPrice();
    }
}
