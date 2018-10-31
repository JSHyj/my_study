package org.zerock.service;

import java.util.List;

import org.zerock.domain.BackgroundVO;
import org.zerock.domain.FollowVO;
import org.zerock.domain.emotionVO;

public interface PersonalService {
	
	public boolean insert(BackgroundVO vo);
	
	public boolean get(String user_id);
	
	public boolean update(BackgroundVO vo);
	
	public FollowVO followChk(String user_id, String following);
	
	public boolean followInsert(FollowVO vo);
	
	public boolean followDelete(FollowVO vo);
	
	public List<FollowVO> getFollower(String user_id);
	
	public emotionVO bnoChk(long bno, String user_id);
	
	public boolean emotionUpdate(emotionVO vo);
	
	public List<FollowVO> getFollowingMe(String user_id);
	
	public boolean emotionInsert(emotionVO vo);
	

	
	
	

}
