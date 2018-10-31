package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delUpdate(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public List<ReplyVO> getList(Long bno);
	
	public ReplyVO baseReply(ReplyVO vo);
	
	public ReplyVO reReply(ReplyVO vo);
	
	public boolean indentUp(ReplyVO vo);
	
	public boolean removeAll(long bno);
	
	public ReplyVO newComment(Long bno);
	
	public List<ReplyVO> readBno(Long bno);
	
	public List<ReplyVO> readID(String writer);
	
	public boolean stepDown(long bno);
	

	
}
