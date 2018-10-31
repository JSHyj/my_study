package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BackgroundVO;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardRealVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.FollowVO;
import org.zerock.domain.emotionVO;
import org.zerock.service.BoardRealService;
import org.zerock.service.BoardService;
import org.zerock.service.PersonalService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/personal/*")
@Log4j
public class PersonalController {
	
	@Setter (onMethod_= {@Autowired})
	private BoardRealService service;
	
	@Setter (onMethod_= {@Autowired})
	private BoardService user;
	
	@Setter (onMethod_= {@Autowired})
	private PersonalService personal;
	
	

	@GetMapping("/mypage")
	public void mypage(Model model, @RequestParam("user_id") String user_id, HttpSession session) {
		
		log.info("mypage-------------------"+user_id);
		BoardRealVO vo = new BoardRealVO();
		vo.setUser_id(user_id);
		log.info("readVO:"+vo);
		List<BoardRealVO> list = service.readWriter(vo);
		log.info("readVO:"+list);
		
		
		//int likeCnt = service.likeCountSum(user_id);
		int boardCnt = 0;
		
		if(list != null) {
			for(int i = 0; i<list.size(); i++) {
				boardCnt += 1;
			}
		}
		
		
		List<FollowVO> getFollower = personal.getFollower(user_id);
		int followerCnt = 0;
		
		if(getFollower != null) {
			for(int i =0; i<getFollower.size(); i ++) {
				followerCnt += 1;
			}
		}
			
		
		List<FollowVO> getFollowingMe = personal.getFollowingMe(user_id);
		int FollowingMe = 0;
		for(int i =0; i<getFollowingMe.size(); i++) {
			FollowingMe += 1;
		}
		
		
		
		model.addAttribute("list", list);
		log.info("이거");
		model.addAttribute("info", user.get(user_id));		
		log.info("겟유저아이디완료");
		model.addAttribute("boardCnt", boardCnt);
		log.info("라이크카운트완료");
		model.addAttribute("followerCnt", followerCnt);
		log.info("팔로우카운트완료");
		model.addAttribute("FollowingMe", FollowingMe);
		log.info("팔로윙미카운트완료");
		
	}
	
	@GetMapping("/follow")
	public void follow_main(Model model, @RequestParam("user_id")String user_id, HttpSession session) {
		
		log.info("followAccess"+ user_id); // param         ---no session !!
		
		
		
		
		log.info("getFollower controller---------------"+personal.getFollower(user_id));
		model.addAttribute("list", personal.getFollower(user_id));
		log.info("getFollower controller following me---------------"+personal.getFollowingMe(user_id));
		model.addAttribute("listM", personal.getFollowingMe(user_id));
		
	}
	
	@GetMapping("/bgChange2")
	public void bgChangeView(Model model, @RequestParam("user_id")String user_id, HttpSession session) {
		
		
		log.info("bgChange진입------------------------");
		
		String s_ID = (String) session.getAttribute("s_ID");
		if(!s_ID.equals(user_id)) {
			return;
		}else {
			log.info("else Access");
			model.addAttribute("user_id", user_id);
			
		}
	}
	
	@PostMapping("/bgChange")
	public String bgChangePost(Model model, @RequestParam("user_id")String user_id,  BackgroundVO bg, RedirectAttributes rttr) {
		
		log.info("backgroundVO"+bg);
		
		
		BoardVO vo = new BoardVO();
		if(bg.getBg_img() != null) {
			vo.setUser_id(user_id);
			vo.setBg_img(bg.getBg_img());
		}
		
		user.bg_update(vo);
		log.info("bg update result : "+user.bg_update(vo));
		
		return "redirect:/personal/mypage?user_id="+user_id;
		//개인페이지 배경이미지
	}
	
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachListUser(String user_id) {
		
		log.info("getAttachList"+ user_id);
		return new ResponseEntity<>(service.getAttachListUser(user_id), HttpStatus.OK);		
	}
	
	
	@PostMapping("/followChk.do")
	@ResponseBody
	public int followChk(String user_id, String following, HttpSession session) {
		log.info("followChk Controller-------"+user_id);
		
		//String viewer = (String) session.getAttribute("s_ID");
		if(user_id.equals(following)) {
			log.info("viewer==user_id");
			return -1; // 같은 계정일 경우.
		}else {
			log.info("viewer!=user_id");
			
			FollowVO vo = personal.followChk(user_id, following);

			if(vo != null) {
				log.info("true");
				return 1; // 팔로워일 경우 1리턴

			}else {
				log.info("false");

				return 0; // not follower 0 return
			}
		}
		
	}
	
	
	@ResponseBody
	@PostMapping("/follow.do")
	public int follow_do(String following,  HttpSession session) {
		
		log.info("follow_do controller access---------------"+ following);
		
		FollowVO vo = new FollowVO();
		
		String user_id = (String)session.getAttribute("s_ID");
		
		vo = personal.followChk(user_id, following);
		
		log.info("personalChk Success-------------------------"+user_id);
		
		FollowVO Fvo = new FollowVO();

		Fvo.setUser_id(user_id);
		log.info("1");
		Fvo.setFollowing(following);
		log.info("2");
		Fvo.setSender_img((String)session.getAttribute("s_img"));
		log.info("3");
		log.info("all set");
		
		if (vo != null) {
			log.info("not follower-------> change follower");
			//delete 
			
			personal.followDelete(Fvo);
			return 2; //  follow -> unfollow
			
		}else {
			
			log.info("not follower-------> change unfollow");
			personal.followInsert(Fvo);
			
			return 1; //  unfollow -> follow
		}
	}
	
	@ResponseBody
	@PostMapping("/myfollow.do")
	public int myFollow(String following, String user_id, HttpSession session) {
		
		log.info("myFollow--------"+following+user_id);
		
		FollowVO vo = new FollowVO();
		
		
		vo = personal.followChk(user_id, following);
		
		log.info("personalChk Success-------------------------"+user_id);
		
		FollowVO Fvo = new FollowVO();

		Fvo.setUser_id(user_id);
		log.info("1");
		Fvo.setFollowing(following);
		log.info("2");
		Fvo.setSender_img((String)session.getAttribute("s_img"));
		log.info("3");
		log.info("all set");
		
		if (vo != null) {
			log.info("not follower-------> change follower");
			//delete 
			
			personal.followDelete(Fvo);
			return 2; //  follow -> unfollow
			
		}else {
			
			log.info("follower-------> change unfollow");
			personal.followInsert(Fvo);
			
			return 1; //  unfollow -> follow
		
		}
	}
	
	
	@Transactional
	@ResponseBody
	@PostMapping("/emotionlike")
	public int emotion_change(emotionVO vo) {
		
		log.info("emotion.do like :"+ vo);
		
		
		emotionVO vo2 = personal.bnoChk(vo.getBno(), vo.getUser_id());
		

		log.info("vo2 controllerr:" + vo2);
		emotionVO vo3 =new emotionVO();
		vo3.setBno(vo.getBno());
		vo3.setUser_id(vo.getUser_id());
		vo3.setWriter(vo.getWriter());
		
		log.info("vo3 controllerr :" + vo3);
		
		int like = 0;
		
		if(vo2 != null) {
			
			log.info("like btn not null");
			
			if(vo2.getLike()==1) {
				log.info("getLike==1"+vo.getLike());
				service.likeCntDown(vo.getBno());
				vo3.setLike(0);
				like = 0;
			}else if(vo.getLike() == 0) {
				log.info("getLike==0"+vo.getLike());
				vo3.setLike(1);
				service.likeCntUp(vo.getBno());
				like = 1;
			}
			
			personal.emotionUpdate(vo3);
			
		}else {
			log.info("like btn null-----------------------------");
			vo3.setLike(1);
			personal.emotionInsert(vo3);
			service.likeCntUp(vo.getBno());
			like = 1;
			
		}
		
		
		log.info("like ="+ like);
		
		
		return like;
	}
	
	
	/*if(vo2.getFun() == 1) {
	vo3.setFun(0);
}else if(vo.getFun() == 0) {
	vo3.setFun(1);
}

if(vo2.getSad() == 1) {
	vo3.setSad(0);
}else if(vo2.getSad() == 0) {
	vo3.setSad(1);
}*/
	
	
	
	
	@ResponseBody
	@PostMapping("/emotionChk.do")
	public emotionVO emotionChk(String sessionID, long bno) {
		
		
		log.info("emotionCHk-------------------------------------controller");
		emotionVO emotion = personal.bnoChk(bno, sessionID);
		log.info("bno, sessionID:-----"+bno + sessionID);
		
		log.info("emotion controller--"+emotion);
		
		return emotion;
	}
	
	
	@GetMapping("/followFeed")
	public void followFeed(String user_id, Model model) {
		
		log.info("followfeed----------------"+user_id);
		
		List<FollowVO> volist = personal.getFollower(user_id);
		
		List<BoardRealVO> list = new ArrayList<>();
		
		
		log.info("searchingString------------"+volist);
		
		log.info("followfeed"+  service.getList());
		
		model.addAttribute("FollowVO", volist);
		
		model.addAttribute("BoardRealVO", service.getList());
		
	}
	
	@GetMapping("/infomation")
	public void infomation(Model model, String user_id) {
		
		log.info("info----------------------");
		
		model.addAttribute("list", user.get(user_id));
		
	}
	
	
	
	
	
}
