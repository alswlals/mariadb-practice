package bookmall.dao.test;

import java.util.List;

import bookmall.dao.BookDao;
import bookmall.vo.BookVo;

public class BookDaoTest {
	public static void main(String[] args) {
		testInsert();
		testFindAll();
	}


	public static void testInsert() {
		BookVo vo = null;
		BookDao dao = new BookDao();
		
		vo = new BookVo();
		vo.setTitle("윤동주 시집");
		vo.setPrice(10000);
		vo.setCategoryNo(1L);
		dao.insert(vo);
		
		vo = new BookVo();
		vo.setTitle("열 번 잘해도 한 번 실수로 무너지는 게 관계다");
		vo.setPrice(18000);
		vo.setCategoryNo(2L);
		dao.insert(vo);
		
		vo = new BookVo();
		vo.setTitle("제주는 숲과 바다");
		vo.setPrice(15000);
		vo.setCategoryNo(3L);
		dao.insert(vo);
	}

	public static void testFindAll() {
		List<BookVo> list = new BookDao().findAll();
		for(BookVo vo : list) {
			System.out.println("책 이름 : " + vo.getTitle() + ", 가격 :" + vo.getPrice() + ", 카테고리 :" + vo.getCategoryName());
		}
		}
		
	}
	
	

