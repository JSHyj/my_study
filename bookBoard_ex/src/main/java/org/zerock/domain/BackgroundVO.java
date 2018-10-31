package org.zerock.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BackgroundVO {

	private String user_id;
	private String bg_img;
	private Timestamp bgDate;
	
	//사용 안함. 
	
}
