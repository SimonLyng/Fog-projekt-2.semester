package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.StykList;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.OrderMapper;
import dat.examproject.model.persistence.ConnectionPool;
import dat.examproject.model.persistence.StykListMapper;

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

@WebServlet(name = "styklist", urlPatterns = {"/styklist"} )
public class StykListServlet extends HttpServlet
{
    private ConnectionPool connectionPool;

    @Override
    public void init() throws ServletException
    {
        this.connectionPool = ApplicationStart.getConnectionPool();
    }

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
        ArrayList<Order> orders = new ArrayList<>();
        OrderMapper orderMapper = new OrderMapper(connectionPool);
        // If any orders has been made, in the time the user has been on the website, this will get those orders
        // Gets orders
        if (session.getAttribute("orders") != null) {
            orders = (ArrayList<Order>) session.getAttribute("orders");
        }
        else {
            session.setAttribute("orders", null);
        }
        StykListMapper stykListMapper = new StykListMapper(connectionPool);

        session = request.getSession();
        int orderID = Integer.parseInt(request.getParameter("orderid"));
        Order order = null;
        try {
            StykList stykList = stykListMapper.readStykList(orderID);
            for(Order o : orders){
                if(o.getIdOrder() == orderID){
                    order = o;
                }
            }
            session.setAttribute("sf", stykList.getSfList());
            session.setAttribute("rt", stykList.getRtList());
            session.setAttribute("temporder", order);
        }
        catch (DatabaseException e)
        {
            Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
            request.setAttribute("errormessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        request.getRequestDispatcher("piecelist.jsp").forward(request, response);
    }

    public void destroy()
    {

    }
}
