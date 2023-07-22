package com.kpet.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.ReplyVO;
import com.kpet.domain.UserVO;
import com.kpet.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/reply/*")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	
	//1)특정 게시물에 해당하는 댓글쓰기
	// consumes : 제공하는 데이터의 mime타입설정, produces : 반환하는 데이타타입을 정의.
	// consumes : 클라이언트가 서버에게 보내는 데이타타입을 명시
	// produces : 서버가 클라이언트에게 반환하는 데이타타입을 명시
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo, HttpSession session){

		vo.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());

		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("insertCount: " + insertCount);
		
		return insertCount == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//2)댓글목록
	// 리턴되는 데이타타입을 Map컬렉션으로 사용하는 이유? 여러개의 정보를 추가해서 하나의 객체로 클라이언트에게 보내고자 할때.(중요)
	@GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		//1)댓글목록데이타를 Map컬렉션에 추가
		Criteria cri = new Criteria(page, 5);
		map.put("list", service.getListPage(cri, bno).getList());
		
		//2)댓글 페이징정보를 Map컬렉션에 추가
		PageDTO pageDTO = new PageDTO(cri, service.getListPage(cri, bno).getReplyCnt());
		map.put("pageMaker", pageDTO);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	//댓글 수정.   /modify/10
	@RequestMapping(value = "/modify/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("rno") Long rno, @RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		
		vo.setRno(rno);
		
		log.info(rno);
		log.info(vo);
		
		service.modifyReply(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//댓글삭제
	@DeleteMapping(value = "/delete/{bno}/{rno}")
	public ResponseEntity<String> delete(@PathVariable("bno") Long bno, @PathVariable("rno") Long rno){
		
		ResponseEntity<String> entity = null;
				
		service.deleteReply(bno, rno);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
}
