package com.kpet.service;

import java.util.List;

import com.kpet.domain.Criteria;
import com.kpet.domain.ReplyPageDTO;
import com.kpet.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
	public int modifyReply(ReplyVO vo);
	
	public int deleteReply(Long bno, Long rno);
}
