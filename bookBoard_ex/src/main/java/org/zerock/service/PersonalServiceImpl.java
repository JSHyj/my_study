package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BackgroundVO;
import org.zerock.domain.FollowVO;
import org.zerock.domain.emotionVO;
import org.zerock.mapper.PersonalMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class PersonalServiceImpl implements PersonalService {
	
	private PersonalMapper mapper;

	@Override
	public boolean insert(BackgroundVO vo) {
		// TODO Auto-generated method stub
		log.info("insert vo:"+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public boolean get(String user_id) {
		// TODO Auto-generated method stub
		log.info("get service"+user_id);
		
		return mapper.get(user_id);
	}

	@Override
	public boolean update(BackgroundVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public FollowVO followChk(String user_id, String following) {
		// TODO Auto-generated method stub
		log.info("followChk service Access------------------------------"+user_id+",,,"+following);
		return mapper.followChk(user_id, following);
		
		//following = user,  viewer = me
 }

	@Override
	public boolean followInsert(FollowVO vo) {
		// TODO Auto-generated method stub
		log.info("followinsert service--------------------"+vo);
		
		return mapper.followInsert(vo);
	}

	@Override
	public boolean followDelete(FollowVO vo) {
		// TODO Auto-generated method stub
		log.info("FollowDelete service---------------"+vo);
		return mapper.followDelete(vo);
	}

	@Override
	public List<FollowVO> getFollower(String user_id) {
		// TODO Auto-generated method stub
		log.info("getFollower service------------------"+user_id);
		
		return mapper.getFollower(user_id);
	}

	@Override
	public emotionVO bnoChk(long bno, String user_id) {
		// TODO Auto-generated method stub
		log.info("bnoChk service---------------------------------" + bno);
		
		
		return mapper.bnoChk(bno, user_id);
	}

	@Override
	public boolean emotionUpdate(emotionVO vo) {
		// TODO Auto-generated method stub
		log.info("emotionUpdate service-------"+vo);
		return mapper.emotionUpdate(vo);
	}

	@Override
	public List<FollowVO> getFollowingMe(String user_id) {
		// TODO Auto-generated method stub
		return mapper.getFollowingMe(user_id);
	}

	@Override
	public boolean emotionInsert(emotionVO vo) {
		// TODO Auto-generated method stub
		
		log.info("emotionInsert service---------------------" + vo);
		
		return mapper.emotionInsert(vo);
	}


}
