package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BOARD {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		log.info("1");
		mapper.getList().forEach(board -> log.info(board));
	}
	
/*	@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO();
		board.setId("KIM");
		board.setTitle("TITLe");
		board.setContent("내용");
		
		mapper.insert(board);
		log.info(board);
		
	}*/
	
	/*@Test
	public void testRead() {
		BoardVO board= mapper.read("KIM");
		log.info(board);
	}*/
	
	/*@Test
	public void testDelete() {
		
		String id = "KIM";
		mapper.delete(id);
	}*/
	
	
	/*@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		
		board.setId("ab");
		board.setTitle("수정제목");
		board.setContent("수정내용");
		
		int count = mapper.update(board);
		log.info("update count : " + count);
		
	}*/
	
}
