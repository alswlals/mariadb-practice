package bookmall.dao.test;

import java.util.List;

import bookmall.dao.CartDao;
import bookmall.vo.CartVo;

public class CartDaoTest {
	public static void main(String[] args) {
		testInsert();
		testFindAll();
	}

	public static void testInsert() {
		CartVo vo = null;
		CartDao dao = new CartDao();
		
		vo = new CartVo();
		vo.setBookNo(1L);
		vo.setUserNo(1L);
		vo.setCount(1);
		dao.insert(vo);
		
		vo = new CartVo();
		vo.setBookNo(2L);
		vo.setUserNo(1L);
		vo.setCount(4);
		dao.insert(vo);
		
		vo = new CartVo();
		vo.setBookNo(3L);
		vo.setUserNo(2L);
		vo.setCount(3);
		dao.insert(vo);
		
	}

	public static void testFindAll() {
		List<CartVo> list = new CartDao().findAll();
		
		for(CartVo vo:list)
			System.out.println("책 이름 : " + vo.getTitle() + ", 가격 :" + vo.getPrice() + ", 수량 :" + vo.getCount());
	}
}
