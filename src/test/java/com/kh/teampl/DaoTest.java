package com.kh.teampl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.OptionalInt;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.teampl.recipe.PagingDto;
import com.kh.teampl.recipe.RecipeController;
import com.kh.teampl.recipe.RecipeDao;
import com.kh.teampl.recipe.vo.AttachVo;
import com.kh.teampl.recipe.vo.IngredientsVo;
import com.kh.teampl.recipe.vo.MenuCategoryVo;
import com.kh.teampl.recipe.vo.MenuVo;
import com.kh.teampl.recipe.vo.RecipeVo;
import com.kh.teampl.user.JoinDto;
import com.kh.teampl.user.LoginDto;
import com.kh.teampl.user.UserDao;
import com.kh.teampl.user.UserVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})

public class DaoTest {
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	RecipeDao recipeDao;
	
	@Test
	public void testIsDupId() {
		String id = "cigr46";
		boolean result = userDao.isDupId(id);

		System.out.println(result);
	}
	
	@Test
	public void testCreateUser() {
		JoinDto joinDto = new JoinDto();
		
		joinDto.setId("cigr47");
		joinDto.setPwd("72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236");
		joinDto.setEmail("cigr47@naver.com");
		
		userDao.createUser(joinDto);
	}
	
	@Test
	public void testLoginCheck() {
		LoginDto loginDto = new LoginDto();
		
		loginDto.setId("cigr45");
		loginDto.setPwd("72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236");
		
		boolean result = userDao.loginCheck(loginDto);
		
		System.out.println("로그인 가능 ? : " + result);
	}
	
	@Test
	public void testUpdateloginDate() {
		LoginDto loginDto = new LoginDto();
		
		loginDto.setId("cigr45");
		loginDto.setPwd("72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236");
		
		System.out.println(loginDto);
		// userDao.updateloginDate(loginDto);
	}
	
	@Test
	public void testGetUser() {
		LoginDto loginDto = new LoginDto();
		
		loginDto.setId("cigr400");
		loginDto.setPwd("72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236");
		
		// UserVo userVo = userDao.getUser(loginDto);
	
		// System.out.println(userVo);
	}
	
	@Test 
	public void testAddMenu() {
		MenuVo menuVo = new MenuVo();
		
		menuVo.setMname("제목 - 300");
		menuVo.setMdesc("내용 - 300");
		menuVo.setMfilename("/2023/8/12/a575cd62-9532-4400-8e3b-d54526751ccd_brownie.png");
		
		
//		Map<String, Object> map = new HashMap<>();
//		map.put("mname", "레시피 제목");
//		map.put("mdesc", "맛있어요");
		
		recipeDao.addMenu(menuVo);
	}
	
	@Test 
	public void testAdd300Menu() throws InterruptedException {
		for(int i = 0; i < 300; i++) {
			MenuVo menuVo = new MenuVo();
			
			menuVo.setMname("제목 - " + i);
			menuVo.setMdesc("내용 - " + i);
			menuVo.setMfilename("/2023/8/12/a575cd62-9532-4400-8e3b-d54526751ccd_brownie.png");
			recipeDao.addMenu(menuVo);
			Thread.sleep(100);
		}
	}
	
	@Test 
	public void testGetMnoAtItem() {
		String mname = "레시피 제목";
		String mname2 = "ㅇㅇ";
		
		Optional<Integer> maybeMno = recipeDao.getMnoAtItem(mname);
		Integer mno = maybeMno.orElse(0);
		System.out.println(mno);
		
		Optional<Integer> maybeMno2 = recipeDao.getMnoAtItem(mname2);
		Integer mno2 = maybeMno2.orElse(0);
		System.out.println(mno2);	
 	}
	
	@Test
	public void testAddCategory() {
		
		MenuCategoryVo vo = new MenuCategoryVo();
		
		vo.setMno(2);
		vo.setCtg("temp");
		vo.setCtg_value("H");
		
		recipeDao.addCategory(vo);
	}	
	
	@Test
	public void testAddIngredients() {
		
		IngredientsVo vo = new IngredientsVo();
		
		vo.setMno(2);
		vo.setI_element("우유 1L");
		
		recipeDao.addIngredients(vo);
	}
	
	@Test 
	public void testAddRecipe() {
		RecipeVo vo = new RecipeVo();
		
		vo.setMno(2);
		vo.setOrdernum(1);
		vo.setContents("잘 저어줍니다.");
		
		recipeDao.addRecipe(vo);
	}
	
	@Test
	public void testAddAttach() {
		AttachVo vo = new AttachVo();
		
		vo.setMno(2);
		vo.setFilename("default.png");
		
		recipeDao.addAttach(vo);
	}
	
	@Test
	public void testGetMenuList() {
		System.out.println(recipeDao.getMenuList());
	}
	
	@Test // 수정이 필요함
	public void testGetMenuListPerPage() {
		Map<String, Integer> map = new HashMap<>();
		map.put("startRow", 10);
		map.put("endRow", 18);
		
		// System.out.println(recipeDao.getMenuListPerPage(map));
	}
	
	@Test
	public void testGetMenuCount() {
		System.out.println(recipeDao.getMenuCount());
	}
	
	@Test 
	public void testGetMenuCountAtSearch() {
		PagingDto pagingDto = new PagingDto();
		pagingDto.setSearchType("t");
		pagingDto.setKeyword("목 - 3");
		
		System.out.println(recipeDao.getMenuCountAtSearch(pagingDto));
	}
	
	@Test
	public void testCreateRandNum() {
	
	}
	
	
	
	
	
	
}
