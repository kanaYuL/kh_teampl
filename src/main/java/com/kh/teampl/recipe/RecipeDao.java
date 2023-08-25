package com.kh.teampl.recipe;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.recipe.vo.AttachVo;
import com.kh.teampl.recipe.vo.IndexCarouselDto;
import com.kh.teampl.recipe.vo.IngredientsVo;
import com.kh.teampl.recipe.vo.MenuCategoryVo;
import com.kh.teampl.recipe.vo.MenuVo;
import com.kh.teampl.recipe.vo.RecipeVo;

@Repository
public class RecipeDao {
	
	@Autowired
	SqlSession sqlsession;
	
	private static final String NAMESPACE = "com.kh.teampl.recipeMapper.";
	
	public void addMenu(MenuVo vo) {
		sqlsession.insert(NAMESPACE + "addMenu", vo);
	}
	
	public Optional<Integer> getMnoAtItem(String mname) {
		
		Integer mno = sqlsession.selectOne(NAMESPACE + "getMnoAtItem", mname);
		Optional<Integer> maybeMno = Optional.ofNullable(mno);
		
		return maybeMno;
	}
	
	public void addCategory(MenuCategoryVo vo) {
		sqlsession.insert(NAMESPACE + "addCategory", vo);
	}
	
	public void addIngredients(IngredientsVo vo) {
		sqlsession.insert(NAMESPACE + "addIngredients", vo);
	}
	
	public void addRecipe(RecipeVo vo) {
		sqlsession.insert(NAMESPACE + "addRecipe", vo);
	}
	
	public void addAttach(AttachVo vo) {
		sqlsession.insert(NAMESPACE + "addAttach", vo);
	}
	
	public void deleteAttach(String filename) {
		sqlsession.delete(NAMESPACE + "deleteAttach", filename);
	}
	
	public List<MenuVo> getMenuList() {
		return sqlsession.selectList(NAMESPACE + "getMenuList");
	}
	
	public List<MenuVo> getMenuListPerPage(PagingDto pagingDto) {	
		return sqlsession.selectList(NAMESPACE + "getMenuListPerPage", pagingDto);
	}
	
	public int getMenuCount() {
		return sqlsession.selectOne(NAMESPACE + "getMenuCount");
	}
	
	public int getMenuCountAtSearch(PagingDto pagingDto) {
		return sqlsession.selectOne(NAMESPACE + "getMenuCountAtSearch", pagingDto);
	}
	
	public MenuVo getMenu(int mno) {
		return sqlsession.selectOne(NAMESPACE + "getMenu", mno);
	}
	
	public List<String> getIngredients(int mno) {
		return sqlsession.selectList(NAMESPACE + "getIngredients", mno);
	}
	
	public List<String> getRecipe(int mno) {
		return sqlsession.selectList(NAMESPACE + "getRecipe", mno);
	}
	
	public List<String> getAttachList(int mno) {
		return sqlsession.selectList(NAMESPACE + "getAttachList", mno);
	}
	
	public List<IndexCarouselDto> getIndexCarouselDtoList() {
		return sqlsession.selectList(NAMESPACE + "getIndexCarouselDtoList");
	}
	
	public void recipeDelete(int mno) {
		System.out.println("recipeDelete, mno:" + mno);
		sqlsession.delete(NAMESPACE + "recipeDelete", mno);
	}
}
