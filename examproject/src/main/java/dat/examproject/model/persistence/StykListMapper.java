package dat.examproject.model.persistence;

import dat.examproject.model.entities.*;
import dat.examproject.model.exceptions.DatabaseException;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.TreeMap;

public class StykListMapper {
    ConnectionPool connectionPool;

    public StykListMapper(ConnectionPool connectionPool)
    {
        this.connectionPool = connectionPool;
    }

    public ArrayList<RT> getRT(int idOrder) throws DatabaseException {
        ArrayList<RT> roofTree = new ArrayList<>();
        RT rt;
        int rtid;
        String type;
        String description;
        int length;
        int amount;
        String desc;

        String sql = "SELECT rtpiecelist.rtid AS id, rtpiecelist.amount AS amount, rtpiecelist.description AS text, rt.type AS type, rt.description AS " +
                "description, rt.length AS length FROM rtpiecelist INNER JOIN rt ON rtpiecelist.rtid = rt.idrt AND " +
                "rtpiecelist.orderid = ?";

        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, idOrder);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    rtid = rs.getInt("id");
                    type = rs.getString("type");
                    description = rs.getString("description");
                    length = rs.getInt("length");
                    amount = rs.getInt("amount");
                    desc = rs.getString("text");

                    rt = new RT(rtid, type, description, length, amount, desc);
                    roofTree.add(rt);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return roofTree;
    }

    public ArrayList<SF> getSF(int idOrder) throws DatabaseException {
        ArrayList<SF> screwFitting = new ArrayList<>();
        SF sf = null;
        int sfid;
        String type;
        String description;
        String unit;
        int amount;

        String sql = "SELECT sfpiecelist.sfid AS id, sfpiecelist.amount AS amount, sf.type AS type, sf.description AS " +
                "description, sf.unit AS unit FROM sfpiecelist INNER JOIN sf ON sfpiecelist.sfid = sf.idsf AND " +
                "sfpiecelist.orderid = ?";

        try (Connection connection = connectionPool.getConnection()) {
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, idOrder);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    sfid = rs.getInt("id");
                    type = rs.getString("type");
                    description = rs.getString("description");
                    unit = rs.getString("unit");
                    amount = rs.getInt("amount");

                    sf = new SF(sfid, type, description, unit, amount);
                    screwFitting.add(sf);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            throw new DatabaseException(ex.getMessage());
        }
        return screwFitting;
    }

    public void createRT(int idOrder, int rtid, int amount, String description) throws DatabaseException
    {

        String sql = "insert into rtpiecelist (orderid, rtid, amount, description) values (?,?,?,?)";
        try (Connection connection = connectionPool.getConnection())
        {
            try (PreparedStatement ps = connection.prepareStatement(sql))
            {
                System.out.println(idOrder +", "+rtid+", "+amount+", "+description);
                ps.setInt(1, idOrder);
                ps.setInt(2, rtid);
                ps.setInt(3, amount);
                ps.setString(4, description);
                ps.executeUpdate();
            }
        }
        catch (SQLException ex)
        {
            throw new DatabaseException(ex, "Could not insert material into database");
        }
    }

    public void createSF(int idOrder, int sfid, int amount) throws DatabaseException
    {

        String sql = "insert into sfpiecelist (orderid, sfid, amount) values (?,?,?)";
        try (Connection connection = connectionPool.getConnection())
        {
            try (PreparedStatement ps = connection.prepareStatement(sql))
            {
                ps.setInt(1, idOrder);
                ps.setInt(2, sfid);
                ps.setInt(3, amount);
                ps.executeUpdate();
            }
        }
        catch (SQLException ex)
        {
            throw new DatabaseException(ex, "Could not insert material into database");
        }
    }

    public void createStykList(int idOrder, int carLength, int carWidth, int shedLength, int shedWidth) throws DatabaseException {

        Calculator calculator = new Calculator();
        ArrayList<RTList> rtLists = new ArrayList<>();
        RTList rt;
        ArrayList<SFList> sfLists = new ArrayList<>();
        boolean shed = true;
        if(shedLength < 1 || shedWidth < 1){
            shed = false;
        }

        // Understernbrædder til for og bag ende
        rtLists.addAll(entry(calculator.calMultiple(carWidth, 540, 360, 2),
                idOrder, 2, 1, "understernbrædder til for & bag ende"));
        // Understernbræder til siderne
        rtLists.addAll(entry(calculator.calMultiple(carLength, 540, 360, 2),
                idOrder, 2, 1, "understernbrædder til siderne"));
        // Oversternbrædder til forenden
        rtLists.addAll(entry(calculator.calMultiple(carWidth, 540, 360, 1),
                idOrder, 4, 3, "oversternbrædder til forenden"));
        // Oversternbrædder til siderne
        rtLists.addAll(entry(calculator.calMultiple(carLength, 540, 360, 2),
                idOrder, 4, 3, "oversternbrædder til siderne"));
        if(shed == true){
            // Til z på bagside af dør
            rt = new RTList(idOrder, 5, 1);
            createRT(idOrder, 5, 1, "til z på bagside af dør");
            // Tilføj message
            rtLists.add(rt);
            // løsholter til skur gavle
            rtLists.addAll(entry(calculator.calMultiple(shedWidth, 270, 240, 6),
                    idOrder, 6, 7, "løsholter til skur gavle"));// løsholter til skur gavle
            // løsholter til skur side
            rtLists.addAll(entry(calculator.calMultiple(shedLength, 270, 240, 4),
                    idOrder, 6, 7, "løsholter til skur sider"));
            // Remme i sider (skur)
            rtLists.addAll(entry(calculator.calMultiple(shedLength*2, 600, 480, 1),
                    idOrder, 8, 9, "Remme i sider, sadles ned i stopler (skur del, deles)"));
//            rtLists.addAll(entry(calculator.calMultiple(shedLength, 300, 240, 1),
//                    idOrder, 8, 9, "Remme i sider, sadles ned i stopler (skur del, deles)"));
            // Bræder til beklædning af skur 1 på 2
            rt = new RTList(idOrder, 11, calculator.calShedBoards(shedLength, shedWidth));
            createRT(idOrder, 11, rt.getAmount(), "til beklædning af skur 1 på 2");
            // Tilføj message
            rtLists.add(rt);
        }
        // Remme i sider (carport)
        rtLists.addAll(entry(calculator.calMultiple(carLength-shedLength, 600, 480, 2),
                idOrder, 8, 9, "Remme i sider, sadles ned i stopler"));
        // Spær
        rtLists.addAll(entry(calculator.calMultiple(carWidth, 600, 480, calculator.calRafters(carLength)),
                idOrder, 8, 9, "Spær, monteres på rem"));
        rt = new RTList(idOrder, 10, calculator.calPost(carLength, shed));
        createRT(idOrder, 10, rt.getAmount(), "Stolper nedgraves 90 cm. i jord");
        // Tilføj message
        rtLists.add(rt);
        // Vandbrædt sider
        rtLists.addAll(entry(calculator.calMultiple(carLength, 540, 360, 2),
                idOrder, 12, 13, "vandbrædt på stern i sider"));
        // Oversternbrædder til siderne
        rtLists.addAll(entry(calculator.calMultiple(carWidth, 540, 360, 1),
                idOrder, 12, 13, "vandbrædt på stern i forende"));
        // Tagplader
        rtLists.addAll(entry(calculator.calRoof(carWidth, carLength),
                idOrder, 14, 15, "tagplader monteres på spær"));

        //Skruer og hæng
        ArrayList<Integer> screwFittingids = new ArrayList<>(
                Arrays.asList(1,2,3,4,5,6,7,8,9,10,11,12,13)
        );
        for(int i = 1; i <= screwFittingids.size(); i++){
            SFList sf = new SFList(idOrder, i, calculator.calScrews(carWidth, carLength).get(i-1));
            createSF(idOrder, i, calculator.calScrews(carWidth, carLength).get(i-1));
            sfLists.add(sf);
        }

    }
    public ArrayList<RTList> entry(Map<String, Integer> mapEntry, int idOrder, int idLong, int idShort, String message) throws DatabaseException {
        ArrayList<RTList> rtLists = new ArrayList<>();
        RTList rtEntry;
        int longAmount = mapEntry.getOrDefault("long", 0);
        int shortAmount = mapEntry.getOrDefault("short", 0);
        if(longAmount > 0){
            rtEntry = new RTList(idOrder, idLong, longAmount);
            createRT(idOrder, idLong, longAmount, message);
            rtLists.add(rtEntry);
        }
        if(shortAmount > 0){
            System.out.println("Her 1:" + idShort);
            rtEntry = new RTList(idOrder, idShort, shortAmount);
            System.out.println("Her 2:");
            createRT(idOrder, idShort, shortAmount, message);
            System.out.println("Her 3:");
            // I RT tilføj også beskrivelse, således at message1 og 2 kan bruges
            rtLists.add(rtEntry);
        }
        return rtLists;
    }

    public StykList readStykList(int idOrder) throws DatabaseException {
        StykList stykList = new StykList(getRT(idOrder), getSF(idOrder));
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
}
