package bookmall.dao.test;

import java.util.List;

import bookmall.dao.CategoryDao;
import bookmall.vo.CategoryVo;

public class CategoryDaoTest {
	public static void main(String[] args) {
		testInsert();
		testFindAll();
	}

	public static void testInsert() {
		CategoryVo vo = null;
		CategoryDao dao = new CategoryDao();

		vo = new CategoryVo();
		vo.setCategory("고전문학");
		dao.insert(vo);

		vo = new CategoryVo();
		vo.setCategory("시/에세이");
		dao.insert(vo);

		vo = new CategoryVo();
		vo.setCategory("여행");
		dao.insert(vo);

	}

	public static void testFindAll() {
		List<CategoryVo> list = new CategoryDao().findAll();
		for (CategoryVo vo : list) {
			System.out.println("["+vo.getNo()+"] " + vo.getCategory());
		}
	}
}
