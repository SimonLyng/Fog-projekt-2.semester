package dat.examproject.model.persistence;

import dat.examproject.model.entities.*;
import dat.examproject.model.exceptions.DatabaseException;

import java.sql.*;
import java.util.ArrayList;

public class OrderMapper {
    ConnectionPool connectionPool;

    public OrderMapper(ConnectionPool connectionPool)
    {
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

                    order = new Order(idOrder, idCustomer, carW, carL, tag, shedW, shedL, orderStatus);
                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return orders;
    }

    public ArrayList<Order> getAllOrders() throws DatabaseException{
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

                    order = new Order(idOrder, idCustomer, carW, carL, tag, shedW, shedL, orderStatus);
                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return orders;
    }

    public Order createOrder(int idcustomer, int carW, int carL, int rooF, int shedW, int shedL) throws DatabaseException
    {
        Order order;
        String status = "Started";

        String sql = "insert into orders (idcustomer, carw, carl, roof, shedw, shedl) values (?,?,?,?,?,?)";
        try (Connection connection = connectionPool.getConnection())
        {
            try (Statement stmt = connection.createStatement()){
                String sql2 = "alter table orders AUTO_INCREMENT = 1";
                stmt.execute(sql2);
            }
            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS))
            {
                // Comment: Change so it reads from database, when db has been created
                ps.setInt(1, idcustomer);
                // Comment: Has to be changed, either by storing lists or making more tables
                ps.setInt(2, carW);
                ps.setInt(3, carL);
                ps.setInt(4, rooF);
                ps.setInt(5, shedW);
                ps.setInt(6, shedL);
                int rowsAffected = ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();
                int idorder = rs.getInt(1);
                order = new Order(idorder, idcustomer, carW, carL, rooF, shedW, shedL, status);
            }
        }
        catch (SQLException ex)
        {
            throw new DatabaseException(ex, "Could not insert order into database");
        }
        return order;
    }

    public StykList createStykList(int idcustomer, ArrayList<Integer> idamount, ArrayList<Integer> idTree, ArrayList<Integer> idRoof,
                             ArrayList<Integer> idScrew, ArrayList<Integer> idFitting) throws DatabaseException
    {
        StykList stykList;
        String status = "Started";

        String sql = "insert into piecelist (idcustomer, idamount, idtree, idroof, idscrew, idfitting) values (?,?,?,?,?,?)";;
        try (Connection connection = connectionPool.getConnection())
        {
            try (Statement stmt = connection.createStatement()){
                String sql2 = "alter table piecelist AUTO_INCREMENT = 1";
                stmt.execute(sql2);
            }
            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS))
            {
                // Comment: Change so it reads from database, when db has been created
                ps.setInt(1, idcustomer);
                // Comment: Has to be changed, either by storing lists or making more tables
                ps.setInt(2, idamount.get(0));
                ps.setInt(3, idTree.get(0));
                ps.setInt(4, idRoof.get(0));
                ps.setInt(5, idScrew.get(0));
                ps.setInt(4, idFitting.get(0));
                int rowsAffected = ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();
                int idorder = rs.getInt(1);
                stykList = new StykList(idorder, idcustomer, idamount, idTree, idRoof, idScrew, idFitting, status);
            }
        }
        catch (SQLException ex)
        {
            throw new DatabaseException(ex, "Could not insert order into database");
        }
        return stykList;
    }

    public void updateOrders(int idCustommer, int idOrder){
        String sql = "UPDATE orders SET idcustomer = ? WHERE idorder = ?";
        try (Connection connection = connectionPool.getConnection())
        {
            try (PreparedStatement stmt = connection.prepareStatement(sql))
            {
                stmt.setInt(1, idCustommer);
                stmt.setInt(2, idOrder);
                stmt.executeUpdate();
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    public void updatePayment(int idCustommer){
        String sql = "UPDATE orders SET payment = 'paid' WHERE idcustomer = ?";
        try (Connection connection = connectionPool.getConnection())
        {
            try (PreparedStatement stmt = connection.prepareStatement(sql))
            {
                stmt.setInt(1, idCustommer);
                stmt.executeUpdate();
            }
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

}