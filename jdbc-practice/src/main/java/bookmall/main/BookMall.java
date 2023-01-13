package bookmall.main;

import bookmall.dao.test.BookDaoTest;
import bookmall.dao.test.CartDaoTest;
import bookmall.dao.test.CategoryDaoTest;
import bookmall.dao.test.OrdersDaoTest;
import bookmall.dao.test.UserDaoTest;

public class BookMall {

	public static void main(String[] args) {
		
		CategoryDaoTest.testInsert();
		System.out.println("==================카테고리===================");
		CategoryDaoTest.testFindAll();
		
		BookDaoTest.testInsert();
		System.out.println("\n==================서적===================");
		BookDaoTest.testFindAll();
		
		UserDaoTest.testInsert();
		System.out.println("\n==================회원===================");
		UserDaoTest.testFindAll();
		
		CartDaoTest.testInsert();
		System.out.println("\n==================카트===================");
		CartDaoTest.testFindAll();
		
		OrdersDaoTest.testInsert();
		System.out.println("\n==================주문===================");
		OrdersDaoTest.testFindAll();

		System.out.println("\n================주문 리스트=================");
		OrdersDaoTest.testFindOrderBook();
	
	}

}
