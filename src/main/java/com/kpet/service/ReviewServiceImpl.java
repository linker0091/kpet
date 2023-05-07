package com.kpet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ReviewAllList;
import com.kpet.domain.ReviewVO;
import com.kpet.mapper.AdminProuductMapper;
import com.kpet.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper mapper;
	
	@Inject
	private AdminProuductMapper adProMapper;
	
	@Override
	public List<ReviewVO> getReviewListWithPaging(Criteria cri, Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.getReviewListWithPaging(cri, pro_num);
	}

	@Override
	public int getTotalCount(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(pro_num);
	}

	@Override
	public List<ReviewAllList> getAllReview(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.getAllReview(pro_num);
	}
	
	@Transactional
	@Override
	public void reviewInsert(ReviewVO vo) {
		// TODO Auto-generated method stub
		mapper.reviewInsert(vo);
		
		Integer pro_num = vo.getPro_num();

		adProMapper.product_rew_update(pro_num);
	}

	@Override
	public void reviewModify(ReviewVO vo) {
		// TODO Auto-generated method stub
		mapper.reviewModify(vo);
	}

	@Transactional
	@Override
	public void reviewDel(Integer rew_num) {
		// TODO Auto-generated method stub
		mapper.reviewDel(rew_num);

		adProMapper.product_rew_update(rew_num);

	}

	@Override
	public List<ReviewAllList> getAllReviewPaging(Criteria cri, String orderby) {
		// TODO Auto-generated method stub
		return mapper.getAllReviewPaging(cri,orderby);
	}

	@Override
	public int getAllTotalCount() {
		// TODO Auto-generated method stub
		return mapper.getAllTotalCount();
	}

	@Override
	public List<ReviewAllList> getReviewCriteriaPaging(Criteria cri,Condition con, String orderby) {
		// TODO Auto-generated method stub
		return mapper.getReviewCriteriaPaging(cri,con,orderby);
	}

	@Override
	public int getCriteriaCount(Condition con) {
		// TODO Auto-generated method stub
		return mapper.getCriteriaCount(con);
	}

	@Override
	public ReviewVO getReview(Integer rew_num) {
		// TODO Auto-generated method stub
		return mapper.getReview(rew_num);
	}
	
	@Override
	public List<ReviewVO> userReview(String user_id) {
		// TODO Auto-generated method stub
		return mapper.userReview(user_id);
	}

	@Override
	public ReviewVO getOrdReview(ReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.getOrdReview(vo);
	}
}
