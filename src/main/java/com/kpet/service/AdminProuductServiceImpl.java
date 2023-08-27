package com.kpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;
import com.kpet.mapper.AdminProuductMapper;
import com.kpet.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;


@Service
public class AdminProuductServiceImpl implements AdminProuductService {

	@Setter(onMethod_ = @Autowired)
	private AdminProuductMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper rew_mapper;
	
	@Override
	public int product_isnert(ProductVO vo) {
		// TODO Auto-generated method stub
		return mapper.product_isnert(vo);
	}

	@Override
	public List<CategoryVO> mainCategory() {
		// TODO Auto-generated method stub
		return mapper.mainCategory();
	}

	@Override
	public List<CategoryVO> subCategory(Integer cate_prtcode) {
		// TODO Auto-generated method stub
		return mapper.subCategory(cate_prtcode);
	}
	
	@Override
	public List<CategoryVO> lastsubCategory(Integer cate_prtcode, Integer cate_subprtcode) {
		// TODO Auto-generated method stub
		return mapper.lastsubCategory(cate_prtcode, cate_subprtcode);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public ProductVO product_modify(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.product_modify(pro_num);
	}

	@Override
	public int product_modifyOk(ProductVO vo) {
		// TODO Auto-generated method stub
		return mapper.product_modifyOk(vo);
	}

	@Transactional
	@Override
	public int product_delete(Integer pro_num) {
		// TODO Auto-generated method stub
		//리뷰 삭제
		rew_mapper.review_deleteAll(pro_num);
		return mapper.product_delete(pro_num);
	}
	
	@Override
	public int product_rew_update(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.product_rew_update(pro_num);
	}

	@Override
	public int product_rew_dlupdate(Integer rew_num) {
		// TODO Auto-generated method stub
		return mapper.product_rew_dlupdate(rew_num);
	}

}
