package bookmall.dao.test;

import java.util.List;

import bookmall.dao.UserDao;
import bookmall.vo.UserVo;

public class UserDaoTest {
	public static void main(String[] args) {
		testInsert();
		testFindAll();
	}
	
	public static void testInsert() {
		UserVo vo = null;
		UserDao dao = new UserDao();
		
		vo = new UserVo();
		vo.setName("둘리");
		vo.setPassword("둘리");
		vo.setEmail("dooly@naver.com");
		vo.setNumber("010-1111-1111");
		dao.insert(vo);
		
		vo = new UserVo();
		vo.setName("또치");
		vo.setPassword("ddochi");
		vo.setEmail("ddochi@naver.com");
		vo.setNumber("010-1111-1111");
		dao.insert(vo);
	}
	
	public static void testFindAll() {
		List<UserVo> list = new UserDao().findAll();
		for(UserVo vo : list) {
			System.out.println("["+vo.getNo()+"] 이름:"+vo.getName()+", "
                    + "전화번호:"+vo.getNumber()+", "
                    + "이메일:"+vo.getEmail()+", "
                    + "비밀번호:"+vo.getPassword());
		}
	}
	
}
