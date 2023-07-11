package com.momo.reply;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.ReplyMapper;
import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;
import com.sun.tools.sjavac.Log;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	
	@Autowired
	ReplyMapper mapper;
	
	@Test
	public void test() {
		assertNotNull(mapper);
		Criteria cri = new Criteria();
		//setPageNo와 setAmount 순서 바뀌면 제대로 적용안됨
		cri.setAmount(5); // 5개씩 출력
		cri.setPageNo(1); // 1페이지
		List<ReplyVO> list = mapper.getList(50, cri);
		Log.info("list :" + list);
	}
	
	@Test
	public void insertTest() {
		ReplyVO replyVo = new ReplyVO();
		replyVo.setBno(50);
		replyVo.setReply("댓글작성");
		replyVo.setReplyer("댓글작성자");
		
		int res= mapper.insert(replyVo);
		
		//결과값 한건인지 체크
		assertEquals(res, 1);
	}
	
	@Test
	public void deleteTest() {
		int rno = 1;
		int res = mapper.delete(rno);
		
		assertEquals(1, res);
	}
	
	@Test
	public void updateTest() {
		ReplyVO replyVo = new ReplyVO();
		replyVo.setBno(50);
		replyVo.setReply("댓글 수정");
		replyVo.setReplyer("댓글작성자");
		
		int res= mapper.update(replyVo);
		
		//결과값 한건인지 체크
		assertEquals(res, 1);
	}
	@Test
	public void totalCntTest() {
		int res = mapper.totalCnt(50);
		System.out.println(res);
	}
	
	
}
