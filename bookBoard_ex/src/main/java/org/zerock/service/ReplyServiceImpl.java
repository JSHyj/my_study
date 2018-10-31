package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
//@AllArgsConstructor // ---->Spring 4.3 
public class ReplyServiceImpl implements ReplyService {
	
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("register.....(register)"+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long bno) {
		// TODO Auto-generated method stub
		
		log.info("get-----------"+bno);
		return mapper.read(bno);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		
		log.info("modify"+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		// TODO Auto-generated method stub
		log.info("remove----------"+ rno);
		return mapper.delUpdate(rno);
	}

	@Override
	public List<ReplyVO> getList(Long bno) {
		// TODO Auto-generated method stub
		log.info("get Reply List of a Board"+ bno);
		return mapper.getList(bno);
	}

	@Override
	public ReplyVO baseReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.baseReply(vo);
	}

	@Override
	public ReplyVO reReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.reReply(vo);
	}

	@Override
	public boolean indentUp(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.indentUp(vo);
	}

	@Override
	public boolean removeAll(Long bno) {
		// TODO Auto-generated method stub
		log.info("replyDeleteAll");
		return mapper.removeAll(bno);
	}

	@Override
	public ReplyVO newComment(Long bno) {
		// TODO Auto-generated method stub
		return mapper.newComment(bno);
	}

	@Override
	public List<ReplyVO> readBno(Long bno) {
		// TODO Auto-generated method stub
		return mapper.readBno(bno);
	}

	@Override
	public List<ReplyVO> readID(String writer) {
		// TODO Auto-generated method stub
		return mapper.readID(writer);
	}

	@Override
	public boolean stepDown(long bno) {
		// TODO Auto-generated method stub
		return mapper.stepDown(bno);
	}

}
