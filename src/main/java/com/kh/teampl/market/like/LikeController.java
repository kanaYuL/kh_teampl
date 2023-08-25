package com.kh.teampl.market.like;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teampl.user.LoginUserDto;
import com.kh.teampl.user.UserVo;


@Controller
@RequestMapping("/like")
public class LikeController {

	@Autowired
	private LikeService likeService;
	

	@ResponseBody
	@RequestMapping(value="/plus", method = RequestMethod.GET)
	public void plusLike(int mbno, HttpSession session) {
		//System.out.println(bno);
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		likeService.plusLike(userDto.getId(), mbno);
	}
	
	@ResponseBody
	@RequestMapping(value="/cancel", method = RequestMethod.GET)
	public void cancelLike(int mbno, HttpSession session) {
		//System.out.println(bno);
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		likeService.cancelLike(userDto.getId(), mbno);
	}
	
	@ResponseBody
	@RequestMapping(value="/set", method = RequestMethod.GET)
	public String setLike(int mbno, HttpSession session) {
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		String str = likeService.setLike(userDto.getId(), mbno);
		if(str.equals("yes"))
			return str;
		return "no";
	}
	@ResponseBody
	@RequestMapping(value="/setCount", method = RequestMethod.GET)
	public int setLikeCount(int mbno) {
		System.out.println(mbno);
		int count = likeService.setLikeCount(mbno);
		
		return count;
	}
}