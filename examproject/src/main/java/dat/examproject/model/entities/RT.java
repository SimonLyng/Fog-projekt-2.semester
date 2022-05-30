package dat.examproject.model.entities;

public class RT {
    private int rtid;
    private String type;
    private String description;
    private int length;
    private int amount;
    private String desc;
    private int price;
    // Include price


    public RT(int rtid, String type, String description, int length, int amount, String desc, int price) {
        this.rtid = rtid;
        this.type = type;
        this.description = description;
        this.length = length;
        this.amount = amount;
        this.desc = desc;
        this.price = price;
    }

    public int getRtid() {
        return rtid;
    }

    public void setRtid(int rtid) {
        this.rtid = rtid;
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

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getPrice() {
        return price*amount;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    //
    @Override
    public boolean equals(Object rt)
    {
        if (this == rt) return true;
        if (!(rt instanceof RT)) return false;

        RT rtList = (RT) rt;
        return getRtid() == rtList.getRtid() && getType().equals(((RT) rt).getType()) &&
                getDescription().equals(((RT) rt).getDescription()) && getLength() == ((RT) rt).getLength() &&
                getAmount() == ((RT) rt).getAmount() && getDesc().equals(((RT) rt).getDesc()) &&
                getPrice() == ((RT) rt).getPrice();
    }
}
