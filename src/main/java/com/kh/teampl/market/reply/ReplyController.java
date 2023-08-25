package com.kh.teampl.market.reply;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kh.teampl.user.LoginUserDto;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	// 목록
	// @RequestParam : ?mbno=500
	// @PathVariable : /{mbno}
	@RequestMapping(value = "/list/{mbno}", method = RequestMethod.GET)
	public List<ReplyVo> list(@PathVariable("mbno") int mbno) {
		List<ReplyVo> list = replyService.list(mbno);
		return list;
	}
	
	// 추가
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(@RequestBody ReplyVo replyVo,	HttpSession session) {
		System.out.println("controller, replyVo1:" + replyVo);
		
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
//		System.out.println("controller, replyVo2:" + replyVo);
		replyVo.setMbrwriter(userDto.getId());
//		System.out.println("controller, replyVo3:" + replyVo);
		replyService.insert(replyVo);
		System.out.println("controller, replyVo4:" + replyVo);
		return "success";
	}
	
	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.PATCH)
	public String update(@RequestBody ReplyVo replyVo) {
//		System.out.println("replyVo: " + replyVo);
		replyService.update(replyVo);
		return "success";
	}
	
	// 삭제
	@RequestMapping(value = "/delete/{mbrno}/{mbno}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("mbrno") int mbrno,
						 @PathVariable("mbno") int mbno) {
		
		// 첫번째 %d = mbrno 값, 두번째 %d = mbno 값 들어감 
//		System.out.printf("mbrno:%d, mbno:%d\n", mbrno, mbno);
		
		replyService.delete(mbrno, mbno);
		return "success";
	}
	
	// 수정날짜 얻어오기
	@RequestMapping(value = "/getUpdatedate", method = RequestMethod.GET)
	public Timestamp getUpdatedate(int mbrno) {
		Timestamp getUpdatedate = replyService.getUpdatedate(mbrno);
		return getUpdatedate;
	}
	
	
}	
