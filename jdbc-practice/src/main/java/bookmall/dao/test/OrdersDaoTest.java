package bookmall.dao.test;

import java.util.List;

import bookmall.dao.OrdersDao;
import bookmall.vo.OrdersVo;

public class OrdersDaoTest {

	public static void main(String[] args) {
		// testInsert();
		testFindAll();
		testFindOrderBook();
	}

	public static void testInsert() {
		OrdersVo vo = null;
		OrdersDao dao = new OrdersDao();

		vo = new OrdersVo();
		vo.setOrderNo("20210218-001");
		vo.setName("vernon");
		vo.setEmail("vernon@seventeen.17");
		vo.setPrice(19000);
		vo.setAddress("대한민국 세봉리 17길 1");
		vo.setUserNo(1L);
		vo.setBookNo(3L);
		vo.setCount(1);
		vo.setNo(1L);
		dao.insert(vo);

		vo = new OrdersVo();
		vo.setOrderNo("20221212-020");
		vo.setName("원우");
		vo.setEmail("Wonwoo@seventeen.17");
		vo.setPrice(42000);
		vo.setAddress("대한민국 세봉리 17길 13");
		vo.setUserNo(2L);
		vo.setBookNo(2L);
		vo.setCount(2);
		vo.setNo(2L);
		dao.insert(vo);

		vo = new OrdersVo();
		vo.setOrderNo("20222453-121");
		vo.setName("지수");
		vo.setEmail("jisu@seventeen.17");
		vo.setPrice(21000);
		vo.setAddress("대한민국 세봉리 17길 3");
		vo.setUserNo(1L);
		vo.setBookNo(1L);
		vo.setCount(1);
		vo.setNo(3L);
		dao.insert(vo);
	}

	public static void testFindAll() {
		List<OrdersVo> list = new OrdersDao().findAll();
		for (OrdersVo vo : list) {
			System.out.println("주문번호:" + vo.getOrderNo() + " - 이름:" + vo.getName() + " - 이메일:" + vo.getEmail()
					+ " - 결제금액:" + vo.getPrice() + " - 배송지:" + vo.getAddress());
		}

	}

	public static void testFindOrderBook() {
		List<OrdersVo> list = new OrdersDao().findOrderBook();
		for (OrdersVo vo : list) {
			System.out.println("도서 번호:"+vo.getBookNo()+ " - 도서 제목:"+ vo.getBookName()+" - 수량:"+vo.getCount());
		}

	}
}
