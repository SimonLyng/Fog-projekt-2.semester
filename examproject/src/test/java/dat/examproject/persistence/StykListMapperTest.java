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
                stmt.execute("insert into rtpiecelist (orderid, rtid, amount, description) " +
                        "values (2,1,4,'understernbrædder til for & bag ende'),(2,2,2,'understernbrædder til siderne'),(2,1,2,'understernbrædder til siderne')," +
                        "(2,3,2,'oversternbrædder til forenden'),(2,4,2,'oversternbrædder til siderne'),(2,3,2,'oversternbrædder til siderne')," +
                        "(2,5,1,'til z på bagside af dør'),(2,6,12,'løsholter til skur gavle'),(2,7,4,'løsholter til skur sider')," +
                        "(2,9,1,'Remme i sider, sadles ned i stopler (skur del, deles)'),(2,11,200,'til beklædning af skur 1 på 2')," +
                        "(2,8,2,'Remme i sider, sadles ned i stopler'),(2,8,15,'Spær, monteres på rem'),(2,10,11,'Stolper nedgraves 90 cm. i jord')," +
                        "(2,12,2,'vandbrædt på stern i sider'),(2,13,2,'vandbrædt på stern i sider'),(2,13,2,'vandbrædt på stern i forende')," +
                        "(2,14,10,'tagplader monteres på spær')");

                stmt.execute("insert into sfpiecelist (orderid, sfid, amount) " +
                        "values (2,1,3),(2,2,2),(2,3,15),(2,4,15),(2,5,1),(2,6,3),(2,7,18),(2,8,12),(2,9,2),(2,10,2),(2,11,1),(2,12,2),(2,13,32)");
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
        ArrayList<RT> expectedList = new ArrayList<>();
        int price = (int) (165.39);
        RT rt1 = new RT(1, "tree", "25x200 mm. trykimp. Brædt", 360, 4, "understernbrædder til for & bag ende", price);
        price = (int) (248.08);
        RT rt2 = new RT(2, "tree", "25x200 mm. trykimp. Brædt", 540, 2, "understernbrædder til siderne", price);
        price = (int) (165.39);
        RT rt3 = new RT(1, "tree", "25x200 mm. trykimp. Brædt", 360, 2, "understernbrædder til siderne", price);
        price = (int) (71.79);
        RT rt4 = new RT(3, "tree", "25x125 mm. trykimp. Brædt", 360, 2, "oversternbrædder til forenden", price);
        price = (int) (107.71);
        RT rt5 = new RT(4, "tree", "25x125 mm. trykimp. Brædt", 540, 2, "oversternbrædder til siderne", price);
        price = (int) (71.79);
        RT rt6 = new RT(3, "tree", "25x125 mm. trykimp. Brædt", 360, 2, "oversternbrædder til siderne", price);
        price = (int) (75.39);
        RT rt7 = new RT(5, "tree", "38x73 mm. Lægte ubh.", 420, 1, "til z på bagside af dør", price);
        price = (int) (61.39);
        RT rt8 = new RT(6, "tree", "45x95 mm. Reglar ub.", 270, 12, "løsholter til skur gavle", price);
        price = (int) (53.98);
        RT rt9 = new RT(7, "tree", "45x95 mm. Reglar ub.", 240, 4, "løsholter til skur sider", price);
        price = (int) (280.8);
        RT rt10 = new RT(9, "tree", "45x195 mm. spærtræ ubh.", 480, 1, "Remme i sider, sadles ned i stopler (skur del, deles)", price);
        price = (23);
        RT rt11 = new RT(11, "tree", "19x100 mm. trykimp. Brædt", 210, 200, "til beklædning af skur 1 på 2", price);
        price = (int) (386.94);
        RT rt12 = new RT(8, "tree", "45x195 mm. spærtræ ubh.", 600, 2, "Remme i sider, sadles ned i stopler", price);
        price = (int) (386.94);
        RT rt13 = new RT(8, "tree", "45x195 mm. spærtræ ubh.", 600, 15, "Spær, monteres på rem", price);
        price = (int) (155.55);
        RT rt14 = new RT(10, "tree", "97x97 mm. trykimp. stolpe", 300, 11, "Stolper nedgraves 90 cm. i jord", price);
        price = (int) (59.13);
        RT rt15 = new RT(12, "tree", "19x100 mm. trykimp. Brædt", 540, 2, "vandbrædt på stern i sider", price);
        price = (int) (39.43);
        RT rt16 = new RT(13, "tree", "19x100 mm. trykimp. Brædt", 360, 2, "vandbrædt på stern i sider", price);
        price = (int) (39.43);
        RT rt17 = new RT(13, "tree", "19x100 mm. trykimp. Brædt", 360, 2, "vandbrædt på stern i forende", price);
        price = (int) (289.75);
        RT rt18 = new RT(14, "roof", "Plastmo Ecolite blåtonet", 600, 10, "tagplader monteres på spær", price);
        expectedList.add(rt1);
        expectedList.add(rt2);
        expectedList.add(rt3);
        expectedList.add(rt4);
        expectedList.add(rt5);
        expectedList.add(rt6);
        expectedList.add(rt7);
        expectedList.add(rt8);
        expectedList.add(rt9);
        expectedList.add(rt10);
        expectedList.add(rt11);
        expectedList.add(rt12);
        expectedList.add(rt13);
        expectedList.add(rt14);
        expectedList.add(rt15);
        expectedList.add(rt16);
        expectedList.add(rt17);
        expectedList.add(rt18);
        ArrayList<RT> actualList = stykListMapper.getRT(2);
        for(int i = 0; i < expectedList.size(); i++){
            assertEquals(actualList.get(i), expectedList.get(i));
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
                Arrays.asList(3,2,15,15,1,3,18,12,2,2,1,2,32)
        );
        ArrayList<Integer> expectedPrice = new ArrayList<>(
                Arrays.asList(229,109,(int) 21.2,(int) 21.2,195,169,(int) 18.5,124,(int) 169.34,(int) 84.63,123,(int) 79.89,(int) 1.95)
        );
        ArrayList<SF> expectedList = new ArrayList<>();
        for(int i = 0; i < expectedIds.size(); i++){
            SF sf = new SF(expectedIds.get(i), expectedType.get(i), expectedDescreption.get(i), expectedUnit.get(i), expectedAmount.get(i), expectedPrice.get(i));
            expectedList.add(sf);
        }

        ArrayList<SF> actualList = stykListMapper.getSF(2);
        for(int i = 0; i < actualList.size(); i++){
            assertEquals(expectedList.get(i), actualList.get(i));
        }
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
}
