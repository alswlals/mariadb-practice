package bookmall.vo;

public class CartVo {
	private Long no;
	private Long bookNo;
	private Long userNo;
	private int count;
	private String title;
	private String name;
	private int price;
	
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "CartVo [no=" + no + ", bookNo=" + bookNo + ", userNo=" + userNo + ", count=" + count + ", title="
				+ title + ", name=" + name + ", price=" + price + "]";
	}
	
	
}
