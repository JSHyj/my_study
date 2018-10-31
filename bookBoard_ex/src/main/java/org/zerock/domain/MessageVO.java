package org.zerock.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MessageVO {
	
	private long num;
	private String sender;
	private String message;
	private String receiver;
	private int step;
	private String sender_img;
	private Timestamp date;
	private int del;
	
}
