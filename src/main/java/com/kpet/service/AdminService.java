package com.kpet.service;

import java.util.Date;
import java.util.List;

import com.kpet.domain.AdminVO;

public interface AdminService {

	public AdminVO adminLogin(String ad_id);
	
	public int adminRegister(AdminVO vo);
	
	public List<AdminVO> getAdminList();
	
	public int getAdminTotalCount();
	
	public void adDelete(String ad_id);
	
	public void adPosition_modify(String ad_id, String ad_position);

	public int updateLastlogin(Date ad_lastlogin, String ad_id);
}
