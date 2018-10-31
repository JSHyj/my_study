package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public void APIinsert(BoardVO board);
	
	public BoardVO get(String id);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(String id);
	
	public List<BoardVO> getList();
	
	public int idChk(String id);
	
	public String loginIDChk(String id);
	
	public String loginPWChk(String id);
	
	public String getUser_img(String id);
	
	public boolean bg_update(BoardVO vo);
	


}
