package bookshop.example;

public class Book {
	private int bookNo;
	private String title;
	private String autor;
	private int stateCode;
	
	public Book(int bookNo, String title, String autor) {
		this.bookNo = bookNo;
		this.title = title;
		this.autor = autor;
		this.stateCode = stateCode;
	}
	
	public void rent() {
		stateCode = 0;
	}
	
	public void print() {
		if(stateCode == 0) {
			System.out.println("책 제목: " + title + ", 작가: " + autor +", 대여 유무: 대여 중" );
		} else {
			System.out.println("책 제목: " + title + ", 작가: " + autor +", 대여 유무: 재고 있음" );
		}
		
	}
}
