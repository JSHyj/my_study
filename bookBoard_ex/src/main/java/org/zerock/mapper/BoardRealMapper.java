package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardRealVO;

public interface BoardRealMapper {
	
	public List<BoardRealVO> getList();
	//public List<BoardRealVO> getListWithPaging(Criteria cri);
	public void insert(BoardRealVO board);
	public void insertSelectKey(BoardRealVO board);
	public BoardRealVO read(Long bno);
	public boolean delete(Long bno);
	public boolean update(BoardRealVO vo);
	//public int getTotalCount
	//public void updateReplyCnt(@Param("bno") Long bno, @Param("amout") int amount);
	public List<BoardRealVO> searching(BoardRealVO vo);
	public List<BoardRealVO> readWriter(BoardRealVO vo);
	public int countBno();
	public List<BoardRealVO> paging(int page);
	public boolean replyUpdate(long bno);
	public boolean replyCountDown(long bno);
	public boolean likeCntUp(long bno);
	public boolean likeCntDown(long bno);
	public int likeCountSum(String user_id);
	
	public List<BoardRealVO> likeOrderAll();
	public List<BoardRealVO> replyOrderAll();

	
	public List<BoardRealVO> searchString(String user_id);
}
