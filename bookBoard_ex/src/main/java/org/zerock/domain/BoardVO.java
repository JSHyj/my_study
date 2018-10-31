package org.zerock.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private int user_point;
	private String user_img;
	private Timestamp user_join_date;
	private Timestamp user_login_date;
	private String user_signature;
	private String bg_img;
	
}
