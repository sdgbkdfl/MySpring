package com.momo.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.momo.service.AttachService;
import com.momo.vo.AttachVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
@Log4j
@Controller
public class FileuploadController extends CommonRestController {
// CommonRestController :  결과에 대한 메시지를 알려주는 컨트롤러
	
	public static final String ATTACHES_DIR = "c:\\upload\\"; 
	//문자로 인식 시키기 위해 슬러시 두개//
	
	@Autowired
	AttachService attachService;
	
	
	/**
	 * 메서드의 리턴타입
	 * 
	 * 	1. String
	 * 		/WEB-INF/views/반환값.jsp 응답페이지 주소
	 *  	servlet-context.xml에 정의되어 있음.
	 *  
	 *  2. void
	 *  	요청주소와 동일한 이름의 jsp를 반환
	 */
	
	// 페이지에 띄우는 메서드
	@GetMapping("/file/fileupload")
	public void fileupload() {
	}

	/**
	 * 파일업로드용 라이브러리 추가
	 * file-fileupload
	 * 
	 * cos.jar와 달리 파일을 저장 하는 로직이 추가 되어야 함
	 * 
	 * 1. 라이브러리 추가
	 * 2. multipartResolver 빈 등록
	 * 3. 메서드의 매개변수로 MultipartFile이용(root-conxt에 등록)
	 * @param mr
	 */
	
	/*
	 * UUID
	 * 
	 * 소프트 웨어 구축에 쓰이는 식별자 표준
	 * 파일이름이 중복되어 파일이 소실되지 않도록 저장
	 * 유효 아이디 => 식별자
	 * 
	 * */
	
	@PostMapping("/file/fileuploadAction")
	public String fileuploadAction(int bno, List<MultipartFile> files 
							,RedirectAttributes rttr)throws Exception {
		
		int insertRes = attachService.fileupload(bno, files);
		
		String msg = insertRes + "건 저장되었습니다.";
		rttr.addAttribute("msg", msg);
		
		//루트 경로 잡아줘야함
		return "redirect:/file/fileupload";
	}
	
	@PostMapping("/file/fileuploadActionFetch")
	public @ResponseBody Map<String, Object> 
			fileuploadActionFetch(int bno, List<MultipartFile> files) throws Exception{
		
		log.info("fileuploadActionFetch");
		int insertRes = attachService.fileupload(bno, files);
		log.info("업로드 건수 : "+insertRes);
		return responseMap("success", insertRes + "건 저장되었습니다.");		
	}
	
	/**
	 * json 방식으로 받아주기위해 ResponseBody 달아줌
	 * @param bno
	 * @return
	 */
	@GetMapping("/file/list/{bno}")
	public @ResponseBody Map<String, Object> fileuploadList(@PathVariable("bno") int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", attachService.getList(bno));
		return map;
	}
	
	public static void main(String[] args) {
		LocalDate currentDate = LocalDate.now();
		String uploadPath = currentDate.toString().replace("-", File.separator)
				+ File.separator;
		System.out.println("CurrentDate : "+ currentDate);
		System.out.println("경로 : "+ uploadPath);
	}
	

	@GetMapping("/file/delete/{bno}/{uuid}")
	public @ResponseBody Map<String, Object> delete(
							@PathVariable("bno") int bno,
							@PathVariable("uuid") String uuid){
		
		int res= attachService.delete(bno, uuid);
		
		 // 파일 삭제 로직을 추가하고, 성공 여부에 따라 처리
		if(res>0) {
			return responseDeleteMap(res);
		}else {
			return responseDeleteMap(res);
			
		}
	}
	
	/**
	 * 첨부파일 다운로드
	 * 	컨텐츠 타입을 다운로드 받을 수 있는 형식으로 지정하여
	 * 	브라우저에서 파일을 다운로드 받을 수 있게 처리
	 * 	(한글깨짐에 대한 처리)
	 * 
	 * ResponseEntity : 헤더 지정하고 반환
	 * 
	 * @param fileName
	 * @param ResponseEntity 
	 * @param HttpStatus 
	 * @return
	 */
	@GetMapping("/file/download")
	public @ResponseBody ResponseEntity<byte[]> download(String fileName){
		log.info("download file : " + fileName);
		HttpHeaders headers = new HttpHeaders();
		
		//파일 있는지 없는지 확인
		File file = new File(ATTACHES_DIR + fileName);
		
		if(file.exists()) {
			// 존재하면 컨텐츠 타입을 지정
			// APPLICATION_OCTET_STREAM : 이진 파일의 콘텐츠 유형
			headers.add("contentType"
					, MediaType.APPLICATION_OCTET_STREAM.toString());
			
			//파일이름에 대한 한글처리
			try {
				headers.add("Content-Disposition", "attachment; filename=\""
						+ new String(file.getName().getBytes("utf-8"),"ISO-8859-1")+ "\"");
				return new ResponseEntity<>(
						FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
															// HttpStatus.OK : 응답결과코드
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				
			} catch (IOException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
}


















