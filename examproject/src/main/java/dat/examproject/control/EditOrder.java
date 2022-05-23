package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.ConnectionPool;
import dat.examproject.model.persistence.OrderMapper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "editorder", value = "/editorder")
public class EditOrder extends HttpServlet {
    
    private ConnectionPool connectionPool;
    
    @Override
    public void init() throws ServletException
    {
        this.connectionPool = ApplicationStart.getConnectionPool();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idOrder = Integer.parseInt(request.getParameter("idOrder"));
        int carW = Integer.parseInt(request.getParameter("carW"));
        int carL = Integer.parseInt(request.getParameter("carL"));
        int shedW = Integer.parseInt(request.getParameter("shedW"));
        int shedL = Integer.parseInt(request.getParameter("shedL"));
    
        OrderMapper orderMapper = new OrderMapper(connectionPool);
        try {
            ArrayList<Order> orders = orderMapper.updateOrder(idOrder, carW, carL, shedW, shedL);
            request.getSession().setAttribute("orders", orders);
            ArrayList<ArrayList<Order>> compiledOrders = orderMapper.ordersByStatus(orders);
            request.getSession().setAttribute("compiledOrders", compiledOrders);
        } catch (DatabaseException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("adminOrders.jsp").forward(request, response);
    }
}
