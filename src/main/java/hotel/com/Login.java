package hotel.com;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;


@WebServlet("/login")
public class Login extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		boolean result = session.getAttribute("email") != null;
		JsonObject json = Json.createObjectBuilder().add("result", result).build();
        
		res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
		out.println(json.toString());
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String username = req.getParameter("email");
		String password = req.getParameter("password");
		
		LoginDao dao = new LoginDao();
		dao.check(username, password);
		
		if (dao.check(username, password)) {
			HttpSession session = req.getSession();
			session.setAttribute("email", username);
			RequestDispatcher rd = req.getRequestDispatcher("profile.jsp");
			rd.forward(req, res);

		}else {
			HttpSession session = req.getSession();
			session.setAttribute("email", "wrong");
			RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
			rd.forward(req, res);
		}
		

	}}
