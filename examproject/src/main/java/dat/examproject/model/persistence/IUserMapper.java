package dat.examproject.model.persistence;

import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;

import java.util.ArrayList;

public interface IUserMapper
{
    public User login(String email, String kodeord) throws DatabaseException;
    public void createUser(String mail, String password, String name, int phone, String role,
                           int cardNr, int expMonth, int expYear, int cvc) throws DatabaseException;
    public ArrayList<User> readCustomerList(String role) throws DatabaseException;
}
