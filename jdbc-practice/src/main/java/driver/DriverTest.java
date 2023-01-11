package driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DriverTest {

	public static void main(String[] args) {
		Connection conn = null;
		try {
			/* 1. JDBC Driver Class Loading*/
			Class.forName("driver.MyDriver");
			
			/* 2. 연결하기*/
			String url = "jdbc:mydb://127.0.0.1:2204/webdb";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			System.out.println("연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading error:" + e);
		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		}

	}

}
