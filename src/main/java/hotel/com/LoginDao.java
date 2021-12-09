package hotel.com;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
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
	
	public List<List<String>> get_rooms(String hotel_id, String room_type, String number_people, String checkin, String checkout){
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT * "
					+ "FROM rooms r "
					+ "JOIN room_type rt ON r.room_type_id=rt.room_type_id "
					+ "WHERE r.hotel_id=? "
					+ "AND rt.name=? "
					+ "AND rt.capacity>=? "
					+ "AND (r.room_number NOT IN (SELECT b.room_number FROM booking b WHERE b.check_out_date>? AND b.hotel_id=?) "
					+ "OR r.room_number NOT IN (SELECT b.room_number FROM booking b WHERE b.check_in_date<? AND b.hotel_id=?)); ";


//			System.out.println(sql);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, Integer.parseInt(hotel_id) );
			st.setString(2, room_type);
			st.setInt(3, Integer.parseInt(number_people));
			st.setDate(4, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkin)).getTime()));
			st.setInt(5, Integer.parseInt(hotel_id) );
			st.setDate(6, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkout)).getTime()));
			st.setInt(7, Integer.parseInt(hotel_id) );


			System.out.println(st);
			ResultSet rs = st.executeQuery();
			List<List<String>> ans = new LinkedList<>();

			while (rs.next()) {
				List<String> temp = new LinkedList<>();
				for(int i = 1; i < rs.getMetaData().getColumnCount();i++) {
					System.out.println(rs.getObject(i).toString());
					temp.add(rs.getObject(i).toString());
				}
				ans.add(temp);
			}
			System.out.println(ans);
			return ans;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return new LinkedList<>();
	}
	
	
	public boolean add_booking(String email, String hotel_id, String room_number, String checkin, String checkout, String number_people) {
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT * FROM booking WHERE email=? AND hotel_id=? AND room_number=? AND check_in_date=? AND check_out_date=?";

			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, email);
			st.setInt(2, Integer.parseInt(hotel_id));
			st.setInt(3, Integer.parseInt(room_number));
			st.setDate(4, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkin)).getTime()));
			st.setDate(5, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkout)).getTime()));
			ResultSet rs = st.executeQuery();
			
			if (rs.next()) {
				return false;
			}else {
				sql = "INSERT INTO booking(hotel_id, room_number, email, check_in_date, check_out_date, number_people) VALUES(?, ?, ?, ?, ?, ?);";
				PreparedStatement st2 = conn.prepareStatement(sql);
				st2.setInt(1, Integer.parseInt(hotel_id));
				st2.setInt(2, Integer.parseInt(room_number));
				st2.setString(3, email);
				st2.setDate(4, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkin)).getTime()));
				st2.setDate(5, new Date ((new SimpleDateFormat("yyyy-MM-dd").parse(checkout)).getTime()));
				st2.setInt(6, Integer.parseInt(number_people.trim()));
				System.out.println(st2);
				st2.executeUpdate();
				return true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return false;
	}

	public List<List<String>> get_booking_future(String email){
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT r.*, rt.*, b.check_out_date, b.check_in_date "
					+ "FROM rooms r "
					+ "JOIN room_type rt ON r.room_type_id=rt.room_type_id "
					+ "JOIN booking b  ON b.room_number=r.room_number AND b.hotel_id=r.hotel_id "
					+ "WHERE r.hotel_id IN (SELECT b.hotel_id FROM booking b WHERE b.email=? AND b.check_in_date>=CURRENT_DATE)"
					+ "AND r.room_number IN (SELECT b.room_number FROM booking b WHERE b.email=? AND b.check_in_date>=CURRENT_DATE);";


//			System.out.println(sql);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, email);


			System.out.println(st);
			ResultSet rs = st.executeQuery();
			List<List<String>> ans = new LinkedList<>();

			while (rs.next()) {
				List<String> temp = new LinkedList<>();
				for(int i = 1; i <= rs.getMetaData().getColumnCount();i++) {
					System.out.println(rs.getObject(i).toString());
					temp.add(rs.getObject(i).toString());
				}
				ans.add(temp);
			}
			System.out.println(ans);
			return ans;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return new LinkedList<>();
	}
	
	public List<List<String>> get_booking_history(String email){
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection(url, username, pass);
			String sql = "SELECT r.*, rt.*, b.check_out_date, b.check_in_date "
					+ "FROM rooms r "
					+ "JOIN room_type rt ON r.room_type_id=rt.room_type_id "
					+ "JOIN booking b  ON b.room_number=r.room_number AND b.hotel_id=r.hotel_id "
					+ "WHERE r.hotel_id IN (SELECT b.hotel_id FROM booking b WHERE b.email=? AND b.check_out_date<=CURRENT_DATE)"
					+ "AND r.room_number IN (SELECT b.room_number FROM booking b WHERE b.email=? AND b.check_out_date<=CURRENT_DATE);";


//			System.out.println(sql);
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, email);


			System.out.println(st);
			ResultSet rs = st.executeQuery();
			List<List<String>> ans = new LinkedList<>();

			while (rs.next()) {
				List<String> temp = new LinkedList<>();
				for(int i = 1; i <= rs.getMetaData().getColumnCount();i++) {
					System.out.println(rs.getObject(i).toString());
					temp.add(rs.getObject(i).toString());
				}
				ans.add(temp);
			}
			System.out.println(ans);
			return ans;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return new LinkedList<>();
	}
	
	public List<List<String>> get_rooms_for_desk_clerk(String hotel_id){
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);
            String sql = "SELECT * "
                    + "FROM rooms r "
                    + "JOIN booking b ON b.room_number = r.room_number "
                    + "FULL JOIN guests gs ON gs.email = b.email "
                    + "JOIN room_type rt ON r.room_type_id = rt.room_type_id "
                    + "WHERE r.hotel_id=? "
                    + "AND r.room_number IN (SELECT b.room_number FROM booking b "
                    + "WHERE b.check_in_date>=CURRENT_DATE "
                    + "AND b.hotel_id=?);";


            System.out.println(hotel_id);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(hotel_id) );
            st.setInt(2, Integer.parseInt(hotel_id) );


            System.out.println(st);
            ResultSet rs = st.executeQuery();
            List<List<String>> ans = new LinkedList<>();

            while (rs.next()) {
                List<String> temp = new LinkedList<>();
                for(int i = 1; i < rs.getMetaData().getColumnCount();i++) {
                    System.out.println(rs.getObject(i).toString());
                    temp.add(rs.getObject(i).toString());
                }
                ans.add(temp);
            }
            System.out.println(ans);
            return ans;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return new LinkedList<>();
    }
	
	public boolean checkStuff(String uname, String password) {
        try {
            String sql = "SELECT * FROM stuff WHERE email=? AND password=?";
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
    
    public List<String> get_stuff(String email){
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);
            String sql = "SELECT * FROM stuff WHERE email=?";

//            System.out.println(sql);
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
                ans.set(3, (ans.get(3).equals("nursultan")) ? "1" : "2");
                return ans;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return List.<String>of();
    }
    
    public boolean add_stuff(String fname, String lname, String position, String city, String email, String psw) {
//        this.check("","");
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);
            String sql = "SELECT * FROM stuff WHERE email=?";

//            System.out.println(sql);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return false;
            }else {
                System.out.print("The city is ");
                System.out.println(city);
                int hotel = (city.strip().equals("nursultan")) ? 1 : 2;
                sql = "INSERT INTO stuff(first_name, last_name, position, hotel_id, email, password) VALUES('"+fname+"', '"+lname+"', '"+position+"', "+hotel+", '"+email+"', '"+psw+"');";
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
    
    public boolean delete_booking(String hotel_id,String room_number) {
        System.out.println("AAAA" + room_number);
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);


             String sql = "DELETE FROM booking WHERE hotel_id = ? AND room_number = ?;";
                PreparedStatement st2 = conn.prepareStatement(sql);
                st2.setInt(1, Integer.parseInt(hotel_id));

                st2.setInt(2, Integer.parseInt(room_number));

                System.out.println(st2);
                st2.executeUpdate();
                return true;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public List<List<String>> get_Stuff(){
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);
            String sql = "SELECT first_name, last_name, position, hotel_id "
                    + "FROM stuff;";

            PreparedStatement st = conn.prepareStatement(sql);


            System.out.println(st);
            ResultSet rs = st.executeQuery();
            List<List<String>> ans = new LinkedList<>();

            while (rs.next()) {
                List<String> temp = new LinkedList<>();
                for(int i = 1; i <= rs.getMetaData().getColumnCount();i++) {
                    System.out.println(rs.getMetaData().getColumnCount());
                    System.out.println(rs.getObject(i).toString());
                    temp.add(rs.getObject(i).toString());
                }
                ans.add(temp);
            }
            System.out.println(ans);
            return ans;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return new LinkedList<>();
    }
    
    public List<List<String>> get_clean_rooms(){
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, username, pass);
            String sql = "SELECT * FROM clean_room;";

            PreparedStatement st = conn.prepareStatement(sql);


            System.out.println(st);
            ResultSet rs = st.executeQuery();
            List<List<String>> ans = new LinkedList<>();

            while (rs.next()) {
                List<String> temp = new LinkedList<>();
                for(int i = 1; i <= rs.getMetaData().getColumnCount();i++) {
                    System.out.println(rs.getMetaData().getColumnCount());
                    System.out.println(rs.getObject(i).toString());
                    temp.add(rs.getObject(i).toString());
                }
                ans.add(temp);
            }
            System.out.println(ans);
            return ans;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return new LinkedList<>();
    }
}






