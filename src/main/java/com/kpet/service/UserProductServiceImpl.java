package com.kpet.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.ProductVO;
import com.kpet.mapper.UserProductMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor // 필드를 이용한 생성자메서드 생성. 파라미터를 이용한 생성자메서드가 존재하면 자동주입
@Service
public class UserProductServiceImpl implements UserProductService {

	private UserProductMapper mapper;
	
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
		System.out.println("서비스" + cate_prtcode);
		System.out.println("서비스" + cate_subprtcode);
		return mapper.lastsubCategory(cate_prtcode, cate_subprtcode);
	}

	@Override
	public List<ProductVO> getListWithPaging(Integer cate_prtcode, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cate_prtcode, cri);
	}
	
	@Override
	public List<ProductVO> getLastListWithPaging(Integer cate_prtcode, Integer cate_subprtcode, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getLastListWithPaging(cate_prtcode, cate_subprtcode, cri);
	}
	
	@Override
	public List<ProductVO> getFinallListWithPaging(Integer cate_code, Integer cate_prtcode, Integer cate_subprtcode,
			Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getFinallListWithPaging(cate_code, cate_prtcode, cate_subprtcode, cri);
	}

	@Override
	public int getTotalCount(Integer cate_prtcode) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cate_prtcode);
	}
	
	@Override
	public int getSubTotalCount(Integer cate_prtcode, Integer cate_subprtcode) {
		// TODO Auto-generated method stub
		return mapper.getSubTotalCount(cate_prtcode, cate_subprtcode);
	}
	
	@Override
	public int getFinallSubTotalCount(Integer cate_code, Integer cate_prtcode, Integer cate_subprtcode) {
		// TODO Auto-generated method stub
		return mapper.getFinallSubTotalCount(cate_code, cate_prtcode, cate_subprtcode);
	}

	@Override
	public ProductVO productDetail(Integer pro_num) {
		// TODO Auto-generated method stub
		return mapper.productDetail(pro_num);
	}

	@Override
	public List<ProductVO> productListByCategory(Integer cate_code) {
		// TODO Auto-generated method stub
		return mapper.productListByCategory(cate_code);
	}

	@Override
	public List<ProductVO> lastCategory(Integer cate_prtcode, Integer cate_subprtcode) {
		// TODO Auto-generated method stub
		return mapper.lastCategory(cate_prtcode, cate_subprtcode);
	}

	@Override
	public List<ProductVO> productSearchList(String orderby,Condition con, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.productSearchList(orderby,con,cri);
	}

	@Override
	public int productSearchCount(Condition con, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.productSearchCount(con, cri);
	}
	



}
