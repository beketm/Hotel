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


@WebServlet("/stufflogin")
public class StuffLogin extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		System.out.println("the session's email: " + session.getAttribute("email"));
		boolean result = session.getAttribute("email") != null && session.getAttribute("email") !="wrong";
		JsonObject json = Json.createObjectBuilder().add("result", result).build();
        
		res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
		out.println(json.toString());
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String username = req.getParameter("email");
		String password = req.getParameter("password");
		System.out.println(username);
		System.out.println(password);
		
		LoginDao dao = new LoginDao();
		if (dao.checkStuff(username, password)) {
			String position = dao.get_stuff(username).get(2);
			HttpSession session = req.getSession();
			session.setAttribute("email", username);
			session.setAttribute("position", position);
			RequestDispatcher rd = req.getRequestDispatcher("stuffprofile.jsp");
			rd.forward(req, res);

		} else {
			HttpSession session = req.getSession();
			session.setAttribute("email", "wrong");
			RequestDispatcher rd = req.getRequestDispatcher("stufflogin.jsp");
			rd.forward(req, res);
		}
		

	}}
