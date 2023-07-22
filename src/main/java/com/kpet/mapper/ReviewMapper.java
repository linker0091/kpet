package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ReviewAllList;
import com.kpet.domain.ReviewVO;

public interface ReviewMapper {

	public List<ReviewVO> getReviewListWithPaging(@Param("cri") Criteria cri,  @Param("pro_num") Integer pro_num);
	
	public int getTotalCount(Integer pro_num);
	
	public List<ReviewAllList> getReviewImg(Integer pro_num);
	
	public List<ReviewAllList> getAllReview(Integer pro_num);
	
	public void reviewInsert(ReviewVO vo);
	
	public void reviewModify(ReviewVO vo);
	
	public void reviewDel(Integer rew_num);
	
	public List<ReviewAllList> getAllReviewPaging(@Param("cri") Criteria cri, @Param("orderby")String orderby);

	public int getAllTotalCount();

	public List<ReviewAllList> getReviewCriteriaPaging(@Param("cri") Criteria cri, @Param("con") Condition con, @Param("orderby")String orderby);

	public int getCriteriaCount(@Param("con") Condition con);//Param 필요
	
	public ReviewVO getReview(Integer rew_num);

	public List<ReviewVO> userReview(String user_id);
	
	public ReviewVO getOrdReview(ReviewVO vo);
	
	public void review_deleteAll(Integer pro_num);
}
