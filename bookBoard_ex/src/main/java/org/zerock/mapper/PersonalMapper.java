package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BackgroundVO;
import org.zerock.domain.FollowVO;
import org.zerock.domain.emotionVO;

public interface PersonalMapper {
	
	public boolean insert(BackgroundVO vo);
	
	public boolean get(String user_id);
	
	public boolean update(BackgroundVO vo);
	
	public FollowVO followChk(@Param("user_id") String user_id, @Param("following")String following);
	
	public boolean followInsert(@Param("vo") FollowVO vo);
	
	public boolean followDelete(@Param("vo") FollowVO vo);
	
	public List<FollowVO> getFollower(@Param("user_id") String user_id);
	
	public emotionVO bnoChk(@Param("bno") long bno, @Param("user_id")String user_id);
	
	public boolean emotionUpdate(@Param("vo")emotionVO vo);
	
	public List<FollowVO> getFollowingMe(String following);
	
	public boolean emotionInsert(@Param("vo")emotionVO vo);


}
