package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.AdminVO;

public interface AdminMapper {

	public AdminVO adminLogin(String ad_id);
	
	public int adminRegister(AdminVO vo);
	
	public List<AdminVO> getAdminList();
	
	public int getAdminTotalCount();
	
	public void adDelete(String ad_id);
	
	public void adPosition_modify(@Param("ad_id") String ad_id,@Param("ad_position") String ad_position);
}
