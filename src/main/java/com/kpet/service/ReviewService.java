package com.kpet.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ReviewAllList;
import com.kpet.domain.ReviewVO;

public interface ReviewService {

	public List<ReviewVO> getReviewListWithPaging(Criteria cri,  Integer pro_num);
	
	public int getTotalCount(Integer pro_num);
	
	public List<ReviewAllList> getAllReview(Integer pro_num);
		
	public void reviewInsert(ReviewVO vo);
	
	public void reviewModify(ReviewVO vo);
	
	public void reviewDel(Integer rew_num);
	
	public List<ReviewAllList> getAllReviewPaging(Criteria cri, String orderby);

	public int getAllTotalCount();

	public List<ReviewAllList> getReviewCriteriaPaging(Criteria cri, Condition con, String orderby);

	public int getCriteriaCount(Condition con);
	
	public ReviewVO getReview(Integer rew_num);
	
	public List<ReviewVO> userReview(String user_id);
	
	public ReviewVO getOrdReview(ReviewVO vo);
}
