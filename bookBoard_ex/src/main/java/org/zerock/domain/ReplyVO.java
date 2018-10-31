package org.zerock.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;
	private Long bno;
	private String reply;
	private String user_id;
	private Timestamp replyDate;
	private Timestamp updateDate;
	private int step;
	private int indent;
	private int del;
	private String user_img;
	private String writer;
	
	
}
