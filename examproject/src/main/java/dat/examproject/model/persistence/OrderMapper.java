package dat.examproject.model.persistence;

import dat.examproject.model.entities.*;
import dat.examproject.model.exceptions.DatabaseException;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class OrderMapper {
    ConnectionPool connectionPool;

    public OrderMapper(ConnectionPool connectionPool) {
        this.connectionPool = connectionPool;
    }

    public ArrayList<Order> getOrders(int idCustomer) throws DatabaseException {
        ArrayList<Order> orders = new ArrayList<>();
        Order order = null;
        int idOrder;
        int carW;
        int carL;
        int tag;
        int shedW;
        int shedL;
        String orderStatus;
        java.sql.Date date;

        String sql = "SELECT * FROM orders WHERE idcustomer = ?";

        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, idCustomer);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    idOrder = rs.getInt("idorders");
                    carW = rs.getInt("carw");
                    carL = rs.getInt("carl");
                    tag = rs.getInt("roof");
                    shedW = rs.getInt("shedw");
                    shedL = rs.getInt("shedl");
                    orderStatus = rs.getString("status");
                    date = rs.getDate("date");

                    order = new Order(idOrder, idCustomer, carW, carL, tag, shedW, shedL, orderStatus, date);
                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return orders;
    }

    public ArrayList<Order> getAllOrders() throws DatabaseException {
        ArrayList<Order> orders = new ArrayList<>();
        Order order;

        int idOrder;
        int idCustomer;
        int carW;
        int carL;
        int tag;
        int shedW;
        int shedL;
        String orderStatus;
        java.sql.Date date;

        String sql = "SELECT * FROM orders";

        try (Connection connection = connectionPool.getConnection()) {

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    idOrder = rs.getInt("idorders");
                    idCustomer = rs.getInt("idcustomer");
                    carW = rs.getInt("carw");
                    carL = rs.getInt("carl");
                    tag = rs.getInt("roof");
                    shedW = rs.getInt("shedw");
                    shedL = rs.getInt("shedl");
                    orderStatus = rs.getString("status");
                    date = rs.getDate("date");

                    order = new Order(idOrder, idCustomer, carW, carL, tag, shedW, shedL, orderStatus, date);
                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return orders;
    }

    public Order createOrder(int idcustomer, int carW, int carL, int rooF, int shedW, int shedL, java.sql.Date date) throws DatabaseException {
        Order order;
        String status = "Started";

        String sql = "insert into orders (idcustomer, carw, carl, roof, shedw, shedl, date) values (?,?,?,?,?,?,?)";
        try (Connection connection = connectionPool.getConnection()) {
            try (Statement stmt = connection.createStatement()) {
                String sql2 = "alter table orders AUTO_INCREMENT = 1";
                stmt.execute(sql2);
            }
            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                // Comment: Change so it reads from database, when db has been created
                ps.setInt(1, idcustomer);
                // Comment: Has to be changed, either by storing lists or making more tables
                ps.setInt(2, carW);
                ps.setInt(3, carL);
                ps.setInt(4, rooF);
                ps.setInt(5, shedW);
                ps.setInt(6, shedL);
                ps.setDate(7, date);
                int rowsAffected = ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();
                int idorder = rs.getInt(1);
                order = new Order(idorder, idcustomer, carW, carL, rooF, shedW, shedL, status, date);
            }
        } catch (SQLException ex) {
            throw new DatabaseException(ex, "Could not insert order into database");
        }
        return order;
    }

    public void updateOrders(int idCustommer, int idOrder) {
        String sql = "UPDATE orders SET idcustomer = ? WHERE idorder = ?";
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, idCustommer);
                stmt.setInt(2, idOrder);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public ArrayList<Order> updateStatusOrders(String statuS, int idOrder) throws DatabaseException {
        String sql = "UPDATE orders SET status = ? WHERE idorders = ?";
        String newStatus = statuS;
        ArrayList<Order> output = new ArrayList<>();
        if (newStatus.equals("Started")) {
            newStatus = "Påbegyndt";
        } else {
            newStatus = "Færdigt";
        }
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, newStatus);
                stmt.setInt(2, idOrder);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        output = getAllOrders();
        return output;
    }

    public void updatePayment(int idCustommer) {
        String sql = "UPDATE orders SET payment = 'paid' WHERE idcustomer = ?";
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, idCustommer);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public ArrayList<Order> removeOrder(int idOrder, ArrayList<Order> orders) throws DatabaseException {
        String sql = "DELETE FROM orders WHERE idorders = ?";
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, idOrder);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            throw new DatabaseException(ex, "Noget");
        }
        sql = "DELETE FROM rtpiecelist WHERE orderid = ?";
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, idOrder);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            throw new DatabaseException(ex, "Noget");
        }
        sql = "DELETE FROM sfpiecelist WHERE orderid = ?";
        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, idOrder);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            throw new DatabaseException(ex, "Noget");
        }
        orders.removeIf(order -> order.getIdOrder() == idOrder);
        System.out.println("hi med dig");
        return orders;
    }

    public java.sql.Date orderDate() throws DatabaseException {
        //java.util.Date date = new java.util.Date();
        //Calendar calendar = Calendar.getInstance();
        long milli = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(milli);
        return date;
    }


    public ArrayList<ArrayList<Order>> ordersByStatus(ArrayList<Order> orders){
        ArrayList<ArrayList<Order>> compiledOrders = new ArrayList<>();
        compiledOrders.add(new ArrayList<>());
        compiledOrders.add(new ArrayList<>());
        compiledOrders.add(new ArrayList<>());
        for(Order o : orders){
            if(o.getOrderStatus().equals("Started")){
                compiledOrders.get(0).add(o);
            }
            else if(o.getOrderStatus().equals("Påbegyndt")){
                compiledOrders.get(1).add(o);
            }
            else{
                compiledOrders.get(2).add(o);
            }
        }
        return compiledOrders;
    }



}