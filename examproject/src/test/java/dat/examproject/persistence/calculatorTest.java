package dat.examproject.persistence;

import dat.examproject.model.entities.User;
import dat.examproject.model.persistence.Calculator;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

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

    @Test
    void testCalLooseWood() throws SQLException
    {
        Calculator calculator = new Calculator();
        double expectedResult = 12.0;
        double actualResult = calculator.calLooseWoodGavl(7.8);
        assertEquals(expectedResult, actualResult);
        expectedResult = 4;
    }
}
