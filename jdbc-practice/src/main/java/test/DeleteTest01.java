package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class DeleteTest01 {

	public static void main(String[] args) {
		boolean result = delete(5L);
		System.out.println(result ? "성공" : "실패");
	}

	private static boolean delete(long no) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			/* 1. JDBC Driver Class Loading*/
			Class.forName("org.mariadb.jdbc.Driver");
			
			/* 2. 연결하기*/
			String url = "jdbc:mariadb://192.168.10.114:3307/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			/* 3. Statement 생성*/
			
			String sql =
					" delete" + 
					" from dept" + 
					" where no= ?" ;
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩
			 pstmt.setLong(1, no);
			
			/* 4. SQL 생성*/
			
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
