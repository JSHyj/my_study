package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno); //Ư���Խù��� ÷������ ã�� ����
	
	public List<BoardAttachVO> getAttachListUser(String user_id);
	
	public boolean imageAllRemove(Long bno);

}
