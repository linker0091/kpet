package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;

public interface UserProductMapper {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_prtcode);
	
	public List<CategoryVO> lastsubCategory(@Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode")  Integer cate_subprtcode);
	
	public List<ProductVO> getListWithPaging(@Param("cate_prtcode") Integer cate_prtcode, @Param("cri") Criteria cri);
	
	public List<ProductVO> getLastListWithPaging(@Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode") Integer cate_subprtcode, @Param("cri") Criteria cri);
	
	public List<ProductVO> getFinallListWithPaging(@Param("cate_code") Integer cate_code, @Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode") Integer cate_subprtcode, @Param("cri") Criteria cri);
	
	public int getTotalCount(Integer cate_prtcode);
	
	public int getSubTotalCount(@Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode") Integer cate_subprtcode);
	
	public int getFinallSubTotalCount(@Param("cate_code") Integer cate_code, @Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode") Integer cate_subprtcode);
	
	public ProductVO productDetail(Integer	pro_num);
	
	// Top:1, Pants:2, Shirts:3
	public List<ProductVO> productListByCategory(Integer cate_code);

	public List<ProductVO> lastCategory(@Param("cate_prtcode") Integer cate_prtcode, @Param("cate_subprtcode") Integer cate_subprtcode);
	
	public List<ProductVO> productSearchList(@Param("orderby")String orderby, @Param("con") Condition con, @Param("cri") Criteria cri);
	
	public int productSearchCount(@Param("con") Condition con, @Param("cri") Criteria cri);
}
