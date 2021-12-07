package hotel.com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashMap;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class Book extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
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
	    
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();


        JsonObject json = Json.createObjectBuilder().add("result", 123).build();
        out.println(json.toString());
	}
	
	public boolean add_booking(String input) {
		   try {
				input = java.net.URLDecoder.decode(input, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   HashMap<String, Integer> city_to_id = new HashMap<String, Integer>();
		   
		   city_to_id.put("nursultan", 1);
		   city_to_id.put("almaty", 2);
		   
		   String[] arr = Arrays.stream(input.split("&")).map(element -> element.split("=")[1]).toArray(String[]::new);
		return false;
	}
}
