package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Service //�꽌鍮꾩뒪�뼱�끂�뀒�씠�뀡 �궗�슜�떆 猷⑦듃而⑦뀓�뒪�듃�뿉�꽌 而댄룷�꼳�듃�뒪罹붿쓣 �떆耳쒖쨾�빞�븳�떎. �꽕�엫�뒪�럹�씠�뒪 泥댄겕�룄 �븘�닔
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		
		log.info("register..........."+board);
		
		mapper.insert(board);

	}

	@Override
	public BoardVO get(String id) {
		// TODO Auto-generated method stub
		log.info("get----------------------"+id);
		
		return mapper.read(id);
	}

	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		
		log.info("modify......."+board);
		
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(String id) {
		// TODO Auto-generated method stub
		
		log.info("remove....."+id);
		
		return mapper.delete(id) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	@Override
	public int idChk(String id) {
		// TODO Auto-generated method stub
		return mapper.idChk(id);
	}

	@Override
	public String loginIDChk(String id) {
		// TODO Auto-generated method stub
		log.info("idchk------"+id);
		
		return mapper.loginIDChk(id);
	}

	@Override
	public String loginPWChk(String id) {
		// TODO Auto-generated method stub
		log.info("pwchk------"+id);
		
		return mapper.loginPWChk(id);
	}

	@Override
	public String getUser_img(String id) {
		// TODO Auto-generated method stub
		return mapper.getUser_img(id);
	}

	@Override
	public boolean bg_update(BoardVO vo) {
		// TODO Auto-generated method stub
		log.info("bg_update Access--------"+vo);
		return mapper.bg_update(vo);
	}

	@Override
	public void APIinsert(BoardVO board) {
		// TODO Auto-generated method stub
		mapper.APIinsert(board);
		
	}


}
