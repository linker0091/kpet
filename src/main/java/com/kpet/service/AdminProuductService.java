package com.kpet.service;

import java.util.List;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;

public interface AdminProuductService {

	public int product_isnert(ProductVO vo);
	
	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_prtcode);
	
	public List<CategoryVO> lastsubCategory(Integer cate_prtcode, Integer cate_subprtcode);
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public ProductVO product_modify(Integer pro_num);
	
	public int product_modifyOk(ProductVO vo);
	
	public int product_delete(Integer pro_num);
	
	public int product_rew_update(Integer pro_num);

	public int product_rew_dlupdate(Integer rew_num);
}
