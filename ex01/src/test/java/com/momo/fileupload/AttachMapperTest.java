package com.momo.fileupload;

import static org.junit.Assert.assertEquals;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.AttachMapper;
import com.momo.vo.AttachVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AttachMapperTest {

	@Autowired
	AttachMapper attachMapper;
	// 테스트하려고 하는 매퍼 
	
	
	@Test
	public void test() {
		log.info("getList()");
		System.out.println(attachMapper.getList(50));
	}
	
	
	@Test
	public void insertTest() {
		log.info("insert()");
		AttachVO attach = new AttachVO();
		
		//attach.setUuid("uuid"); - uuid 랜덤 자동 생성(중복예방)
		UUID uuid = UUID.randomUUID();
		attach.setUuid(uuid.toString());
		
		attach.setUploadPath("uploadPath");
		attach.setFileName("fileName");
		attach.setFiletype("I");
		attach.setBno(50);

		int res = attachMapper.insert(attach);
		assertEquals(1, res);
		
	}
	
	@Test
	public void deleteTest() {
		log.info("delete()");
		
		AttachVO attach = new AttachVO();
		
		int res = attachMapper.delete(50, "8c17c6a0-154f-4a6e-b302-bfdda197159c" );
		
		assertEquals(1, res);

	}
}
