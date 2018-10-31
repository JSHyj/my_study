package org.zerock.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class BoardRealVO {
	
	private Long bno;
	private String title;
	private String content;
	private String user_id;
	private Timestamp regDate;
	private Timestamp updateDate;
	private int replyCnt;
	private String user_img;
	private int likeCnt;
	private String main_img;
	private String user_name;
	
	
	private List<BoardAttachVO> attachList;

}
