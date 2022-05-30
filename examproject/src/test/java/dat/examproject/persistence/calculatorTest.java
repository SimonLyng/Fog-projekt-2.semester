package dat.examproject.persistence;

import dat.examproject.model.entities.User;
import dat.examproject.model.persistence.Calculator;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class calculatorTest {

    @Test
    void testCalPosts() throws SQLException
    {
        Calculator calculator = new Calculator();
        double expectedResult = 11.0;
        double actualResult = calculator.calPost(780, true);
        assertEquals(expectedResult, actualResult);
        double actualResultNoShed = calculator.calPost(780, false);
        double expectedResultNoShed = 7;
        assertEquals(expectedResultNoShed, actualResultNoShed);
    }

    @Test
    void testCalRafters() throws SQLException
    {
        Calculator calculator = new Calculator();
        int expectedResult = 15;
        int actualResult = calculator.calRafters(780);
        assertEquals(expectedResult, actualResult);
    }

    @Test
    void testCalShedBoards() throws SQLException
    {
        Calculator calculator = new Calculator();
        int expectedResult = 200;
        int actualResult = calculator.calShedBoards(210, 530);
        assertEquals(expectedResult, actualResult);
    }

    void testCalStern(int expectedL, int expectedS, int length, int materialL, int materialS, int times) throws SQLException
    {
        Calculator calculator = new Calculator();

        Map<String, Integer> actualResult = calculator.calMultiple(length, materialL, materialS, times);
        assertEquals(expectedL, actualResult.get("long"));
        assertEquals(expectedS, actualResult.get("short"));
    }

    @Test
    void testCalSterns() throws SQLException{
        // 25x200mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 4, 600, 540, 360, 2);

        // Understående er forskellig fra given materialle liste, men burde være mere korrekt?
        // 25x200mm. trykimp. Brædt, Længde: 540
        testCalStern(2, 2, 780, 540, 360, 2);

        // 25x125mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 2, 600, 540, 360, 1);

        // Samme som ved 25x200mm. Længde: 540
        // 25x125mm. trykimp. Brædt, Længde: 540
        testCalStern(2, 2, 780, 540, 360, 2);

        // 45x95 mm. Reglar ub., Længde 270 (løsholt gavl)
        testCalStern(12, 0, 530, 270, 240, 6);

        // 45x95 mm. Reglar ub., Længde 240 (løsholt sider)
        testCalStern(0, 4, 210, 270, 240, 4);

        // 45x195 mm. spærtræ ubh. Længde: 2x240 (480)
        testCalStern(0, 1, 420, 600, 480, 1);

        // Samme argument som tidligere
        // 19x100mm. trykimp. Brædt, Længde: 540
        testCalStern(2, 2, 780, 540, 360, 2);

        // 19x100mm. trykimp. Brædt, Længde: 360
        testCalStern(0, 2, 600, 540, 360, 1);
    }

    @Test
    void testCalRoof(){
        Calculator calculator = new Calculator();
        int expectedResult = 10;
        Map<String, Integer> actualResult = calculator.calRoof(600, 780);
        assertEquals(expectedResult, actualResult.get("long"));
        expectedResult = 0;
        assertEquals(expectedResult, actualResult.getOrDefault("short", 0));
    }

    @Test
    void testCalScrews(){
        Calculator calculator = new Calculator();
        ArrayList<Integer> expectedAmount = new ArrayList<>(
                Arrays.asList(3,2,15,15,1,3,18,12,2,2,1,2,32)
        );
        ArrayList<Integer> actualResult = calculator.calScrews(600, 780);
        for(int i = 0; i < actualResult.size(); i++){
            assertEquals(expectedAmount.get(i), actualResult.get(i));
        }
    }
}
