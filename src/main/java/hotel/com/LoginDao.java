package hotel.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class LoginDao {
	
	String url = "jdbc:postgresql://localhost:5432/hotel";
	String username = "postgres";
	String pass = "12345";
	String sql = "SELECT * FROM guests";
	
	public boolean check(String uname, String password) {
		try {
			String sql = "SELECT * FROM guests WHERE email=? AND password=?";
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, uname);
			st.setString(2, password);
			ResultSet rs = st.executeQuery();
			
			if (rs.next()) {
				return true;
			}
			return false;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	public List<String> get_guest(String email){
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT * FROM guests WHERE email=?";

//			System.out.println(sql);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			
			while (rs.next()) {
				List<String> ans = new LinkedList<>();
				for(int i = 2; i < rs.getMetaData().getColumnCount()-1;i++) {
					System.out.println(rs.getObject(i).toString());
					ans.add(rs.getObject(i).toString());
				}
				System.out.println(ans);
				return ans;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return List.<String>of();
	}
	
	public boolean add_guest(String fname, String lname, String passport_number, String address, String home_phone_number, String mobile_phone_number, String email, String psw) {
//		this.check("","");
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT * FROM guests WHERE email=?";

//			System.out.println(sql);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			
			if (rs.next()) {
				return false;
			}else {
				sql = "INSERT INTO guests(first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES('"+fname+"', '"+lname+"', '"+passport_number+"', '"+address+"', '"+home_phone_number+"', '"+mobile_phone_number+"', '"+email+"', '"+psw+"');";
				System.out.println(sql);
				Statement st2 = conn.createStatement();
				st2.executeUpdate(sql);
				return true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		return false;
	}
}
