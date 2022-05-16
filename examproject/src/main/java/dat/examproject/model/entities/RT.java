package dat.examproject.model.entities;

public class RT {
    private int rtid;
    private String type;
    private String description;
    private int length;
    private int amount;
    private String desc;
    // Include price


    public RT(int rtid, String type, String description, int length, int amount, String desc) {
        this.rtid = rtid;
        this.type = type;
        this.description = description;
        this.length = length;
        this.amount = amount;
        this.desc = desc;
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

    //
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
