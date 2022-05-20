package dat.examproject.model.entities;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Order {
    private int idOrder;
    private int idCustomer;
    private int carportBred;
    private int carportLængde;
    private int tag;
    private int skurBred;
    private int skurLængde;
    private String orderStatus;
    private java.sql.Date date;
    // Include price and maybe some reference to a list of pieces


    public Order(int idOrder, int idCustomer, int carportBred, int carportLængde, int tag, int skurBred, int skurLængde, String orderStatus) {
        this.idOrder = idOrder;
        this.idCustomer = idCustomer;
        this.carportBred = carportBred;
        this.carportLængde = carportLængde;
        this.tag = tag;
        this.skurBred = skurBred;
        this.skurLængde = skurLængde;
        this.orderStatus = orderStatus;
    }



    public Date getDate() {
        return date;
    }

    public void setDate(java.sql.Date date) {
        this.date = date;
    }

    public String dateToString(){
        DateFormat formatD = new SimpleDateFormat("dd/MMM/yyyy");
        String dateFormat = formatD.format(this.date);
        return dateFormat;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public int getIdCustomer() {
        return idCustomer;
    }

    public int getCarportBred() {
        return carportBred;
    }

    public int getCarportLængde() {
        return carportLængde;
    }

    public int getTag() {
        return tag;
    }

    public int getSkurBred() {
        return skurBred;
    }

    public int getSkurLængde() {
        return skurLængde;
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

        Order order = (Order) o;
        return getIdOrder() == order.getIdOrder() && getIdCustomer() == order.getIdCustomer() &&
                getCarportBred() == order.getCarportBred() && getCarportLængde() == order.getCarportLængde() &&
                getTag() == order.getTag() && getSkurBred() == order.getSkurBred() && getSkurLængde() == order.getSkurLængde() &&
                getOrderStatus().equals(((Order) o).getOrderStatus());
    }

    @Override
    public String toString() {
        return "idOrder: " + idOrder +
                " | idCustomer: " + idCustomer +
                " ´| orderStatus: " + orderStatus;
    }
}
