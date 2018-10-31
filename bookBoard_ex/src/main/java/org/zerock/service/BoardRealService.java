package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardRealVO;

public interface BoardRealService {
	
	public void insert(BoardRealVO board);
	
	public BoardRealVO get(long bno);
	
	public boolean modify(BoardRealVO board);
	
	public boolean remove(long bno);
	
	public List<BoardRealVO> getList();
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
	public List<BoardAttachVO> getAttachListUser(String user_id);
	
	public boolean imageAllRemove(long bno);
	
	public List<BoardRealVO> searching(BoardRealVO vo);
	
	public List<BoardRealVO> readWriter(BoardRealVO vo);
	
	public int countBno();
	
	public List<BoardRealVO> paging(int page);
	
	public List<BoardRealVO> searchString(String user_id);
	
	public boolean replyUpdate(long bno);
	
	public boolean replyCountDown(long bno);	
	
	public boolean likeCntUp(long bno);	

	public boolean likeCntDown(long bno);
	
	public int likeCountSum(String user_id);
	
	public List<BoardRealVO> likeOrderAll();
	
	public List<BoardRealVO> replyOrderAll();
}
