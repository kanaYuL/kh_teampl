package com.kh.teampl.recipe;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.recipe.vo.AttachVo;
import com.kh.teampl.recipe.vo.IndexCarouselDto;
import com.kh.teampl.recipe.vo.IngredientsVo;
import com.kh.teampl.recipe.vo.MenuCategoryVo;
import com.kh.teampl.recipe.vo.MenuVo;
import com.kh.teampl.recipe.vo.RecipeVo;
import com.kh.teampl.util.RecipeUtil;

@Service
public class RecipeService {
	
	@Autowired
	RecipeDao recipeDao;
	
	public int getMenuCount() {
		return recipeDao.getMenuCount();
	}
	
	@Transactional
	public void addMenu(RecipeDto recipeDto) {		
		
		// 1. tbl_menu (menuVo) ( column mfilename : 대표 이미지 ) 
		MenuVo menuVo = RecipeUtil.getMenuVo(recipeDto);
		recipeDao.addMenu(menuVo);
		
		// 2. get mno from tbl_menu
		Optional<Integer> maybeMno = recipeDao.getMnoAtItem(recipeDto.getRecipeTitle());
		Integer mno = maybeMno.orElse(0);
		
		System.out.println("[RecipeService] mno : " + mno);
		
		// 3. add Categories
		List<MenuCategoryVo> catVoList = RecipeUtil.getCategoryVoList(recipeDto, mno);
		for(MenuCategoryVo vo : catVoList) {
			// System.out.println(vo.toString());
			recipeDao.addCategory(vo);
		}
		
		// 4. add Ingredients
		List<IngredientsVo> ingVoList = RecipeUtil.getIngredientsVoList(recipeDto, mno);
		for(IngredientsVo vo : ingVoList) {
			// System.out.println(vo.toString());
			recipeDao.addIngredients(vo);
		}
		
		// 5. add Recipes
		List<RecipeVo> recVoList = RecipeUtil.getRecipeVoList(recipeDto, mno);
		for(RecipeVo vo : recVoList) {
			// System.out.println(vo.toString());
			recipeDao.addRecipe(vo);
		}
		
		// 6. add Filename
		List<AttachVo> athVoList = RecipeUtil.getAttachVoList(recipeDto, mno);
		for(AttachVo vo : athVoList) {
			// System.out.println(vo.toString());
			recipeDao.addAttach(vo);
		}

	}
	
	public List<MenuVo> getMenuList() {
		return recipeDao.getMenuList();
	}
	
	@Transactional
	public List<MenuVo>	getMenuListPerPage(PagingDto pagingDto) {
		
		// 1. 검색 조건에 해당하는 List의 갯수 구해서 pagingDto에 반영 -> totalArticle
		pagingDto.setTotalArticle(recipeDao.getMenuCountAtSearch(pagingDto));
		pagingDto.calc();
		
		// 2. pagingDto에 해당하는 list를 return
		System.out.println("[RecipeService] pagingDto");
		System.out.println(pagingDto);
		return recipeDao.getMenuListPerPage(pagingDto);
	}
	
	public void deleteAttach(String filename) {
		recipeDao.deleteAttach(filename);
	}
	
	@Transactional
	public RecipeDto getMenu(int mno) {
		RecipeDto recipeDto = new RecipeDto();
		
		// 1. getMenu -> recipeTitle
		MenuVo vo = recipeDao.getMenu(mno);
		recipeDto.setRecipeTitle(vo.getMname());

		// 2. getIngredients -> ingredients   
		List<String> ingList = recipeDao.getIngredients(mno);
		recipeDto.setIngredients(ingList);
		
		// 3. getRecipe -> recipe
		List<String> recList = recipeDao.getRecipe(mno);
		recipeDto.setRecipe(recList);
		
		// 4. getAttach -> filenames
		List<String> filenames = recipeDao.getAttachList(mno);
		recipeDto.setFilenames(filenames);
		 
		// System.out.println("[RecipeService getMenu] recipeDto ");
		// System.out.println(recipeDto);
		
		return recipeDto;
	}
	
	public List<String> getAttachList(int mno) {
		return recipeDao.getAttachList(mno);
	}
	
	@Transactional
	public void updateMenu(int mno) {
		// 1. tbl_menu (menuVo) ( column mfilename : 대표 이미지 ) 
		
		
		
		// 2. getIngredients -> ingredients  
		
		// 3. getRecipe -> recipe
		
		// 4. getAttach -> filenames
	}
	
	// index.jsp 
	public List<IndexCarouselDto> getIndexCarouselDtoList() {
		return recipeDao.getIndexCarouselDtoList();
	}
	
	public void recipeDelete(int mno) {
		recipeDao.recipeDelete(mno);
	}
}
