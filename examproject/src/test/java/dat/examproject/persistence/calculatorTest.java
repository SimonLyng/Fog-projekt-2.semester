package dat.examproject.persistence;

import dat.examproject.model.entities.User;
import dat.examproject.model.persistence.Calculator;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class calculatorTest {

    @Test
    void testCalPosts() throws SQLException
    {
        Calculator calculator = new Calculator();
        double expectedResult = 11.0;
        double actualResult = calculator.calPost(7.8, true);
        assertEquals(expectedResult, actualResult);
        double actualResultNoShed = calculator.calPost(8.7, false);
        double expectedResultNoShed = 7;
        assertEquals(expectedResultNoShed, actualResultNoShed);
    }

    @Test
    void testCalRafters() throws SQLException
    {
        Calculator calculator = new Calculator();
        double expectedResult = 15.0;
        double actualResult = calculator.calRafters(7.8);
        assertEquals(expectedResult, actualResult);
/*        double actualResultNoShed = calculator.calPost(8.7, false);
        double expectedResultNoShed = 7;
        assertEquals(expectedResultNoShed, actualResultNoShed);*/
    }

    @Test
    void testCalShedBoards() throws SQLException
    {
        Calculator calculator = new Calculator();
        double expectedResult = 200.0;
        double actualResult = calculator.calShedBoards(2.1, 5.3);
        assertEquals(expectedResult, actualResult);
    }

//    @Test
//    void testCalLooseWood() throws SQLException
//    {
//        Calculator calculator = new Calculator();
//        double expectedResult = 12.0;
//        double actualResult = calculator.calLooseWoodGavl(7.8);
//        assertEquals(expectedResult, actualResult);
//        expectedResult = 4;
//    }

    @Test
    void testCalStern(double expectedL, double expectedS, double length, double materialL, double materialS, int times) throws SQLException
    {
        Calculator calculator = new Calculator();

        Map<String, Double> actualResult = calculator.calLooseWoodGavl(length, materialL, materialS, times);
        assertEquals(expectedL, actualResult.get("long"));
        assertEquals(expectedS, actualResult.get("short"));
    }

    @Test
    void testCalSterns() throws SQLException{
        // 25x200mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 4.0, 6, 5.4, 3.6, 2);

        // Understående er forskellig fra given materialle liste, men burde være mere korrekt?
        // 25x200mm. trykimp. Brædt, Længde: 540
        testCalStern(2.0, 2.0, 7.8, 5.4, 3.6, 2);

        // 25x125mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 2.0, 6.0, 5.4, 3.6, 1);

        // Samme som ved 25x200mm. Længde: 540
        // 25x125mm. trykimp. Brædt, Længde: 540
        testCalStern(2.0, 2.0, 7.8, 5.4, 3.6, 2);

        // 45x95 mm. Reglar ub., Længde 270 (løsholt gavl)
        testCalStern(12.0, 0.0, 5.3, 2.7, 2.4, 6);

        // 45x95 mm. Reglar ub., Længde 240 (løsholt sider)
        testCalStern(0.0, 4.0, 2.1, 2.7, 2.4, 4);

        // 45x195 mm. spærtræ ubh. Længde: 2x240 (480)
        testCalStern(0, 1.0, 4.2, 6.0, 4.8, 1);

        // Samme argument som tidligere
        // 19x100mm. trykimp. Brædt, Længde: 540
        testCalStern(2.0, 2.0, 7.8, 5.4, 3.6, 2);

        // 19x100mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 2.0, 6.0, 5.4, 3.6, 1);
    }

    @Test
    void testCalRoof(){
        Calculator calculator = new Calculator();
        double expectedResult = 10.0;
        Map<String, Double> actualResult = calculator.calRoof(6.0, 7.8);
        assertEquals(expectedResult, actualResult.get("long"));
        expectedResult = 0.0;
        assertEquals(expectedResult, actualResult.getOrDefault("short", 0.0));
    }

    @Test
    void testCalScrews(){
        Calculator calculator = new Calculator();
        double expectedResult = 3.0;
        Map<Integer, Double> actualResult = calculator.calScrews(6.0, 7.8);
        assertEquals(expectedResult, actualResult.get(1));
        expectedResult = 2.0;
        assertEquals(expectedResult, actualResult.get(2));
    }
}
