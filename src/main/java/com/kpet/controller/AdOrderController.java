package com.kpet.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderInfo;
import com.kpet.domain.OrderVO;
import com.kpet.domain.PageDTO;
import com.kpet.service.AdminOrderService;
import com.kpet.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/order/*")
@Controller
public class AdOrderController {
	
	@Resource(name = "uploadFolder")
	String uploadFolder; // d:\\dev\\upload */
	
	@Inject
	private AdminOrderService Service;

	@GetMapping("/orderList")
	public void orderList(Criteria cri, @ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate, Model model) {
		
		log.info("시작날짜: " + startDate);
		log.info("종료날짜: " + endDate);
		
		cri.setAmount(5);
		List<OrderVO> list = Service.getListWithPaging(cri, startDate, endDate);
		
				
		
		int total = Service.getTotalCount(cri, startDate, endDate);
		model.addAttribute("ord_total", total);
		
		//주문상태별 건수
		model.addAttribute("ord_count",  Service.getOrderStateCount("주문접수")); //주문접수
		model.addAttribute("ord_pay", Service.getOrderStateCount("결제완료")); //결제완료
		model.addAttribute("ord_delivery", Service.getOrderStateCount("배송준비중")); //배송준비중
		model.addAttribute("ord_cancel", Service.getOrderStateCount("취소요청")); //취소요청
		model.addAttribute("ord_change", Service.getOrderStateCount("교환요청")); //교환요청
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("orderList", list);
		
	}
	
	//주문상태별 목록보기.  jsp파일명은 orderList.jsp파일을 함께 사용한다.
	@GetMapping("/orderStateList")
	public String  orderStateList(@ModelAttribute("ord_state") String ord_state, Criteria cri, Model model)  {
		
		cri.setAmount(1);
		List<OrderVO> list = Service.getOrderStateListWithPaging(cri, ord_state);
		
				
		
		int total = Service.getOrderStateTotalCount(cri, ord_state);
		model.addAttribute("ord_total", total);
		
		//주문상태별 건수
		model.addAttribute("ord_count",  Service.getOrderStateCount("주문접수")); //주문접수
		model.addAttribute("ord_pay", Service.getOrderStateCount("결제완료")); //결제완료
		model.addAttribute("ord_delivery", Service.getOrderStateCount("배송준비중")); //배송준비중
		model.addAttribute("ord_cancel", Service.getOrderStateCount("취소요청")); //취소요청
		model.addAttribute("ord_change", Service.getOrderStateCount("교환요청")); //교환요청
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("orderList", list);
		
		
		return "/admin/order/orderList";
	}
	
	
	//상태일괄변경, 개별주문상태변경
	@ResponseBody  
	@PostMapping("/orderStateAll")
	public ResponseEntity<String> checkDelete(
				@RequestParam("ord_codeArr[]") List<Integer> ord_codeArr, 
				@RequestParam("ord_StateArr[]") List<String> ord_StateArr) {
		
		ResponseEntity<String> entity = null;
		
//		log.info(ord_codeArr);
//		log.info(ord_StateArr);
		
		try {
			
			for(int i=0; i < ord_codeArr.size(); i++) {
				Service.orderStateChange(ord_codeArr.get(i), ord_StateArr.get(i));
			}

			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
	// 주문삭제( 주문테이블, 주무상세테이블)
	@ResponseBody
	//@GetMapping("/checkDelete")
	@PostMapping("/checkDelete")
	//@RequestMapping(value = "/checkDelete", method = {RequestMethod.GET, RequestMethod.POST}  ) 둘다 지원
	public ResponseEntity<String> checkDelete(@RequestParam("ord_codeArr[]") List<Integer> ord_codeArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<ord_codeArr.size(); i++) {
								
				//주문, 주문삭제테이블 삭제작업
				Service.ordDelete(ord_codeArr.get(i));
				
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		
		
		return entity;
	}	
	//상세보기
	@GetMapping("/detailInfo")
	public void detailInfo(Integer ord_code, Model model) {
		
		List<DetailOrderInfo> list = Service.detailOrderInfo(ord_code);
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			DetailOrderInfo vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		//주문번호를 이용한 주문상세정보
		model.addAttribute("oDetailList", list);
		log.info("상세보기 내용 : " + list);
		
	}
	
	@ResponseBody
	@PostMapping("/detailListDelete")
	public ResponseEntity<String> detailListDelete(Integer ord_code, Integer pro_num) {
		ResponseEntity<String> entity = null;
		
		
		try {
			Service.ordDetailDelete(ord_code, pro_num);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//상품리스트의 이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
	
	//주문데이타 엑셀다운
		@GetMapping("/excelDown")
		public void excelDown(HttpServletResponse response,@RequestParam(value="ord_state", required=false)String ord_state, 
				Criteria cri, @RequestParam(value="startDate", required=false)String startDate, @RequestParam(value="endDate", required=false)String endDate) throws Exception {
			
			log.info("시작날짜: " + startDate);
			log.info("종료날짜: " + endDate);
			
			//cri.setAmount(2);
			List<OrderVO> list;
			
			if(ord_state != null) {//주문상태에 따른 데이터갯수
				//주문상태별 엑셀파일의 데이타(내용)
				list = Service.getOrderStateListWithPaging(cri, ord_state);
				int stateTotal = Service.getOrderStateTotalCount(cri, ord_state);
				cri.setAmount(stateTotal);		
			}else{//총개수 + 검색에 따른 데이터 총개수
				log.info("state널일떄cri와 startDate: " + cri + "// Date: " + startDate + endDate);
				int total = Service.getTotalCount(cri, startDate, endDate);
				cri.setAmount(total);
				log.info("검색에따른 총 데이타 개수 : "+ total);	
				//엑셀파일의 데이타(내용)
				list = Service.getListWithPaging(cri, startDate, endDate);		
				
			}
			
			
			
			// MS-Office 2003년도 버전까지
			//Workbook wb = new HSSFWorkbook();
			
			// MS-Office 2003년도 이후
			Workbook wb = new XSSFWorkbook();
			Sheet sheet = wb.createSheet("주문데이타");
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			
			
			// 1)제목행 스타일 적용
			CellStyle headStyle = wb.createCellStyle();
			//가는 경계선
			headStyle.setBorderTop(BorderStyle.THIN);
			headStyle.setBorderBottom(BorderStyle.THIN);
			headStyle.setBorderLeft(BorderStyle.THIN);
			headStyle.setBorderRight(BorderStyle.THIN);
			
			//배경은 노랑색
			headStyle.setFillBackgroundColor(IndexedColors.YELLOW.getIndex());
			headStyle.setFillPattern(FillPatternType.SPARSE_DOTS);
			
			//데이타 가운데정렬
			headStyle.setAlignment(HorizontalAlignment.CENTER);
			
			
			//2)데이터행 경계선
			CellStyle bodyStyle = wb.createCellStyle();
			//가는 경계선
			bodyStyle.setBorderTop(BorderStyle.THIN);
			bodyStyle.setBorderBottom(BorderStyle.THIN);
			bodyStyle.setBorderLeft(BorderStyle.THIN);
			bodyStyle.setBorderRight(BorderStyle.THIN);
			
			
			//제목행 작업
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellStyle(headStyle);
			cell.setCellValue("주문번호");
			
			cell = row.createCell(1);
			cell.setCellStyle(headStyle);
			cell.setCellValue("주문자");
			
			cell = row.createCell(2);
			cell.setCellStyle(headStyle);
			cell.setCellValue("연락처");
			
			cell = row.createCell(3);
			cell.setCellStyle(headStyle);
			cell.setCellValue("주문가격");
			
			cell = row.createCell(4);
			cell.setCellStyle(headStyle);
			cell.setCellValue("주문일");
			
			//데이터 행작업
			
			for(OrderVO vo : list) {
				//주문번호
				row = sheet.createRow(rowNo++);
				
				cell = row.createCell(0);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(vo.getOrd_code());
				
				//주문자
				cell = row.createCell(1);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(vo.getOrd_name());
				
				//연락처
				cell = row.createCell(2);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(vo.getOrd_phone());
				
				//주문가격
				cell = row.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(vo.getOrd_price());
				
				//주문일
				cell = row.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(vo.getOrd_regdate()));
				
				Date dregdate = vo.getOrd_regdate();
				log.info("주문일 확인 : " + dregdate);
		
			}
			
			
			//엑셀출력
			String fileName = "주문데이타.xlsx";
			String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + outputFileName + "\"");
			
			wb.write(response.getOutputStream());
			wb.close();
		
		}
}
