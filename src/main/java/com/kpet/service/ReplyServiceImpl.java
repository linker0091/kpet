package com.kpet.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.Criteria;
import com.kpet.domain.ReplyPageDTO;
import com.kpet.domain.ReplyVO;
import com.kpet.mapper.BoardMapper;
import com.kpet.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	private ReplyMapper mapper;
	
	private BoardMapper boardMapper;

	//  댓글쓰기( tbl_board테이블에 replycnt컬럼에 1증가)
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		log.info("register.... " + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

	@Override
	public int modifyReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	
	//  댓글삭제( tbl_board테이블에 replycnt컬럼에 1감소)
	@Transactional
	@Override
	public int deleteReply(Long bno, Long rno) {
		// TODO Auto-generated method stub
		
		boardMapper.updateReplyCnt(bno, -1);
		
		return mapper.delete(rno);
	}
	
	
}
