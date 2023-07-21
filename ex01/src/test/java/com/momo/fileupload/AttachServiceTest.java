package com.momo.fileupload;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.service.AttachService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AttachServiceTest {
	
	@Autowired
	AttachService service;
	
	@Test
	public void deleteTest() {
		assertNotNull(service);
		int delete = service.delete(50, "8c17c6a0-154f-4a6e-b302-bfdda197159c");
		log.info("delete:" + delete);
	}

}
