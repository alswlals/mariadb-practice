package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class UpdateTest02 {

	public static void main(String[] args) {
		DeptVo vo = new DeptVo();
		vo.setNo(1L);
		vo.setName("경영지원");
		
		Boolean result = update(vo);
		System.out.println(result ? "성공":"실패");

	}

	private static Boolean update(DeptVo vo) {
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
					" update dept" + 
					"   set name = ?" + 
					" where no= ?";
			pstmt = conn.prepareStatement(sql);
			
			//4. binding
			pstmt.setString(1, vo.getName());
			pstmt.setLong(2, vo.getNo());
			
			
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
