package org.zerock.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class FollowVO {
	
	private long num;
	private String user_id;
	private String following;
	private Timestamp followDate;
	private String sender_img;
	private String follow_img;
	
	
	//num user_id following followDate sender_img
}
