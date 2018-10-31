package org.zerock.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	/*@Test
	public void testRegister() {
		
		BoardVO board = new BoardVO();
		board.setUser_id("김땡땡");
		board.setUser_pw("password");
		board.setUser_name("이름");
		board.setUser_email("김땡땡");
		
		service.register(board);
		
		log.info("새글작성성공");
		
	}*/
	
	@Test
	public void testGetList() {
		
		log.info("getList");
		service.getList().forEach(board -> log.info(board));
		
	}
	
	@Test
	public void testGet() {
		
		log.info(service.get("김땡땡"));
		
	}
	
	@Test
	public void testDelete() {
		
		log.info("remove result:" + service.remove("김땡땡"));
		service.remove("김땡땡");
	}
	
	/*@Test
	public void testUpdate() {
		BoardVO board = service.get("ab");
		if(board == null) {
			return;
		}
		
		board.setTitle("제목수정합니다.");
		log.info("modify result:" + service.modify(board));
	}*/
	
}
