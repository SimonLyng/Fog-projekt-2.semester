package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.StykList;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.OrderMapper;
import dat.examproject.model.persistence.StykListMapper;
import dat.examproject.model.persistence.UserMapper;
import dat.examproject.model.persistence.ConnectionPool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "login", urlPatterns = {"/login"} )
public class Login extends HttpServlet
{
    private ConnectionPool connectionPool;

    @Override
    public void init() throws ServletException
    {
        this.connectionPool = ApplicationStart.getConnectionPool();
    }

    // Comment: change USER, URL & Password to the correct database, when that's done
    private static String USER = "fogdb";
    private static String PASSWORD = "fog";
    private static String URL = "jdbc:mysql://localhost:3306/testing";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        // You shouldn't end up here with a GET-request, thus you get sent back to frontpage
        doPost(request, response);
        response.sendRedirect("index.jsp");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        session.setAttribute("user", null); // adding empty user object to session scope
        UserMapper userMapper = new UserMapper(connectionPool);
        StykListMapper stykListMapper = new StykListMapper(connectionPool);
        ArrayList<Order> orders = new ArrayList<>();
        ArrayList<User> customers;

        session.setAttribute("customers", null);
        // If any orders has been made, in the time the user has been on the website, this will get those orders
        // Gets orders
        if (session.getAttribute("orders") != null) {
            orders = (ArrayList<Order>) session.getAttribute("orders");
        }
        else {
            session.setAttribute("orders", null);
        }
        OrderMapper orderMapper = new OrderMapper(connectionPool);
        String username = request.getParameter("email");
        String password = request.getParameter("password");

        try
        {
            User user = userMapper.login(username, password);
            session = request.getSession();
            session.setAttribute("user", user); // adding user object to session scope
            if(user.getRole().equalsIgnoreCase("user")) {
                session = request.getSession();
                for(Order o : orders){
                    orderMapper.updateOrders(user.getIdUser(), o.getIdOrder());
                }
                ArrayList<Order> previousOrders = orderMapper.getOrders(user.getIdUser());
                session.setAttribute("orders", previousOrders);
                StykList stykList = stykListMapper.readStykList(user.getIdUser());
                session.setAttribute("rt", stykList.getRtList());
                session.setAttribute("sf", stykList.getSfList());
            }
            else if(user.getRole().equalsIgnoreCase("admin")){
                ArrayList<Order> allOrders = orderMapper.getAllOrders();
                ArrayList<ArrayList<Order>> compiledOrders = orderMapper.ordersByStatus(allOrders);
                session.setAttribute("orders", allOrders);
                session.setAttribute("compiledOrders", compiledOrders);
                customers = userMapper.readCustomerList("user");
                session.setAttribute("customers", customers);
            }
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        catch (DatabaseException e)
        {
            Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
            request.setAttribute("errormessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void destroy()
    {

    }
}