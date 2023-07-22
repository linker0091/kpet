package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;

public interface AdminProuductMapper {

	public int product_isnert(ProductVO vo);
	
	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_code);
	
	public List<CategoryVO> lastsubCategory(@Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode")Integer cate_subprtcode);
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	//수정폼
	public ProductVO product_modify(Integer pro_num);
	//수정저장
	public int product_modifyOk(ProductVO vo);
	
	public int product_delete(Integer pro_num);
	
	public int product_rew_update(Integer pro_num);
	
	public int product_rew_dlupdate(Integer rew_num);
	
	public int product_update_amount(@Param("pro_amount") Integer pro_amount, @Param("pro_num") Integer pro_num);
	
}
