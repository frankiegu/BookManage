package edu.fjnu.book.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import edu.fjnu.book.domain.Book;

public interface BookDao extends BaseDao<Book>{
	public List<Book> findPending(Book book);
	public List<Book> getBookByType(Serializable id);
	//推荐
	public List<Book> getBookByMark(Map<String,Object>map);
	public Book getStu(Book book);
}
