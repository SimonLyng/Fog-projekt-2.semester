package dat.examproject.model.entities;

import java.util.ArrayList;

public class StykList {
    private int idOrder;
    private int idCustomer;
    private ArrayList<Integer> amount;
    private ArrayList<Integer> treeid;
    private ArrayList<Integer> roofid;
    private ArrayList<Integer> screwid;
    private ArrayList<Integer> fittingid;
    private String orderStatus;
    // Include price and maybe some reference to a list of pieces

    public StykList(int idOrder, int idCustomer, ArrayList<Integer> amount, ArrayList<Integer> treeid, ArrayList<Integer> roofid, ArrayList<Integer> screwid, ArrayList<Integer> fittingid, String orderStatus) {
        this.idOrder = idOrder;
        this.idCustomer = idCustomer;
        this.amount = amount;
        this.treeid = treeid;
        this.roofid = roofid;
        this.screwid = screwid;
        this.fittingid = fittingid;
        this.orderStatus = orderStatus;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public int getIdCustomer() {
        return idCustomer;
    }

    public ArrayList<Integer> getAmount() {
        return amount;
    }

    public ArrayList<Integer> getTreeid() {
        return treeid;
    }

    public ArrayList<Integer> getRoofid() {
        return roofid;
    }

    public ArrayList<Integer> getScrewid() {
        return screwid;
    }

    public ArrayList<Integer> getFittingid() {
        return fittingid;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public boolean arrayEquals(ArrayList<Integer> a, ArrayList<Integer> b){
        boolean outcome = true;
        if(a.size() == b.size()){
            for(int i = 0; i < a.size(); i++){
                if(a.get(i) != b.get(i)){
                    outcome = false;
                }
            }
        }
        else{
            outcome = false;
        }
        return outcome;
    }
    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (!(o instanceof Order)) return false;

        StykList order = (StykList) o;
        return getIdOrder() == order.getIdOrder() && getIdCustomer() == order.getIdCustomer() &&
                arrayEquals(getTreeid(), order.getTreeid()) == true && getRoofid().equals(order.getTreeid()) &&
                arrayEquals(getRoofid(), order.getRoofid()) == true && arrayEquals(getAmount(), order.getAmount()) == true &&
                arrayEquals(getFittingid(), order.getFittingid()) == true && arrayEquals(getScrewid(), order.getScrewid()) == true &&
                getOrderStatus().equals(((Order) o).getOrderStatus());
    }

    @Override
    public String toString() {
        return "idOrder: " + idOrder +
                " | idCustomer: " + idCustomer +
                " ´| orderStatus: " + orderStatus;
    }
}
