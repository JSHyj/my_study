package org.zerock.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = { 3L, 4L, 5L, 6L}; // 0번째부터 시작
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		
		log.info(mapper);		
	}
	
	/*@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 4).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setUser_id("replayer" + i);
			
			mapper.insert(vo);
			
		});
		
	}*/
	
	/*@Test
	public void testRead() {
		
		Long targetRno = 3L;
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
		
	}*/
	
	/*@Test
	
	public void testDelete() {
		
		Long targetRno = 1L;
		
		mapper.delete(targetRno);
		
	}*/
	
	/*@Test
	public void testUpdate() {
		Long targetRno = 3L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("update reply");
		int count = mapper.update(vo);
		
		log.info("update count : "+ count);
	}*/
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[2]);
		
		replies.forEach(reply -> log.info("여기있"+reply));
	}

}
