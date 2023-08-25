package com.kh.teampl.market;

import java.security.Key;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.market.dialog.DialogSearchDto;
import com.kh.teampl.market.dialog.MarketboardDialogVo;
import com.kh.teampl.market.like.LikeService;
import com.kh.teampl.market.like.LikeVo;
import com.kh.teampl.user.LoginUserDto;
import com.kh.teampl.util.FileUploadUtil;


@Controller
@RequestMapping(value = "/fleamarket")
public class MarketboardController {
	
	@Resource(name = "fleamarketUploadPath")
	private String fleamarketUploadPath; 
	
	@Autowired
	private MarketboardService marketboardService;
	
	@Autowired
	private LikeService likeService;
	
	
	// 리스트 출력
	@RequestMapping(value = "/fleaMarket", method = RequestMethod.GET)
	public String listAll(Model model) throws Exception {
		List<MarketboardVo> list = marketboardService.listAll();
		List<MarketboardVo> recountList = marketboardService.readcountList();
		
		model.addAttribute("list", list);
		model.addAttribute("recountList", recountList);
		
		//System.out.println("MarketboardController, list:" + list);
		return "fleamarket/fleaMarket";
	}
	
	
	// 게시판 글 읽기(특정글 1개 조회)
	@RequestMapping(value = "/reading", method = RequestMethod.GET)
	public String reading(int mbno, Model model, HttpSession session, 
							MarketboardVo marketboardVo) throws Exception {
		//System.out.println("MarketboardController, reading?mbno=" + mbno);
//		System.out.println("controller, reading, marketboardVo:" + mbno);

		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
//		System.out.println(userDto);
		LikeVo likeVo = new LikeVo();

		likeVo.setMbno(mbno);
		likeVo.setId(userDto.getId());
		
		String likeResult = likeService.setLike(userDto.getId(),mbno);
		
		int likeCount = likeService.setLikeCount(mbno);
		
		Map<String, Object> likeMap = new HashMap<>();
		
		likeMap.put("likeCount", likeCount);
		likeMap.put("likeResult", likeResult);
		
		// 조회수 증가
		marketboardService.readcount(marketboardVo);
		
//		MarketboardVo marketboardVo = marketboardService.reading(mbno);
		marketboardVo = marketboardService.reading(mbno);
		model.addAttribute("marketboardVo", marketboardVo);
		model.addAttribute("likeMap", likeMap);
		return "fleamarket/reading";
	}
	
	
	// localhost/student/create
	@RequestMapping(value = "/writing", method = RequestMethod.GET)
	public String writingGet() throws Exception  {
		System.out.println("writingGet() 호출됨.");
		return "fleamarket/writing";
	}
	
	
	// 추가
	@RequestMapping(value = "/writing", method = RequestMethod.POST)
	public String BoardCreate(MarketboardVo marketboardVo, RedirectAttributes rttr, 
								HttpSession session) throws Exception {
		
		// 작성자는 로그인한 사용자의 아이디
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		marketboardVo.setMbwriter(userDto.getId());
		marketboardService.insert(marketboardVo);
		System.out.println("controller, BoardCreate, marketboardVo, insert:" + marketboardVo);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/fleamarket/reading?mbno=" + marketboardVo.getMbno();
	}
	
	
	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(MarketboardVo marketboardVo, HttpSession session) throws Exception {
		System.out.println("controller, update, marketboardVo:" + marketboardVo);
		
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo"); 
		
		marketboardService.update(marketboardVo);
		return "redirect:/fleamarket/reading?mbno=" + marketboardVo.getMbno();
	}
	
	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int mbno, RedirectAttributes rttr) throws Exception {
		List<String> filenames = marketboardService.getAttachList(mbno);
		for (String fileName : filenames) {
			FileUploadUtil.deleteFile(fleamarketUploadPath, fileName);
		}
		marketboardService.delete(mbno, filenames);
		
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/fleamarket/fleaMarket";
	}
	
	
	@RequestMapping(value = "/getAttachList/{mbno}", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getAttachList(@PathVariable int mbno) throws Exception {
		List<String> attachList = marketboardService.getAttachList(mbno);
		return attachList;
	}
	
	@RequestMapping(value = "/searchList", method=RequestMethod.POST)
    @ResponseBody
    public List<MarketboardVo> searchList(@RequestBody SearchDto searchDto) throws Exception{
        List<MarketboardVo>list =  marketboardService.searchList( searchDto.getKeyword(), searchDto.getCategories());
        return list;	
	}
	
	@RequestMapping(value="/soldOut", method=RequestMethod.GET)
	public String soldOut(int mbno)throws Exception{
		marketboardService.soldOut(mbno);
		return "redirect:/fleamarket/reading?mbno=" + mbno;
	}
	
	@RequestMapping(value = "/insertDialog", method= RequestMethod.POST)
	@ResponseBody
	public MarketboardDialogVo insertDialog(@RequestBody MarketboardDialogVo marketboardDialogVo, HttpSession session)throws Exception{
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		marketboardDialogVo.setAttendant(userDto.getId());
		//System.out.println(marketboardDialogVo);
		marketboardService.insertDialog(marketboardDialogVo);
		return marketboardDialogVo;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDialogList", method = RequestMethod.POST)
	public List<MarketboardDialogVo> getDialogList(@RequestBody DialogSearchDto dialogSearchDto) throws Exception{
		List<MarketboardDialogVo>list =  marketboardService.getDialogList(dialogSearchDto);
		return list;
	}
	
	@RequestMapping(value = "/getAttendantList/{mbno}", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getAttendantList(@PathVariable int mbno) throws Exception {
		List<String> list = marketboardService.getAttendantList(mbno);
		return list;
	}
	@RequestMapping("/fleamarket/totalPages")
    public ResponseEntity<Integer> getTotalPages(@RequestParam(defaultValue = "10") int itemsPerPage) throws Exception{
        int totalItems = marketboardService.getTotalItems();
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
        return ResponseEntity.ok(totalPages);
    }
	
	@RequestMapping(value = "/searchListAll", method=RequestMethod.POST)
	@ResponseBody
	public List<MarketboardVo> searchListAll(@RequestBody SearchDto searchDto) throws Exception{
		List<MarketboardVo>searchListAll =  marketboardService.searchListAll(searchDto.getKeyword());
		return searchListAll;	
	}
}
