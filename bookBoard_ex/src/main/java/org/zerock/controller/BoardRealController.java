package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardRealVO;
import org.zerock.domain.FollowVO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.BoardRealService;
import org.zerock.service.BoardService;
import org.zerock.service.PersonalService;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
//@AllArgsConstructor
public class BoardRealController {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardRealService service;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService userService;
	 
	@Setter(onMethod_ = {@Autowired})
	private ReplyService replyService;
	
	@Setter(onMethod_= {@Autowired})
	private PersonalService personal;
	
	@GetMapping("/list")
	public void list(Model model, @RequestParam("page")int page) {
	
		
		if(page == 0 ) {
			page = 1;
		}
		
		log.info("list");
		model.addAttribute("list", service.paging(page));
		
	}
	
	/*@PostMapping("/list")
	public void list_login(Model model) {
		
		log.info("list");
		model.addAttribute("list", service.getList());
		
	}*/
	
	@PostMapping("/list")
	public void list_login(Model model, HttpSession session) {
		
		String s_ID = (String) session.getAttribute("s_ID");
		
		List<FollowVO> fv = personal.getFollower(s_ID);
		
		log.info("list");
		model.addAttribute("list", service.getList());
		
		model.addAttribute("follow", fv);
		
	}
	
	
	@GetMapping("/register") 
	public void register() {
		log.info("register...get....");
		
	}
	
	@PostMapping("/register")
	public String register(BoardRealVO board, RedirectAttributes rttr, HttpSession session) {
		
		log.info("register:"+board);
		if(board.getAttachList() != null) {
			log.info("attachList Not Nul-===============================");
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		//String img = (String) session.getAttribute("s_img");
		//board.setUser_img(img);
		
		if(board.getMain_img() == null) {
			board.setMain_img("not");
			log.info("메인이미지:"+board.getMain_img());
		}
		service.insert(board);
		
		/*ReplyVO vo = new ReplyVO();
		vo.setReply("기본댓글");
		vo.setUser_id(board.getUser_id());
		vo.setUser_img(img);
		log.info(vo);
		replyService.baseReply(vo);*/
		//rttr.addFlashAttribute("result", "게시글이 등록되었습니다.");
		
		return "redirect:/board/list?page=1";
		
	}
	
	@GetMapping("/contentView")
	public void get(@RequestParam("bno") long bno, HttpSession session, Model model) {
		
		log.info("/contentView"+session.getAttribute("s_ID"));
		
		if(session.getAttribute("s_ID") == null) {
			return;
		}else {
		
			model.addAttribute("board", service.get(bno));
			model.addAttribute("reply", replyService.getList(bno));
			
			String s_ID = (String) session.getAttribute("s_ID");
			BoardRealVO vo = service.get(bno);
			
			
			
			if(s_ID.equals(vo.getUser_id())) {
				replyService.stepDown(bno);
			}
		}
		
	}
	
	@PostMapping("/contentView")
	public String replyAction(@RequestParam String writer, @RequestParam("reply") String reply, @RequestParam("rBno") Long rBno, HttpSession session, RedirectAttributes rttr, Model model) {
		
		log.info("replyAction............."+reply);
		
		String s_ID = (String) session.getAttribute("s_ID");
		String s_img = (String) session.getAttribute("s_img");
		
		ReplyVO vo = new ReplyVO();
		
		vo.setUser_id(s_ID);
		vo.setBno(rBno);
		vo.setReply(reply);
		vo.setUser_img(s_img);
		vo.setWriter(writer);
		replyService.register(vo);
		service.replyUpdate(rBno);
		
		return "redirect:/board/contentView?bno="+rBno;
	}
	
	
	
	@GetMapping("/modify")
	public void modify(BoardRealVO vo, Model model, HttpSession session) {
		
		log.info("modify:"+vo);
		
		
		vo = service.get(vo.getBno());
		
		log.info("getbNO:"+service.get(vo.getBno()));
		
		String s_ID = (String)session.getAttribute("s_ID");
		
		log.info(s_ID);
		
		log.info("vo.getUser_id"+vo.getUser_id());
		
		String vouser_id = vo.getUser_id();
		
		if(s_ID.equals(vouser_id)) {
			model.addAttribute("board", service.get(vo.getBno()));
			log.info("modify아이디인증성공---------------");
		}
		
		else {
			model.addAttribute("result", "글 작성자가 아닙니다.");
		}
		
	}
	
	
	@PostMapping("/modify")
	public String modifyAction(BoardRealVO board, RedirectAttributes rttr) {
		log.info("modify 포스트:"+board);
		
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/contentView?bno="+board.getBno();
	}
	
	
	
	@GetMapping("/delete")
	public String remove(@RequestParam("bno") Long bno, HttpSession session, RedirectAttributes rttr) {
		log.info("delete...."+bno);
		
		String s_ID = (String) session.getAttribute("s_ID");
		BoardRealVO vo = service.get(bno);
		String user_id = vo.getUser_id();
		
		if(user_id.equals(s_ID)) {
			replyService.removeAll(bno);
			service.imageAllRemove(bno);
			service.remove(bno);
			rttr.addFlashAttribute("result", "글 삭제가 완료되었습니다.");
		}else {
			rttr.addFlashAttribute("result", "글 작성자만 가능합니다.");
		}
		return "redirect:/board/list?page=1";
	}
	
	
	@PostMapping("/replyDelete")
	public String replyDelete(@RequestParam("s_ID")String s_ID, @RequestParam("user_id")String user_id, ReplyVO vo, HttpSession session, RedirectAttributes rttr ) {
		log.info("replyDelete-------------"+ vo);
		
		log.info("s_ID:"+s_ID);
		log.info("user_id   : "+user_id);
		log.info("비교1:"+s_ID.equals(user_id));
		log.info("비교2:"+s_ID==user_id);
		log.info("replyBno"+vo.getBno());
		
		if(s_ID.equals(user_id)) {
			log.info("성공");
			replyService.remove(vo.getRno());
			service.replyCountDown(vo.getBno());
			rttr.addFlashAttribute("success", "글 삭제가 완료되었습니다.");
		}else {
			log.info("실패");
			rttr.addFlashAttribute("success", "글 작성자만 가능합니다.");
		}
		
		return "redirect:/board/contentView?bno="+vo.getBno();
	}
	
	@GetMapping("/replyModify")
	public void replyModiGet(@RequestParam("bno") long bno, Model model) {
		log.info("/replyModify------get---------");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("reply", replyService.getList(bno));
		
	}
	
	@PostMapping("/replyModify")
	public String replyModify(ReplyVO vo, HttpSession session, Model model, RedirectAttributes rttr) {
		
		log.info("replymodify:" + vo);
		
		if(vo.getUser_id().equals(session.getAttribute("s_ID"))) {
			log.info("모디파이화면성공");
			rttr.addFlashAttribute("modify", vo);
			return "redirect:/board/replyModify?bno="+vo.getBno();
		}else {
			rttr.addFlashAttribute("success", "댓글 작성자만 수정이 가능합니다.");
			return "redirect:/board/contentView?bno="+vo.getBno();
		}
		
	}
	
	@PostMapping("/replyModify.do")
	public String replyModifyAction(ReplyVO vo, Model model, RedirectAttributes rttr) {
		
		log.info("replyModifyAction--------"+ vo);
		
		replyService.modify(vo);
		rttr.addFlashAttribute("success", "성공적으로 댓글을 수정하였습니다.");
		
		return "redirect:/board/contentView?bno="+vo.getBno();
		
	}
	
	@GetMapping("/replyReply")
	public void rereplyView(@RequestParam("bno") long bno, Model model) {
		log.info("/rereplyView------get---------");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("reply", replyService.getList(bno));
		
	}
	
	@PostMapping("/replyReply")
	public String replyReply(ReplyVO vo, HttpSession session,  RedirectAttributes rttr ) {
		
		log.info("replyReplyPost-----------"+vo);
		
		
		log.info("대댓글진입성공");
		rttr.addFlashAttribute("reReply", vo);
		
		return "redirect:/board/replyReply?bno="+vo.getBno();
		
	}
	
	@PostMapping("/replyReply.do")
	public String replyReplyAction(ReplyVO vo, HttpSession session, RedirectAttributes rttr) {
		
		log.info("replyReplyAction!!-----------"+vo);
		
		replyService.indentUp(vo);
		replyService.reReply(vo);
		rttr.addFlashAttribute("success", "댓글이 작성되었습니다.");
		
		
		return "redirect:/board/contentView?bno="+vo.getBno();	
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList"+ bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);		
	}
	
	
	@PostMapping("/search")
	public void search(BoardRealVO vo, Model model, @RequestParam("search") String search) {
		
		log.info("------search--------------------"+search);
		vo.setContent(search);
		model.addAttribute("list", service.searching(vo));
		model.addAttribute("keyword", search);
	}
	
	@GetMapping("/search")
	public void searchGet(Model model) {
		
		log.info("search");
		model.addAttribute("list", service.getList());
		
	}
	
	
	
	
}
