package bookmall.vo;

public class BookVo {
	private Long no;
	private String title;
	private int Price;
	private Long categoryNo;
	private String categoryName;
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	public Long getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(Long categoryNo) {
		this.categoryNo = categoryNo;
	}
	@Override
	public String toString() {
		return "BookVo [no=" + no + ", title=" + title + ", Price=" + Price + ", categoryNo=" + categoryNo
				+ ", categoryName=" + categoryName + "]";
	}
	
	
}
