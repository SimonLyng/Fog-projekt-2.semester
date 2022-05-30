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

class UserMapperTest
{
    private static ConnectionPool connectionPool;
    private static UserMapper userMapper;

    @BeforeAll
    public static void setUpClass() {
        connectionPool = new ConnectionPool("fogdb", "fog", "jdbc:mysql://localhost:3306/fogdb_test");
        userMapper = new UserMapper(connectionPool);
    }

    @BeforeEach
    void setUp()
    {
        try (Connection testConnection = connectionPool.getConnection()) {
            try (Statement stmt = testConnection.createStatement() ) {
                // Remove all rows from all tables
                stmt.execute("delete from user");
                stmt.execute("delete from paycard");
                // Resets the AUTO_INCREMENT of iduser
                stmt.execute("ALTER TABLE paycard AUTO_INCREMENT=1");
                // Indsæt et par brugere
                stmt.execute("insert into user (iduser, mail, password, name, phone, idcard, role) " +
                        "values (1, 'user@live.dk','1234','user',12345678,1,'user'),(0,'admin@live.dk','4321','admin',87654321,0,'admin'), " +
                        "(2,'Ben@gmail.com','1234','Ben',36795665,2,'user');");

                stmt.execute("insert into paycard (idcard, cardnr, expmonth, expyear, cvc) " +
                        "values (1, '457109', 09, 22, 561), (2, '457102',02,23,691)");
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
    void login() throws DatabaseException
    {
        User expectedUser = new User(2, "Ben@gmail.com","1234", "Ben","36795665",2, "user");
        User actualUser = userMapper.login("Ben@gmail.com","1234");
        assertEquals(expectedUser, actualUser);
    }

    @Test
    void invalidPasswordLogin() throws DatabaseException
    {
        assertThrows(DatabaseException.class, () -> userMapper.login("user@live.dk","123"));
    }

    @Test
    void invalidEmailLogin() throws DatabaseException
    {
        assertThrows(DatabaseException.class, () -> userMapper.login("bob@gmail.com","1234"));
    }

    @Test
    void createUser() throws DatabaseException
    {
        userMapper.createUser("Jill@gmail.com", "1234", "Jill", "34895662",  "user", "4571", 5, 20, 876);
        User logInUser = userMapper.login("Jill@gmail.com","1234");
        User expectedUser = new User(3, "Jill@gmail.com", "1234", "Jill", "34895662", 3, "user");
        assertEquals(expectedUser, logInUser);

    }

    @Test
    void readCustomerListTest() throws  DatabaseException{
        ArrayList<User> expectedCustomers = new ArrayList<>();
        User user1 = new User(1, "user@live.dk","1234","user","12345678",1,"user");
        User user2 = new User(2,"Ben@gmail.com","1234","Ben","36795665",2,"user");
        expectedCustomers.add(user1);
        expectedCustomers.add(user2);
        ArrayList<User> actualCustomers = userMapper.readCustomerList("user");
        for(int i = 0; i < actualCustomers.size(); i++){
            assertEquals(expectedCustomers.get(i), actualCustomers.get(i));
        }
    }
}