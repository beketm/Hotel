package hotel.com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.json.Json;
import javax.json.JsonObject;


@WebServlet("/signup")
public class Signup extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    StringBuilder sb = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    try {
	        String line;
	        while ((line = reader.readLine()) != null) {
	            sb.append(line).append('\n');
	        }
	    } finally {
	        reader.close();
	    }
	    System.out.println(sb.toString());
	    
	    boolean result = add_g(sb.toString());
	    System.out.println("This email is free: " + result);
//	    boolean result = true;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();


        JsonObject json = Json.createObjectBuilder().add("result", result).build();
        out.println(json.toString());
//        out.flush();
	    
	}
	
	public boolean add_g(String text) {
		String[] arr = Arrays.stream(text.split("&")).map(element -> element.split("=")[1]).toArray(String[]::new);
		LoginDao dao = new LoginDao();
		return dao.add_guest(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6].replace("%40", "@"), arr[7]);
	}
	
	
}
