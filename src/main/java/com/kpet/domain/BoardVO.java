package com.kpet.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data  
public class BoardVO {

	// 테이블의 컬럼명참조 : bno, title, content, user_id, regdate, updateddate
	private Long bno;
	private String title;
	private String content;
	private String user_id;  // 테스트
	
	// java.sql 패키지 선택안함. java.util 선택
	private Date regdate;  // 2022-01-05
	private Date updatedDate;  // 2022-01-05
	
	private int replycnt;
		
	//첨부파일 정보.   <input type="hidden" name="attachList[0].uuid">
	// attachList[0] 이부분이 BoardAttachVO클래스에 해당하는 의미이다.
	private List<BoardAttachVO> attachList; 

}
