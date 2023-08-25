package com.kh.teampl.recipe;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teampl.recipe.vo.IndexCarouselDto;
import com.kh.teampl.user.LoginUserDto;
import com.kh.teampl.user.UserVo;
import com.kh.teampl.util.RecipeUtil;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	
	@Autowired
	RecipeService recipeService;
	
	@RequestMapping(value = "/recipeList", method = RequestMethod.GET)
	public String recipeList(PagingDto pagingDto, Model model) { 
		
		// 1. Set Categories
		RecipeUtil.setCategories(pagingDto);
		// System.out.println(pagingDto.getCategories());
		
		// 2. Pagination
		// pagingDto.setTotalArticle(recipeService.getMenuCount());
		// pagingDto.calc(); // get endRow from page, articlePerPage, totalArticle
			
		System.out.println("[RecipeController] pagingDto");
		System.out.println(pagingDto);
		
		// System.out.println(categories);
	
		// 3 rows per page
		int rowNum = 3;
		// int rowNum = (int)Math.ceil((double)menuList.size() / colNum );
				
		model.addAttribute("rowNum", rowNum);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("menuList", recipeService.getMenuListPerPage(pagingDto));
		
		// System.out.println("[recipeController] recipeList");
		
		return "/recipe/recipeList";
	}
	
	@RequestMapping(value = "/addRecipe", method = RequestMethod.GET)
	public String addRecipe() {		
		
		System.out.println("[recipeController] addRecipe");
		
		return "/recipe/addRecipe";
	}
	
	// 모든 양식 다 채워야 전송가능하도록 조절할 것 -> addRecipe.jsp 
	@RequestMapping(value = "/addRecipeRun", method = RequestMethod.POST)
	public String addRecipeRun(RecipeDto recipeDto) {		
		
		System.out.println("[recipeController] addRecipeRun");
		System.out.println(recipeDto);
		
		recipeService.addMenu(recipeDto);

		return "redirect:/recipe/recipeList";
	}
	
	@RequestMapping(value = "/recipeDetail", method = RequestMethod.GET)
	public String recipeDetail(int mno, Model model, HttpSession session) {
		
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		String id = "";
		if (userDto != null) {
			id = userDto.getId();
		}
		
		model.addAttribute("id", id);
		
		System.out.println("[recipeController recipeDetail] mno : " + mno);
		System.out.println(mno);
		
		RecipeDto recipeDto = recipeService.getMenu(mno);
		model.addAttribute("recipeDetail", recipeDto);
		model.addAttribute("mno", mno);
		return "/recipe/recipeDetail";
	}
	
	/* update */
	@RequestMapping(value = "/getAttachList/{mno}", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getAttachList(@PathVariable int mno) throws Exception {
		List<String> attachList = recipeService.getAttachList(mno);
		
		return attachList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getIngredients/{mno}", method = RequestMethod.GET) 
	public List<String> getIngredients(@PathVariable int mno) throws Exception {
		RecipeDto recipeDto = recipeService.getMenu(mno);
		
		return recipeDto.getIngredients();
	}
	
	@ResponseBody
	@RequestMapping(value = "/getRecipe/{mno}", method = RequestMethod.GET) 
	public List<String> getRecipe(@PathVariable int mno) throws Exception {
		RecipeDto recipeDto = recipeService.getMenu(mno);
		
		return recipeDto.getRecipe();
	}
	
	@RequestMapping(value = "/updateRecipe", method = RequestMethod.POST)
	public String updateRecipe(RecipeDto recipeDto) {		
		
		System.out.println("[recipeController] updateRecipe");
		System.out.println(recipeDto);
		
		// recipeService.addMenu(recipeDto);

		return "redirect:/recipe/recipeList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMfileNames", method = RequestMethod.GET) 
	public List<IndexCarouselDto> getMfileNames() throws Exception {
		
		List<IndexCarouselDto> list = recipeService.getIndexCarouselDtoList();
		int count = 3;
			
		return RecipeUtil.getRandMfilenames(list, count);
	}
	
	@ResponseBody
	@RequestMapping(value="/recipeDelete/{mno}", method=RequestMethod.GET)
	public void deleteRecipe(@PathVariable int mno) throws Exception{
		recipeService.recipeDelete(mno);
	}
}
