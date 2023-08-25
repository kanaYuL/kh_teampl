package com.kh.teampl;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.teampl.recipe.RecipeDto;
import com.kh.teampl.recipe.RecipeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ServiceTest {
	@Autowired
	RecipeService recipeService;
	
	@Test
	public void testAddMenu(RecipeDto reciepDto) {
		
		
	}
	
	
}
