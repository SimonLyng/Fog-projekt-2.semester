package dat.examproject.control;

import dat.examproject.model.config.ApplicationStart;
import dat.examproject.model.entities.Order;
import dat.examproject.model.entities.StykList;
import dat.examproject.model.entities.User;
import dat.examproject.model.exceptions.DatabaseException;
import dat.examproject.model.persistence.ConnectionPool;
import dat.examproject.model.persistence.OrderMapper;
import dat.examproject.model.persistence.StykListMapper;
import dat.examproject.model.persistence.UserMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "createaccount", urlPatterns = {"/createaccount"} )
public class CreateAccount extends HttpServlet {
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

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        session.setAttribute("user", null); // adding empty user object to session scope
        UserMapper userMapper = new UserMapper(connectionPool);
        ArrayList<Order> orders = new ArrayList<>();
        // If any orders has been made, in the time the user has been on the website, this will get those orders
        // Gets orders
        if (session.getAttribute("orders") != null) {
            orders = (ArrayList<Order>) session.getAttribute("orders");
        } else {
            session.setAttribute("orders", null);
        }

        int carportBred = 0;
        int carportLængde = 0;
        int tag = 0;
        int skurBred = 0;
        int skurLængde = 0;

        OrderMapper orderMapper = new OrderMapper(connectionPool);
        StykListMapper stykListMapper = new StykListMapper(connectionPool);
/*        String button = request.getParameter("createButton");
        System.out.println(button);*/
        //Sikre sig om hvorvidt request kommer fra index.jsp eller createAccount.jsp
        if (request.getParameter("pageHidden").equals("index")) {
            System.out.println("Inde her");
            carportBred = Integer.parseInt(request.getParameter("carW"));
            carportLængde = Integer.parseInt(request.getParameter("carL"));
            tag = Integer.parseInt(request.getParameter("roof"));
            skurBred = Integer.parseInt(request.getParameter("shedW"));
            skurLængde = Integer.parseInt(request.getParameter("shedL"));
        }

        String email = request.getParameter("createEmail");
        String password = request.getParameter("createPassword");
        String name = request.getParameter("createName");
        String phone = request.getParameter("createPhone");
        String cardNr = request.getParameter("createCardNr");
        int expMonth;
        int expYear;
        int cvc;
//        try {
//            expMonth = Integer.parseInt(request.getParameter("createExpMonth"));
//            expYear = Integer.parseInt(request.getParameter("createExpYear"));
//            cvc = Integer.parseInt(request.getParameter("createCvc"));
//        } catch (NumberFormatException ex) {
//            request.setAttribute("errormessage", ex.getMessage());
//            request.getRequestDispatcher("error.jsp").forward(request, response);
//        }

        try {
            expMonth = Integer.parseInt(request.getParameter("createExpMonth"));
            expYear = Integer.parseInt(request.getParameter("createExpYear"));
            cvc = Integer.parseInt(request.getParameter("createCvc"));
            try {
                // Comment: Lav således at, hvis en bruger skriver samme e-mail og adgangskode, kaldes login istedet
                // og hvis en e-mail angives, som allerede eksisterer, skal den lave en exception
                userMapper.createUser(email, password, name, phone, "user", cardNr, expMonth, expYear, cvc);
                User user = userMapper.login(email, password);
                session = request.getSession();
                session.setAttribute("user", user); // adding user object to session scope
                //addOrder.doPost(request, response);
                if (request.getParameter("pageHidden").equals("index")) {
                    java.sql.Date date = orderMapper.orderDate();
                    Order order = orderMapper.createOrder(user.getIdUser(), carportBred, carportLængde, tag, skurBred, skurLængde, date);
                    orders.add(order);
                    session.setAttribute("orders", orders);
                    String dateLast = order.dateToString();
                    session.setAttribute("date", dateLast);
                    stykListMapper.createStykList(order.getIdOrder(), carportLængde, carportBred, skurLængde, skurBred);
                    StykList stykList = stykListMapper.readStykList(order.getIdOrder());
                    int price = stykListMapper.calcPrice(stykList.getRtList(), stykList.getSfList());
                    System.out.println("Price: "+price+" rt: "+stykList.getRtList().size()+" sf: "+stykList.getSfList().size());
                    session.setAttribute("rt", stykList.getRtList());
                    session.setAttribute("sf", stykList.getSfList());
                    session.setAttribute("price", price);
                    request.getRequestDispatcher("orderAccept.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } catch (DatabaseException e) {
                Logger.getLogger("web").log(Level.SEVERE, e.getMessage());
                request.setAttribute("errormessage", e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
        catch (NumberFormatException ex) {
            request.setAttribute("errormessage", ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void destroy()
    {

    }
}
