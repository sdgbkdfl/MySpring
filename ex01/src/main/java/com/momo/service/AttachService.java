package com.momo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.momo.vo.AttachVO;

@Service
public interface AttachService {
	
	 List<AttachVO> getList(int bno);
	 
	 int insert(AttachVO attach);
	 
	 int delete(int bno, String uuid);
	 
	 public int fileupload(int bno, List<MultipartFile> files) throws Exception;

	
}
