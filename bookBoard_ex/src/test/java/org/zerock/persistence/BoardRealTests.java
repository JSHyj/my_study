package org.zerock.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardRealVO;
import org.zerock.service.BoardRealService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardRealTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardRealService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		
		log.info("getList");
		service.getList().forEach(board -> log.info(board));
		
	}
	@Test
	public void testGetWrite() {
		
		log.info("getList");
		service.getList().forEach(board -> log.info(board));
		BoardRealVO vo = new BoardRealVO();
		vo.setTitle("실험");
		vo.setContent("실험내용");
		vo.setUser_id("실험작성자");
		service.insert(vo);
		
	}
}