package dat.examproject.persistence;

import dat.examproject.model.entities.RT;
import dat.examproject.model.entities.SF;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.ConnectionPool;
import dat.examproject.model.persistence.StykListMapper;
import dat.examproject.model.persistence.UserMapper;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;

public class StykListMapperTest {

    private final static String USER = "root";
    private final static String PASSWORD = "Dreng127";
    private final static String URL = "jdbc:mysql://localhost:3306/testingtest";

    private static ConnectionPool connectionPool;
    private static StykListMapper stykListMapper;

    @BeforeAll
    public static void setUpClass() {
        connectionPool = new ConnectionPool(USER, PASSWORD, URL);
        stykListMapper = new StykListMapper(connectionPool);
    }

    @BeforeEach
    void setUp()
    {
        try (Connection testConnection = connectionPool.getConnection()) {
            try (Statement stmt = testConnection.createStatement() ) {
                // Remove all rows from all tables
                stmt.execute("delete from rtpiecelist");
                stmt.execute("delete from sfpiecelist");
                // Resets the AUTO_INCREMENT of iduser
                stmt.execute("ALTER TABLE rtpiecelist AUTO_INCREMENT=1");
                stmt.execute("ALTER TABLE sfpiecelist AUTO_INCREMENT=1");
                // Indsæt et par brugere
//                for(int i = 1; i <= 15; i++){
//                    stmt.execute("insert into rtpiecelist (orderid, rtid, amount) " +
//                            "values (1,i,2),(2,i,3)");
//                }
//                for(int i = 1; i <= 13; i++){
//                    stmt.execute("insert into sfpiecelist (orderid, rtid, amount) " +
//                            "values (1,i,2),(2,i,3)");
//                }
//                stmt.execute("insert into rtpiecelist (orderid, rtid, amount) " +
//                        "values (1,1,2),(2,1,3)");
//                stmt.execute("insert into sfpiecelist (orderid, sfid, amount) " +
//                        "values (1,1,2),(2,1,3),(2,2,3)");
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
    void getRT() throws DatabaseException
    {
        int rtid = 1;
        String type = "tree";
        String description = "25x200 mm. trykimp. Brædt";
        int length = 360;
        int amount = 3;
        ArrayList<RT> actualList = stykListMapper.getRT(2);
        assertEquals(rtid, actualList.get(0).getRtid());
        assertEquals(type, actualList.get(0).getType());
        assertEquals(description, actualList.get(0).getDescription());
        assertEquals(length, actualList.get(0).getLength());
        assertEquals(amount, actualList.get(0).getAmount());
        for(RT r : actualList){
            System.out.println("id: "+r.getRtid()+" type: "+r.getType()+" description: "+r.getDescription()+" length: "+r.getLength()+" amount: "+r.getAmount());
        }
    }

    @Test
    void getSF() throws DatabaseException
    {
        ArrayList<Integer> expectedIds = new ArrayList<>(
                Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13)
        );
        ArrayList<String> expectedType = new ArrayList<>(
                Arrays.asList("skrue", "beslag", "beslag", "beslag", "skrue", "skrue", "skrue", "beslag", "skrue", "skrue", "beslag", "beslag", "beslag")
        );
        ArrayList<String> expectedDescreption = new ArrayList<>(
                Arrays.asList("plastmo bundskruer 200 stk.", "hulbånd 1x20 mm. 10 mtr.", "universal 190 mm. højre", "universal 190 mm. venstre", "4,5x60 mm. skruer 200 stk.", "4,0x50 mm. beslagskruer 250 stk.", "bræddebolt 10x120 mm.", "firkantskiver 40x40x11 mm.", "4,5x70 mm. Skruer 400 stk.", "4,5x50 mm. Skruer 300 stk.", "stalddørsgreb 50x75", "t hængsel 390 mm.", "vinkelbeslag 35")
        );
        ArrayList<String> expectedUnit = new ArrayList<>(
                Arrays.asList("pakke", "rulle", "stk", "stk", "pakke", "pakke", "stk", "stk", "pakke", "pakke", "sæt", "stk", "stk")
        );
        ArrayList<Integer> expectedAmount = new ArrayList<>(
                Arrays.asList(3,3,3,3,3,3,3,3,3,3,3,3,3)
        );

        ArrayList<SF> actualList = stykListMapper.getSF(2);
        for(int i = 0; i < actualList.size(); i++){
            assertEquals(expectedIds.get(i), actualList.get(i).getSfid());
            assertEquals(expectedType.get(i), actualList.get(i).getType());
            assertEquals(expectedDescreption.get(i), actualList.get(i).getDescription());
            assertEquals(expectedUnit.get(i), actualList.get(i).getUnit());
            assertEquals(expectedAmount.get(i), actualList.get(i).getAmount());
        }
//        for(SF s : actualList){
//            System.out.println("id: "+s.getSfid()+" type: "+s.getType()+" description: "+s.getDescription()+" Unit: "+s.getUnit()+" amount: "+s.getAmount());
//        }
    }

    @Test
    void createRT() throws DatabaseException {
        int excpectedId = 1;
        String expectedType = "tree";
        String expectedDescription = "25x200 mm. trykimp. Brædt";
        int expectedLength = 360;
        int amount = 5;
        stykListMapper.createRT(3, 1, 5, "Hej");
        ArrayList<RT> actualList = stykListMapper.getRT(3);
        assertEquals(excpectedId, actualList.get(0).getRtid());
        assertEquals(expectedType, actualList.get(0).getType());
        assertEquals(expectedDescription, actualList.get(0).getDescription());
        assertEquals(expectedLength, actualList.get(0).getLength());
        assertEquals(amount, actualList.get(0).getAmount());
    }

    @Test
    void createStykListe() throws DatabaseException {
        stykListMapper.createStykList(4, 780, 600, 210, 530);
    }
}
