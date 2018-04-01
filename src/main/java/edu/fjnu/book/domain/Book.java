package edu.fjnu.book.domain;
//图书实体类
public class Book {
	private String bookid;
	private String bookname;
	private String author;
	private Publisher publisher;
	private BookType bookType;
	private String price;
	private String content;
	private String keyword;
	private String evaluateid;
	//图片存储路径
	private String imageUrl;
	private String score;
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Publisher getPublisher() {
		return publisher;
	}
	public void setPublisher(Publisher publisher) {
		this.publisher = publisher;
	}
	public BookType getBookType() {
		return bookType;
	}
	public void setBookType(BookType bookType) {
		this.bookType = bookType;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getEvaluateid() {
		return evaluateid;
	}
	public void setEvaluateid(String evaluateid) {
		this.evaluateid = evaluateid;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public Book() {
		super();
	}
	public Book(String bookid, String bookname, String author,
			Publisher publisher, BookType bookType, String price,
			String content, String keyword, String evaluateid, String imageUrl,
			String score) {
		super();
		this.bookid = bookid;
		this.bookname = bookname;
		this.author = author;
		this.publisher = publisher;
		this.bookType = bookType;
		this.price = price;
		this.content = content;
		this.keyword = keyword;
		this.evaluateid = evaluateid;
		this.imageUrl = imageUrl;
		this.score = score;
	}
	@Override
	public String toString() {
		return "Book [bookid=" + bookid + ", bookname=" + bookname
				+ ", author=" + author + ", publisher=" + publisher
				+ ", bookType=" + bookType + ", price=" + price + ", content="
				+ content + ", keyword=" + keyword + ", evaluateid="
				+ evaluateid + ", imageUrl=" + imageUrl + ", score=" + score
				+ "]";
	}
}
