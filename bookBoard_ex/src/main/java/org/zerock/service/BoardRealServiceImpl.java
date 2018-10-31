package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardRealVO;
import org.zerock.domain.FollowVO;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardRealMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //�꽌鍮꾩뒪�뼱�끂�뀒�씠�뀡 �궗�슜�떆 猷⑦듃而⑦뀓�뒪�듃�뿉�꽌 而댄룷�꼳�듃�뒪罹붿쓣 �떆耳쒖쨾�빞�븳�떎. �꽕�엫�뒪�럹�씠�뒪 泥댄겕�룄 �븘�닔
//@AllArgsConstructor
public class BoardRealServiceImpl implements BoardRealService {

	@Setter(onMethod_ = @Autowired)
	private BoardRealMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void insert(BoardRealVO board) {
		// TODO Auto-generated method stub
		
		log.info("register.....asd......"+board);
		
		mapper.insertSelectKey(board);
		log.info("돌아온보드"+board);
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			log.info("셋하기전"+attach.getBno());
			attach.setBno(board.getBno());
			log.info("셋후"+attach.getBno());
			attachMapper.insert(attach);
		});
 
	}

	@Override
	public BoardRealVO get(long bno) {
		// TODO Auto-generated method stub
		return mapper.read(bno);
	}
	
	
	@Transactional
	@Override
	public boolean modify(BoardRealVO board) {
		// TODO Auto-generated method stub
		log.info("modify:" + board);
		
		if(board.getMain_img() == null) {
			board.setMain_img("not");
			log.info("여기진입");
		}
		log.info("이프하고나옴");
		attachMapper.imageAllRemove(board.getBno());
		boolean ab = mapper.update(board);
		log.info("불런실행");
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> {
				log.info("셋하기전"+attach.getBno());
				attach.setBno(board.getBno());
				log.info("셋후"+attach.getBno());
				attachMapper.insert(attach);
			});
		}
		return ab;
		
		
	}

	@Override
	public boolean remove(long bno) {
		// TODO Auto-generated method stub
		return mapper.delete(bno);
	}

	@Override
	public List<BoardRealVO> getList() {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		// TODO Auto-generated method stub
		log.info("get Attach list by bno"+ bno);
		
		return attachMapper.findByBno(bno);
	}

	@Override
	public boolean imageAllRemove(long bno) {
		// TODO Auto-generated method stub
		log.info("imageAllRemove:"+ bno);
		return attachMapper.imageAllRemove(bno);
	}

	@Override
	public List<BoardRealVO> searching(BoardRealVO vo) {
		// TODO Auto-generated method stub
		return mapper.searching(vo);
	}

	@Override
	public List<BoardRealVO> readWriter(BoardRealVO vo) {
		// TODO Auto-generated method stub
		return mapper.readWriter(vo);
	}

	@Override
	public int countBno() {
		// TODO Auto-generated method stub
		return mapper.countBno();
	}

	@Override
	public List<BoardRealVO> paging(int page) {
		// TODO Auto-generated method stub
		return mapper.paging(page);
	}

	@Override
	public List<BoardAttachVO> getAttachListUser(String user_id) {
		// TODO Auto-generated method stub
		return attachMapper.getAttachListUser(user_id);
	}

	@Override
	public List<BoardRealVO> searchString(String user_id) {
		// TODO Auto-generated method stub
		return mapper.searchString(user_id);
	}

	@Override
	public boolean replyUpdate(long bno) {
		// TODO Auto-generated method stub
		log.info("replyUpdate=--------service"+bno);
		
		return mapper.replyUpdate(bno);
	}

	@Override
	public boolean replyCountDown(long bno) {
		// TODO Auto-generated method stub
		return mapper.replyCountDown(bno);
	}

	@Override
	public boolean likeCntUp(long bno) {
		// TODO Auto-generated method stub
		return mapper.likeCntUp(bno);
	}

	@Override
	public boolean likeCntDown(long bno) {
		// TODO Auto-generated method stub
		return mapper.likeCntDown(bno);
	}

	@Override
	public int likeCountSum(String user_id) {
		// TODO Auto-generated method stub
		return mapper.likeCountSum(user_id);
	}

	@Override
	public List<BoardRealVO> likeOrderAll() {
		// TODO Auto-generated method stub
		return mapper.likeOrderAll();
	}

	@Override
	public List<BoardRealVO> replyOrderAll() {
		// TODO Auto-generated method stub
		return mapper.replyOrderAll();
	}

	
}
