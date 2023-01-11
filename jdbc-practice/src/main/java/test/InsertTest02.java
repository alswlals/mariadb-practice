package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class InsertTest02 {

	public static void main(String[] args) {
		insert("기획2팀");
		
	}

	private static boolean insert(String deptName) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			/* 1. JDBC Driver Class Loading*/
			Class.forName("org.mariadb.jdbc.Driver");
			
			/* 2. 연결하기*/
			String url = "jdbc:mariadb://192.168.10.114:3307/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			/* 3. Statement 준비*/
			String sql =
					" insert" + 
					"  into dept" + 
					" values (null, ?)";
			pstmt = conn.prepareStatement(sql);
			
			/* 4. binding*/
			pstmt.setString(1, deptName);
			
			/* 4. SQL 실행*/
			int count = pstmt.executeUpdate(sql);
			
			/* 5. 결과 처리*/
			result = count == 1;
			
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading error:" + e);
		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		}
		return result;
	}

}
