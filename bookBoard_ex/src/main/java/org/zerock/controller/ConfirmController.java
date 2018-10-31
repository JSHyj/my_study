package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.BoardRealVO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.BoardRealService;
import org.zerock.service.PersonalService;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/confirm/*")
public class ConfirmController {
	
	
	@Setter (onMethod_ = {@Autowired})
	private BoardRealService service;
	
	@Setter (onMethod_ = {@Autowired})
	private ReplyService replyService;
	
	@Setter (onMethod_ = {@Autowired})
	private PersonalService personal;
	
	@PostMapping("/comment")
	@ResponseBody
	public List<ReplyVO> confirm_comment(@RequestParam("id")String id, Model model) {
		
		log.info("new comment");
		List<ReplyVO> vo = replyService.readID(id);
		log.info("readID access" + vo);
		
		return vo;
		
	}
	
	@PostMapping("/paging")
	@ResponseBody
	public List<Integer> list_Paging(@RequestParam("page")int page, Model model) {
		log.info("paging"+ page);
		
		int count = service.countBno();
		if(count%20 == 0) {
			page = count / 20; //ex) 15%15 = 0     15/15 = 1 �� 1������ ����
		}else {
			page = (count / 20) + 1; // 16%15 = 1   16/15 = 1 + 1 = 2 �� 2������ ����
		}
		
		List<Integer> result = new ArrayList<Integer>();
		
		for(int i = 1; i <= page; i++) {
			result.add(i);
			log.info("result add :"+result);
		}
		
		return result;
		
		
	}
	
	
	@GetMapping("/likeOrderAll")
	public void likeOrder_all(Model model) {
		log.info("likeOrderBy------------------------");
		
		
		List<BoardRealVO> vo = service.likeOrderAll();
		model.addAttribute("list", vo);
		
		
	}
	
	@GetMapping("/replyOrderAll")
	public void replyOrder_all(Model model) {
		log.info("likeOrderBy------------------------");
		
		
		List<BoardRealVO> vo = service.replyOrderAll();
		model.addAttribute("list", vo);
	}
}
