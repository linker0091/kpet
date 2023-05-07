package com.kpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.BoardAttachVO;
import com.kpet.domain.BoardVO;
import com.kpet.domain.Criteria;
import com.kpet.mapper.BoardAttachMapper;
import com.kpet.mapper.BoardMapper;
import com.kpet.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service // 중간계층인 비지니스 목적으로 사용하는 클래스들에게 사용
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		
		log.info("register...." + board);
		//2)
		//mapper.insert(board);
		mapper.insertSelectKey(board);  // board클래의 bno가 글번호가 존재한다.
		
		log.info("bno: " + board.getBno());
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		
		// 첨부파일테이블 bno. 첨부된 파일이 없으면 NullPointerException 예외발생.
		board.getAttachList().forEach(attach -> {
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			
		});

	}

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return mapper.get(bno);
	}

	@Transactional
	@Override
	public void modify(BoardVO board) {
		
		//파일첨부 테이블 : 게시물을 참조하는 파일정보 모두삭제, 화면에 파일첨부목을 이용하여, 새로 파일첨부 삽입
		
		//1)기존존재하고 있는 파일정보 모두삭제
		attachMapper.deleteAll(board.getBno()); 
		
		
		// 기존게시물 수정작업
		boolean modifyResult = mapper.update(board) == 1;
		
		
		
		//2)신규파일 추가---> 결과적으로 수정의 의미가 된다.
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() >= 0) {
			
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
				
			});
		
		}

		
	}

	//게시물삭제.
	// 테이블관계( 게시판테이블 + 파일첨부테이블 ) 참조키관계 설정.
	// 데이타 삭제순서 : 1-1)파일첨부테이블 1-2)댓글테이블 2)게시판테이블
	@Transactional
	@Override
	public boolean delete(Long bno) {
		// TODO Auto-generated method stub
		
		//1)댓글삭제
		replyMapper.deleteAll(bno);
		//2)파일첨부테이블
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1; // 3)게시판테이블 삭제
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		// TODO Auto-generated method stub
		return attachMapper.findByBno(bno);
	}

	@Override
	public void removeAttach(Long bno) {
		// TODO Auto-generated method stub
		attachMapper.deleteAll(bno);
		
	}

}
