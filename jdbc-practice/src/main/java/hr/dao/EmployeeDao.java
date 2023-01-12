package hr.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hr.vo.EmployeeVo;

public class EmployeeDao {
	public List<EmployeeVo> findByName(String keyword) {
		List<EmployeeVo> result = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			
			String url = "jdbc:mariadb://192.168.10.114:3307/employees?charset=utf8";
			conn = DriverManager.getConnection(url, "hr", "hr");
			
			String sql =
					"select emp_no, first_name, last_name, date_format(hire_date, '%Y-%m-%d')"+
					" from employees "+
					" where first_name like ?"+
					" or last_name like ?";
			
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			

			rs = pstmt.executeQuery();
			

			while(rs.next()) {
				Long no = rs.getLong(1); //이름 적어줘도 됨 rs.getLong('emp_no');
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				String hireDate = rs.getString(4);
				
				EmployeeVo vo = new EmployeeVo();
				
				vo.setNo(no);
				vo.setFirstName(firstName);
				vo.setLastName(lastName);
				vo.setHireDate(hireDate);
				
				result.add(vo);
			}
			
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading error:" + e);
		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
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
