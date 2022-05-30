package dat.examproject.persistence;

import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.ConnectionPool;
import dat.examproject.model.persistence.OrderMapper;
import dat.examproject.model.persistence.UserMapper;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class orderMapperTest
{
    private static ConnectionPool connectionPool;
    private static OrderMapper orderMapper;


    @BeforeAll
    public static void setUpClass(){
        connectionPool = new ConnectionPool("fogdb", "fog", "jdbc:mysql://localhost:3306/fogdb_test");
        orderMapper = new OrderMapper(connectionPool);
    }

    @BeforeEach
    void setUp()
    {
        try (Connection testConnection = connectionPool.getConnection()) {
            try (Statement stmt = testConnection.createStatement() ) {
                // Remove all rows from all tables
                stmt.execute("delete from orders");
                // Resets the AUTO_INCREMENT of iduser
//                // Indsæt et par brugere
//                java.sql.Date datedb = orderMapper.orderDate();
//                stmt.execute("insert into orders (idorders, idcustomer, carw, carl, roof, shedw, shedl, status, date) " +
//                        "values (1, 1, 600, 780, 1, 530, 210, 'Started', 2022-05-28),(2,2,300,500,1,250,180,'Påbegyndt',2022-05-28)");
            }
        } catch (SQLException throwables) {
            System.out.println(throwables.getMessage());
            fail("Database connection failed");
        }
    }

    @Test
    void testConnection() throws SQLException
    {
        Connection connection = connectionPool.getConnection();
        assertNotNull(connection);
        if (connection != null)
        {
            connection.close();
        }
    }

    @Test
    void getOrdersTest() throws DatabaseException{
        java.sql.Date date = orderMapper.orderDate();
        orderMapper.createOrder(1, 600, 780, 1, 530, 210, date);
        orderMapper.createOrder(2, 300, 500, 1, 250, 180, date);
        ArrayList<Order> actualOrders = orderMapper.getOrders(1);
        ArrayList<Order> expectedOrders = new ArrayList<>();
        Order order = new Order(1, 1, 600, 780, 1, 530, 210, "Started", date);
        expectedOrders.add(order);
        for(int i = 0; i < actualOrders.size(); i++){
            assertEquals(expectedOrders.get(i), actualOrders.get(i));
        }
    }

    @Test
    void updateOrder() throws DatabaseException {
        java.sql.Date date = orderMapper.orderDate();
        orderMapper.createOrder(1, 600, 780, 1, 530, 210, date);
        orderMapper.createOrder(2, 300, 500, 1, 250, 180, date);
        ArrayList<Order> update = orderMapper.updateOrder(1, 200, 550, 100, 300);
        ArrayList<Order> actualOrders = orderMapper.getOrders(1);
        ArrayList<Order> expectedOrders = new ArrayList<>();
        Order order = new Order(1, 1, 200, 550, 1, 100, 300, "Started", date);
        expectedOrders.add(order);
        for(int i = 0; i < actualOrders.size(); i++){
            assertEquals(expectedOrders.get(i), actualOrders.get(i));
        }
    }

    @Test
    void updateStatusOrder() throws DatabaseException {
        java.sql.Date date = orderMapper.orderDate();
        orderMapper.createOrder(1, 600, 780, 1, 530, 210, date);
        orderMapper.createOrder(2, 300, 500, 1, 250, 180, date);
        ArrayList<Order> update = orderMapper.updateStatusOrders("Started", 1);
        ArrayList<Order> actualOrders = orderMapper.getOrders(1);
        ArrayList<Order> expectedOrders = new ArrayList<>();
        Order order = new Order(1, 1, 600, 780, 1, 530, 210, "Påbegyndt", date);
        expectedOrders.add(order);
        for(int i = 0; i < actualOrders.size(); i++){
            assertEquals(expectedOrders.get(i), actualOrders.get(i));
        }
    }

    @Test
    void removeOrdersTest() throws DatabaseException{
        java.sql.Date date = orderMapper.orderDate();
        orderMapper.createOrder(1, 600, 780, 1, 530, 210, date);
        orderMapper.createOrder(2, 300, 500, 1, 250, 180, date);
        ArrayList<Order> remove = orderMapper.removeOrder(1, orderMapper.getAllOrders());
        ArrayList<Order> actualOrders = orderMapper.getAllOrders();
        ArrayList<Order> expectedOrders = new ArrayList<>();
        Order order = new Order(2, 2, 300, 500, 1, 250, 180, "Started", date);
        expectedOrders.add(order);
        for(int i = 0; i < actualOrders.size(); i++){
            assertEquals(expectedOrders.get(i), actualOrders.get(i));
        }
    }
}