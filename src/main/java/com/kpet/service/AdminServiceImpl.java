package com.kpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpet.domain.AdminVO;
import com.kpet.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Override
	public AdminVO adminLogin(String ad_id) {
		// TODO Auto-generated method stub
		return mapper.adminLogin(ad_id);
	}

	@Override
	public int adminRegister(AdminVO vo) {
		// TODO Auto-generated method stub
		return mapper.adminRegister(vo);
	}

	@Override
	public List<AdminVO> getAdminList() {
		// TODO Auto-generated method stub
		return mapper.getAdminList();
	}
	
	@Override
	public int getAdminTotalCount() {
		// TODO Auto-generated method stub
		return mapper.getAdminTotalCount();
	}

	@Override
	public void adDelete(String ad_id) {
		// TODO Auto-generated method stub
		mapper.adDelete(ad_id);
	}

	@Override
	public void adPosition_modify(String ad_id, String ad_position) {
		// TODO Auto-generated method stub
		mapper.adPosition_modify(ad_id, ad_position);
		
	}

	

}
