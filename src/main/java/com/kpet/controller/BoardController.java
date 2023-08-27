package com.kpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
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
@RequestMapping("/board/*")
@Controller
@AllArgsConstructor
public class BoardController {
	
	// 생성자를 이용한 주입 : @AllArgsConstructor
	private BoardService service;	
	
	//CKEditor 이미지 업로드 폴더
	@javax.annotation.Resource(name = "ckUploadFolder")//(//download core.io.Resource와 명칭 중복)
	String ckUploadFolder;
	
	//게시판 글쓰기 폼
	@GetMapping("/register") 
	public void register() {
		
	}
	
	//CKEditor 문의게시판 설명 이미지.
		@PostMapping("/editor/imageUpload")
		public void imageUpload(HttpServletRequest request, HttpServletResponse response,@RequestParam MultipartFile upload) {
			
			/*
			 CKEditor 파일업로드 1)파일업로드 작업 2) 업로드된 파일정보를 브라우저에게 보내야 한다. 
			  
			 */
			
			// 클라이언트로부터 전송되어 온 파일을 업로드폴더에 복사(생성)작업
			OutputStream out = null;
			
			// 업로드된 파일정보를 브라우저에게 보내는 작업
			PrintWriter printWriter = null;
			
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			
			try {
				String fileName = upload.getOriginalFilename();
				byte[] bytes = upload.getBytes();
				
				// 클라이언트에서 전송해 온 파일명을 포함하여, 실제 업로드되는 경로생성
				//String uploadPath = request.getSession().getServletContext().getRealPath("/resources/cst_upload/") + fileName;
				
				//물리적 경로
				String uploadPath = ckUploadFolder + "\\WEB-INF\\views\\board\\upload\\" + fileName;  

				log.info("업로드폴더 물리적경로: " + uploadPath);
				
				out = new FileOutputStream(new File(uploadPath)); // 0byte의 빈 파일생성
				
				// 파일에 내용이 채워짐.
				out.write(bytes);
				out.flush();
				
				/*======================================================================*/
				
				String callback = request.getParameter("CKEditorFuncNum");
				
				log.info(callback);
				
				printWriter = response.getWriter();
				
				// <resources mapping="/board_upload/**" location="/resources/board_upload/" />
				String fileUrl = "/board_upload/" + fileName;
				log.info("fileUrl"+fileUrl);
				printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
									+ callback
									+ ",'"
									+ fileUrl
									+ "','이미지를 업로드 하였습니다.'"
									+ ")</script>");
				printWriter.flush();
			
			}catch(Exception ex) {
				ex.printStackTrace();
			}finally {
				try {
				if(out != null) out.close();
				if(printWriter != null) printWriter.close();
				}catch(Exception ex) {
					ex.printStackTrace();
				}
				
			}
			
		}
		
	
	// 게시판 글쓰기 저장.  BoardVO클래스 : 게시판입력데이타 정보, 파일첨부정보
	@PostMapping("/register") 
	public String register(BoardVO board,HttpSession session, RedirectAttributes rttr) {
		
		board.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
		
		log.info("BoardVO.... " + board);
		
		//첨부된 파일의 정보를 담는 로그
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach)); // 람다식 문법유형
		}
		
		service.register(board);
		
		return "redirect:/board/list";
		
	}

	//게시판 목록
	@GetMapping("/list")  
	public void list(Criteria cri, Model model) {
		
		log.info("list: " + cri);
		
		//1) list.jsp(뷰) 목록에 사용될 데이타
		List<BoardVO> list = service.getListWithPaging(cri); // pageNum=1, amount=10, 검색기능추가 type=검색종류, keyword=검색어
		model.addAttribute("list", list);
		log.info("board_list: " + list);
		//list.jsp(뷰) 의 페이징기능.   prev 1	2	3	4	5 next
		
		//총 게시글 수
		int total = service.getTotalCount(cri);
		
		log.info("total: " + total);
		
		//2) pageMaker : startPage, endPage, prev, next, cri(pageNum, amount, type, keyword) 필드를 jsp에서 사용할수가 있다.
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);

	}
	
	// 게시물읽기, 수정폼. 
	@GetMapping({"/get", "/modify"}) 
	public void get(@RequestParam("bno") Long bno, HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {
		
		String loginId = ((UserVO) session.getAttribute("loginStatus")).getUser_id();
		log.info("get...  " + bno);
		
		BoardVO board = service.get(bno);
		model.addAttribute("board", board);
		model.addAttribute("loginId", loginId);
	}
	
	// 게시물 수정 저장
	@PostMapping("/modify")
	public String modify(BoardVO board, HttpSession session, Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify: " + board);
		board.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
		service.modify(board);

		return "redirect:/board/list" + cri.getListLink();
	}
	
	//게시물 삭제
	@PostMapping("/remove") 
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
		return "redirect:/board/list" + cri.getListLink();//이전 페이지 정보
	}
	
	// 내부에서 호출목적으로 사용하는 메서드 / 파일 삭제
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info(attachList);
		
		attachList.forEach(attach -> {
			// attach를 통하여 파일정보를 구성하고, 삭제하는 작업
			
			try {
				//일반 파일인 경우
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
	@ResponseBody
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
					
					//썸네일이미지 생성작업
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
	
	// 파일 다운로드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		ResponseEntity<Resource> entity = null;
		
		Resource resource = new FileSystemResource("D:\\Dev\\bod_upload\\" + fileName);
		
		//존재 여부 확인  : 없을 경우
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