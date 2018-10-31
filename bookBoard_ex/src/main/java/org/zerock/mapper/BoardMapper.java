package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	
	//@Select("SELECT * FROM book_board")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public BoardVO read(String id);
	
	public int delete(String id);
	
	public int update(BoardVO board);
	
	public int idChk(String id);
	
	public String loginIDChk(String id);
	
	public String loginPWChk(String id);
	
	public String getUser_img(String id);
	
	public boolean bg_update(BoardVO vo);
	
	public void APIinsert(BoardVO board);
}
