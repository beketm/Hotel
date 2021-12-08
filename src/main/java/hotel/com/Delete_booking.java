package hotel.com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class Delete_booking extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
	    
	    boolean result = add_booking(sb.toString());
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder job = Json.createObjectBuilder();
        job.add("result", result);

        JsonObject json = job.build();
        out.println(json.toString());
	}
	
	public boolean add_booking(String input) {
		System.out.println(input);
		
		String[] text = input.split("&");
		LoginDao dao = new LoginDao();
		
		System.out.println(text);
		return dao.delete_booking(text[1], text[2]);
		
	}
}