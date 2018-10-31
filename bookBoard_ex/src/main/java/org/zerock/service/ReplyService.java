package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long bno);

	public List<ReplyVO> readBno(Long bno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public boolean removeAll(Long bno);
	
	//public List<ReplyVO> getList(Criteria cri, Long bno);
	
	public List<ReplyVO> getList(Long bno);
	
	public ReplyVO baseReply(ReplyVO vo);
	
	public ReplyVO reReply(ReplyVO vo);
	
	public boolean indentUp(ReplyVO vo);
	
	public ReplyVO newComment(Long bno);
	
	public List<ReplyVO> readID(String writer);
	
	public boolean stepDown(long bno);
	

}
