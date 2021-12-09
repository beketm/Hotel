package hotel.com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/searchStuff")
public class GetStuff extends HttpServlet {
//	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		LoginDao dao = new LoginDao();
//	    StringBuilder sb = new StringBuilder();
//	    BufferedReader reader = request.getReader();
//	    try {
//	        String line;
//	        while ((line = reader.readLine()) != null) {
//	            sb.append(line).append('\n');
//	        }
//	    } finally {
//	        reader.close();
//	    }
//	    String time = request.getParameter("time");
//
//    	List<List<String>> result = dao.get_booking_future(request.getSession().getAttribute("email").toString());
//	    if (time.equals("history")) {
//	    	result = dao.get_booking_history(request.getSession().getAttribute("email").toString());
//	    }
//	    
//	    response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        PrintWriter out = response.getWriter();
//        JsonObjectBuilder job = Json.createObjectBuilder();
//        int i = 0;
//        for(List<String> list: result) {
//        	job.add(i+"", list.toString().replace("]", "").replace("[", ""));
//        	i++;
//        }
//
//        JsonObject json = job.build();
//        out.println(json.toString());
//	}
	
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
	    List<List<String>> result = get_booking(sb.toString());
	    System.out.println(result);
	    
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder job = Json.createObjectBuilder();
        int i = 0;
        for(List<String> list: result) {
        	job.add(i+"", list.toString().replace("]", "").replace("[", ""));
        	i++;
        }

        JsonObject json = job.build();
        out.println(json.toString());
	}
	
	public List<List<String>> get_booking(String input) {
		   try {
				input = java.net.URLDecoder.decode(input, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   LoginDao dao = new LoginDao();
		   List<List<String>> ans = dao.get_Stuff();
		   return ans;
	}
}
