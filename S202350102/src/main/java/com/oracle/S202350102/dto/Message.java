package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Message {
	private int 	user_num;		// 회원번호
	private int 	msg_id;			// 메시지 고유 번호
	private int 	room_id;		// 메시지방 고유번호
	private int 	sd_id;			// 발신자 아이디
	private int 	rcv_id;			// 수신자 아이디
	private String 	msg_contents;	// 메시지 내용
	private Date 	send_date;		// 알림 발생 일시
	private Date 	read_date;		// 알림 확인 일시
	private int 	msg_read;		// 읽음 여부
	private	String	tid;			// TID (가맹점 고유번호)
}
