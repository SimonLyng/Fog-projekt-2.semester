package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.OrderMapper;
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

@WebServlet(name = "addorder", urlPatterns = {"/addorder"} )
public class AddOrder extends HttpServlet
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
        session.setAttribute("orders", null);


        OrderMapper orderMapper = new OrderMapper(connectionPool);
        session = request.getSession();
        int carportBred = Integer.parseInt(request.getParameter("carW2"));
        int carportLængde = Integer.parseInt(request.getParameter("carL2"));
        int tag = Integer.parseInt(request.getParameter("roof2"));
        int skurBred = Integer.parseInt(request.getParameter("shedW2"));
        int skurLængde = Integer.parseInt(request.getParameter("shedL2"));
        if(session.getAttribute("user") != null){
            User user = (User) session.getAttribute("user");
            try {
                Order order = orderMapper.createOrder(user.getIdUser(), carportBred, carportLængde, tag, skurBred, skurLængde);
                orders.add(order);
                session.setAttribute("orders", orders);
            }
            catch (DatabaseException e)
            {
                Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
                request.setAttribute("errormessage", e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
        else{
            try {
                // Comment: Lav det om, så brugeren automatisk logger ind / opretter konto, ved oprettelse af forespørgsel
                // tjek først om brugeren eksisterer i systemet -> kald derefter på Login/Create account, baseret på om brugeren
                // Eksisterede i systemet eller ikke -> Tilføj dernæst ordren til den bruger
                // Comment: Placeholder createOrder
                Order order = orderMapper.createOrder(0, carportBred, carportLængde, tag, skurBred, skurLængde);
                orders.add(order);
                session.setAttribute("orders", orders);
            }
            catch (DatabaseException e)
            {
                Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
                request.setAttribute("errormessage", e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    public void destroy()
    {

    }
}
