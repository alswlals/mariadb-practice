package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrdersVo;

public class OrdersDao {
	public void insert(OrdersVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;

		try {
			conn = getConnection();

			String sql ="insert into orders values(null,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getPrice());
			pstmt.setString(2, vo.getAddress());
			pstmt.setLong(3, vo.getUserNo());
			pstmt.setString(4, vo.getOrderNo());
			pstmt.executeUpdate();

			String sql2 ="insert into order_book values (null, ?, ?, ?)";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, vo.getCount());
			pstmt2.setLong(2, vo.getBookNo());
			pstmt2.setLong(3, vo.getNo());
			pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (pstmt2 != null) {
					pstmt2.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	

	}

	public List<OrdersVo> findAll() {
		List<OrdersVo> result = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			String sql =

					"SELECT o.order_no, u.name, u.email, o.price, o.address"+
					" from orders o, user u" +
					" where o.user_no = u.no";
					
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrdersVo vo = new OrdersVo();
				
				vo.setOrderNo(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setEmail(rs.getString(3));
				vo.setPrice(rs.getInt(4));
				vo.setAddress(rs.getString(5));
				
				result.add(vo);
			}

		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return result;
	}

	public List<OrdersVo> findOrderBook() {
		List<OrdersVo> result = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			String sql =

					"select b.no, b.title, ob.count "
					+ "from book b join order_book ob on b.no = ob.no";
					
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrdersVo vo = new OrdersVo();
				
				vo.setBookNo(rs.getLong(1));
				vo.setBookName(rs.getString(2));
				vo.setCount(rs.getInt(3));
				
				result.add(vo);
			}

		} catch (SQLException e) {
			System.out.println("Error:" + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return result;
	}
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;

		try {
			Class.forName("org.mariadb.jdbc.Driver");

			String url = "jdbc:mariadb://"+ConnectionIP.IP+"/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");

		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading error:" + e);
		}
		return conn;
	}

}
