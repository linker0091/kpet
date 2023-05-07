package com.kpet.service;

import java.util.List;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;

public interface UserProductService {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_prtcode);
	
	public List<CategoryVO> lastsubCategory(Integer cate_prtcode, Integer cate_subprtcode);
	
	public List<ProductVO> getListWithPaging(Integer cate_prtcode, Criteria cri);
	
	public List<ProductVO> getLastListWithPaging(Integer cate_prtcode, Integer cate_subprtcode, Criteria cri);
	
	public List<ProductVO> getFinallListWithPaging(Integer cate_code, Integer cate_prtcode, Integer cate_subprtcode, Criteria cri);
	
	public int getTotalCount(Integer cate_prtcode);
	
	public int getSubTotalCount(Integer cate_prtcode, Integer cate_subprtcode);
	
	public int getFinallSubTotalCount(Integer cate_code, Integer cate_prtcode, Integer cate_subprtcode);
	
	public ProductVO productDetail(Integer	pro_num);
	
	public List<ProductVO> productListByCategory(Integer cate_code);
	
	public List<ProductVO> lastCategory(Integer cate_prtcode, Integer cate_subprtcode);
	
	public List<ProductVO> productSearchList(String orderby, Condition con, Criteria cri);
	
	public int productSearchCount(Condition con, Criteria cri);
}
