package org.zerock.controller;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor //�씠寃� �뾾�쓣�븧 autowired瑜� �빐以섏빞�븿. �씠嫄명빐二쇰㈃ �옄�룞�쑝濡� 二쇱엯
public class UserController {
	
	//@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	
	@GetMapping("/get")
	public void get(@RequestParam("user_id") String user_id, Model model) {
		log.info("/get");
		model.addAttribute("board", service.get(user_id));
	}
	
	/*@PostMapping("/modify")
	public String modify(BoardRealVO board, RedirectAttributes rttr) {
		log.info("modify:"+board);
		
		if(service2.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirec:/board/list?page=1";
	}*/
	
	@PostMapping("/remove")
	public String remove(@RequestParam("user_id")String user_id, RedirectAttributes rttr) {
		log.info("remove...."+user_id);
		if(service.remove(user_id)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list?page=1";
	}
	
	@GetMapping("/login_page")
	public void login_page(Model model) {
		log.info("login_page------------------------");
	}
	
	@ResponseBody
	@PostMapping("/login_page.do")
	public int loginChk(@RequestParam("id") String id, @RequestParam("password") String password, Model model) {
		
		log.info("idChk change"+id);
		String IDresult = service.loginIDChk(id);
		String PWresult = service.loginPWChk(id);
		
		log.info("id result"+IDresult);
		log.info("PW result"+PWresult);
		if(IDresult == null) {
			return 2;
		}else if(IDresult != null && !BCrypt.checkpw(password, PWresult)) {
			return 3;
		}else {
			return 1;
		}
		
		
	}
	
	@PostMapping("/login_page")
	public String loginSuccess(@RequestParam("user_id") String user_id, HttpSession session, RedirectAttributes rttr) {
		
		log.info("register:");
		BoardVO vo = service.get(user_id);
		session.setAttribute("s_ID", user_id);
		session.setAttribute("s_img", vo.getUser_img());
		session.setAttribute("s_name", vo.getUser_name());
		
		return "redirect:/board/list?page=1";
		
	}
	
	
	
	
	
	@GetMapping("/join_page")
	public void join_page(Model model) {
		log.info("login_page------------------------");
	}
	
	@PostMapping("/join_page")
	public String joincommit(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register:"+board);
		String hashedPw = BCrypt.hashpw(board.getUser_pw(), BCrypt.gensalt());
		board.setUser_pw(hashedPw);
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getUser_id());
		
		return "redirect:/board/list?page=1";
		
	}
	
	@ResponseBody
	@GetMapping("/join_pageChk")
	public int idChk(String user_id) {
		
		log.info("idChk "+user_id);
		int result = service.idChk(user_id);
		log.info("result-----"+result);
		
		return result;
		
	}
	
	@GetMapping("/logout")
	public String logoutCilck(Model model, HttpSession session) {
		session.invalidate();
		
		return "redirect:/board/list?page=1";
	}
	
	
}
