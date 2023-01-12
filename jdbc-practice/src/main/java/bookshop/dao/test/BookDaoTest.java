package bookshop.dao.test;

public class BookDaoTest {

	public static void main(String[] args) {
		testInsert();

	}

	private static void testInsert() {
		BookVo vo = null;
		BookDao dao = new BookDao();
		
		vo = new BookVo();
		vo.setTitle("");
		vo.setAuthorNo();
		dao.insert(vo);
		
		vo = new BookVo();
		vo.setTitle("");
		vo.setAuthorNo();
		dao.insert(vo);

		vo = new BookVo();
		vo.setTitle("");
		vo.setAuthorNo();
		dao.insert(vo);
		
		vo = new BookVo();
		vo.setTitle("");
		vo.setAuthorNo();
		dao.insert(vo);
		
	}

}
