package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.OrderMapper;
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

@WebServlet(name = "removeorder", urlPatterns = {"/removeorder"} )
public class RemoveOrder extends HttpServlet {
    private ConnectionPool connectionPool;

    @Override
    public void init() throws ServletException {
        this.connectionPool = ApplicationStart.getConnectionPool();
    }

    // Comment: change USER, URL & Password to the correct database, when that's done
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // You shouldn't end up here with a GET-request, thus you get sent back to frontpage
        doPost(request, response);
        response.sendRedirect("index.jsp");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        OrderMapper orderMapper = new OrderMapper(connectionPool);
        ArrayList<Order> orders = new ArrayList<>();
        // If any orders has been made, in the time the user has been on the website, this will get those orders
        // Gets orders
        if (session.getAttribute("orders") != null) {
            orders = (ArrayList<Order>) session.getAttribute("orders");
        } else {
            session.setAttribute("orders", null);
        }
        int idOrder = Integer.parseInt(request.getParameter("OrderID"));

        try {
            orders = orderMapper.removeOrder(idOrder, orders);
            session = request.getSession();
            session.setAttribute("orders", orders);
        } catch (DatabaseException e)
        {
            Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
            request.setAttribute("errormessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        if(request.getParameter("pageHidden").equals("orders")) {
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        }
        else {
            request.getRequestDispatcher("adminOrders.jsp").forward(request, response);
        }
    }
}
