package com.kpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.AttachFileDTO;
import com.kpet.domain.BoardAttachVO;
import com.kpet.domain.BoardVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.UserVO;
import com.kpet.service.BoardService;
import com.kpet.util.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@RequestMapping("/board/*")  // /board 로 시작하는 주소는 BoardController클래스가 요청을 담당하는 의미.
@Controller
@AllArgsConstructor
public class BoardController {

	//private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 생성자를 이용한 주입 : @AllArgsConstructor
	private BoardService service;
	
	
	//게시판 글쓰기 폼
	@GetMapping("/register")  //  /board/register 주소가 jsp파일명으로 사용한다.  "/WEB-INF/views/" + "/board/register" + ".jsp"
	public void register() {
		
	}
	
	// 게시판 글쓰기 저장.  BoardVO클래스 : 게시판입력데이타 정보, 파일첨부정보
	@PostMapping("/register") // /board/register.  사용자가 입력한 데이터는 BoardVO클래스의 setter메서드를 통하여 필드에 저장된다.
	public String register(BoardVO board,HttpSession session, RedirectAttributes rttr) {
		board.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
		
		log.info("BoardVO.... " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach)); // 람다식 문법유형
		}
		
		//1)
		service.register(board);
		
		
		
		return "redirect:/board/list";
		
	}
		
	// 2번째 파라미터 : Model model -> 스프링에서 자동으로 객체를 생성및대입
	// 1번째 파라미터 : Criteria cri
	//  1)/board/list 주소요청 Criteria클래스의 기본생성자 메서드가 자동호출   
	//  2)http://localhost:8888/board/list?pageNum=1&amount=20.  Criteria setter메서드가 작동됨.
	@GetMapping("/list")  
	public void list(Criteria cri, Model model) {
		
		log.info("list: " + cri);
		
		//1) list.jsp(뷰) 목록에 사용될 데이타
		List<BoardVO> list = service.getListWithPaging(cri); // pageNum=1, amount=10, 검색기능추가 type=검색종류, keyword=검색어
		model.addAttribute("list", list);
		
		//list.jsp(뷰) 의 페이징기능.   prev 1	2	3	4	5 next
		
		int total = service.getTotalCount(cri);
		
		log.info("total: " + total);
		
		//2) pageMaker : startPage, endPage, prev, next, cri(pageNum, amount, type, keyword) 필드를 jsp에서 사용할수가 있다.
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);

	}
	
	
	
	// 게시물읽기, 수정폼.         http://localhost:8888/board/get?pageNum=1&amount=10&type=&keyword=&bno=65541
	@GetMapping({"/get", "/modify"}) // 목록에서 선택한 게시물번호의 내용보기.  1)get.jsp: /board/get?bno=1  2)modify.jsp:  /board/modify?bno=1
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("get...  " + bno);
		
		BoardVO board = service.get(bno);
		model.addAttribute("board", board);
	}
	
	@PostMapping("/modify")  //   /board/modify  날짜데이터 포맷이 2022/01/05 일 경우는 정상. 2022-01-05 포맷은 에러발생. 오류 400 : 잘못된 요청문법
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		
		
		log.info("modify: " + board);
		
		service.modify(board);

		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")   //   /board/remove
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		
		
		// 파일정보 읽어오기.게시물(파일정보)삭제하기전에 파일첨부정보를 먼저 읽어와야 한다.
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		//게시물삭제(파일첨부 삭제포함)
		if(service.delete(bno)) {
					
			//파일삭제
			deleteFiles(attachList);
			
		}
		
		//  http://localhost:8888/board/list?pageNum=7&amount=10&type=W&keyword=user2
		// "?pageNum=3&amount=20&type=TC&keyword=%EC%83%88%EB%A1%9C"
		return "redirect:/board/list" + cri.getListLink();
	}
	
	
	// 내부에서 호출목적으로 사용하는 메서드
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info(attachList);
		
		/*
		for(int i=0; i<attachList.size(); i++) {
			//attachList.get(i)
		}
		*/
		
		attachList.forEach(attach -> {
			// attach를 통하여 파일정보를 구성하고, 삭제하는 작업
			
			try {
				Path file = Paths.get("D:\\Dev\\bod_upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				//이미지 파일인 경우 : 썸네일삭제
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("D:\\Dev\\bod_upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				}
				
				
				
				
			}catch(Exception ex) {
				log.error("delete file ertror: " + ex.getMessage());
			}
		});
		
	}

	//파일첨부목록
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		
		ResponseEntity<List<BoardAttachVO>> entity = null;
		
		
		
		entity = new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(bno), HttpStatus.OK);
		
		return entity;
	}
	

	//멀티파일 업로드
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody  // jackson-databind라이브러리에 의하여 json으로 변환되고 @ResponseBody어노테이션이 응답객체의 body영역에 json데이타를 추가하는 기능.
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		
		
		// AttachFileDTO클래스? 첨부된 파일정보를 객체에 담아서, 클라이언트에게 보내고자 하는 목적
		
		ResponseEntity<List<AttachFileDTO>> entity = null;

		//업로드된 파일의 정보를 List컬렉션으로 구성하여, 클라이언트로 보내고자 작업
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		String uploadFolder = "D:\\Dev\\bod_upload"; // 
		String uploadFolderPath = UploadFileUtils.getFolder(); // "운영체제별 구분자를 이용하여" "2022\01\18"

		//  D:\\Dev\\bod_upload\\2022\\01\\19
		File uploadPath = new File(uploadFolder, uploadFolderPath);  
		
		// uploadPath객체가 관리하는 폴더가 존재유무체크.    예>  "D:\\Dev\\upload" "2022/01/18"
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 현재폴더명을 기준하여 상위폴더가 존재하지 않으면 모두 생성
		}
		

		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			// 클라이언트에서 보낸 파일명
			String uploadFileName = multipartFile.getOriginalFilename();
			//1)클라이언트 파일명
			attachDTO.setFileName(uploadFileName);
			log.info("uploadFileName : " + uploadFileName);

			// 중복되지 않는 문자열을 생성
			UUID uuid = UUID.randomUUID();
			
			// 중복되지 않는 문자열을 생성_클라이언트파일명
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			
			try {
				// "D:\\Dev\\bod_upload" "2022/01/18" + 유일한 파일명
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile); //파일복사(업로드)
				
				//2)중복되지 않는 고유의 문자열.  2a88f93f-9b56-4791-af27-1ec2a66d59b6
				attachDTO.setUuid(uuid.toString());
				//3)파일이 업로드되는날짜폴더경로.  "2022\01\18"
				
				//uploadFolderPath = uploadFolderPath.replace("\\", "/");
				
				attachDTO.setUploadPath(uploadFolderPath);
				//업로드 파일이 이미지파일인지 일반파일인지 체크
				if(UploadFileUtils.checkImageType(saveFile)) {
					attachDTO.setImage(true);
					
					//Thumnail 이미지 생성작업
					
					// 출력스트림객체가 생성됨 - 비워있는 파일생성(0byte)
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					//빈파일에 원본이미지 정보를 읽어와서 썸네일이미지 생성작업
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
					
					
				}
				
				list.add(attachDTO);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		entity = new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
		
		return entity;
	}
	
	
	// 파라미터에 유효하지 않은 문자가 존재할 경우에는 에러발생.
	//클라이언트에서 썸네일 이미지 요청에따른 썸네일이미지 리턴메서드
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " + fileName);
		
		ResponseEntity<byte[]> entity = null;
		
		
		File file = new File("D:\\Dev\\bod_upload\\" + fileName);
		
		log.info("file: " + file);
		
		try {
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", Files.probeContentType(file.toPath())); // 브라우저에게 보내는 파일에 대한 MIME정보제공
		entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		//entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), HttpStatus.OK);
		 
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return entity;
		
	}
	
	// 다운로드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		ResponseEntity<Resource> entity = null;
		
		Resource resource = new FileSystemResource("D:\\Dev\\bod_upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		// 클라이언트가 보낸 파일명
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		String downloadName = null;
		
		try {
			downloadName = new String(resourceOriginalName.getBytes("UTf-8"), "ISO-8859-1");
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		entity = new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		
		return entity;
	}
		
	// 파일삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		ResponseEntity<String> entity = null;
		
		log.info("deleteFile: " + fileName);
		
		File file;
		
		try {
			file = new File("D:\\Dev\\bod_upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete(); // 일반파일 또는 썸네일이미지 파일 삭제
			
			// 원본이미지파일 삭제작업
			if(type.equals("image")) {
				
				String orginFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("orginFileName: " + orginFileName);
				
				file = new File(orginFileName);
				
				file.delete();
			}
	
		}catch(Exception ex) {
			ex.printStackTrace();
			//삭제하고자 하는 파일이 존재하지 않았을 경우 예외발생
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		entity = new ResponseEntity<String>("deleted", HttpStatus.OK);
		
		return entity;
		
	}
	
	
	
	
	
	
	
	
}
//