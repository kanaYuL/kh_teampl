package com.kh.teampl.util;

import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.teampl.recipe.PagingDto;
import com.kh.teampl.recipe.RecipeDto;
import com.kh.teampl.recipe.vo.AttachVo;
import com.kh.teampl.recipe.vo.IndexCarouselDto;
import com.kh.teampl.recipe.vo.IngredientsVo;
import com.kh.teampl.recipe.vo.MenuCategoryVo;
import com.kh.teampl.recipe.vo.MenuVo;
import com.kh.teampl.recipe.vo.RecipeVo;

/* mno from Query ( getMnoAtItem ) */
public class RecipeUtil {
   
   // Menu
   public static MenuVo getMenuVo (RecipeDto recipeDto) {
      MenuVo vo = new MenuVo();
      
      vo.setMname(recipeDto.getRecipeTitle());
      vo.setMdesc(recipeDto.getRecipeComment());
      vo.setMfilename(recipeDto.getMfilename());
      
      return vo;
   }
   
   // Category
   public static List<MenuCategoryVo> getCategoryVoList(RecipeDto recipeDto, Integer mno) {
      
      List<MenuCategoryVo> voList = new ArrayList<>();
      
      for(int i = 0; i < recipeDto.getCtg_names().length; i++) {
         // make a MenuCategoryVo
         
         MenuCategoryVo vo = new MenuCategoryVo();
         vo.setMno(mno);
         vo.setCtg(recipeDto.getCtg_names()[i]);
         vo.setCtg_value(recipeDto.getCategories().get(i));
         
         // add vo to list
         voList.add(vo);
      }
         
      return voList;
   }
   
   // Ingredients
   public static List<IngredientsVo> getIngredientsVoList(RecipeDto recipeDto, Integer mno) {
      
      List<IngredientsVo> voList = new ArrayList<>();
      List<String> i_elements = recipeDto.getIngredients();
      for(int i = 0; i < i_elements.size(); i++) {
         // make a IngredientVo
         
         IngredientsVo vo = new IngredientsVo();
         vo.setMno(mno);
         vo.setI_element(i_elements.get(i));
         
         // add vo to list
         voList.add(vo);
      }
         
      return voList;
   }
   
   // Recipe
   public static List<RecipeVo> getRecipeVoList(RecipeDto recipeDto, Integer mno) {
      
      List<RecipeVo> voList = new ArrayList<>();
      List<String> recipes = recipeDto.getRecipe();
      int ordernum = 0;
      for(int i = 0; i < recipes.size(); i++) {
         // make a IngredientVo
         
         RecipeVo vo = new RecipeVo();
         vo.setMno(mno);
         vo.setOrdernum(++ordernum);
         vo.setContents(recipes.get(i));
         
         // add vo to list
         voList.add(vo);
      }
         
      return voList;
   }
   
   // Attach
   public static List<AttachVo> getAttachVoList(RecipeDto recipeDto, Integer mno) {
      
      List<AttachVo> voList = new ArrayList<>();
      List<String> filenames = recipeDto.getFilenames();
      
      for(String filename : filenames) {
         // make a AttachVo
         
         AttachVo vo = new AttachVo();
         vo.setMno(mno);
         vo.setFilename(filename);
         
         // add vo to list
         voList.add(vo);
      }
         
      return voList;   
   }
   
   public static void setCategories(PagingDto pagingDto) {
      
      // 1. init Categories
      pagingDto.setLatte("N");
      pagingDto.setCream("N");
      pagingDto.setAlcohol("N");
      pagingDto.setFruit("N");
      pagingDto.setSyrub("N");
      
      // 2 . set Categories
      String categories = pagingDto.getCategories();
      
      if(categories != null) {
         
         String[] categoryNames = {"latte", "syrub", "alcohol", "fruit", "cream"};
         
         String[] arrCategory = categories.split(" ");
         pagingDto.setTemp(arrCategory[0]);
         arrCategory = Arrays.copyOfRange(arrCategory, 1, arrCategory.length);
         
         List<String> listCategory = Arrays.asList(arrCategory);
         System.out.println("[RecipeUtil] listCategory : " + listCategory);
         
         for (String category : categoryNames) {
   
            try {
               Field field = pagingDto.getClass().getDeclaredField(category);
               field.setAccessible(true);
               
               if (listCategory.contains(category)) {
                  try {
                     field.set(pagingDto, "Y");
                  } catch (IllegalArgumentException e) {
                     // TODO Auto-generated catch block
                     e.printStackTrace();
                  } catch (IllegalAccessException e) {
                     // TODO Auto-generated catch block
                     e.printStackTrace();
                  }
               } else {
            	   try {
					field.set(pagingDto, "N");
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
               }
            } catch (NoSuchFieldException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            } catch (SecurityException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            }
            
         }
         
      } // categories nullcheck

   }
   
   public static List<IndexCarouselDto> getRandMfilenames(List<IndexCarouselDto> dtoList, int count) {
      
      // 5개 숫자 : mfilename size
      List<IndexCarouselDto> randList = new ArrayList<>();
      
      int size = dtoList.size();
      int[] arr = new int[size]; // 0 1 2 3 4 
      int num = 0; // ex) count가 3이 될 때까지
      
      while(num < count) {
         
         int randIndex = (int)(Math.random() * size);
         
         if (arr[randIndex] == 0) {
            randList.add(dtoList.get(randIndex));
            arr[randIndex] = 1;
            num++;
         } 
      }
      
      return randList;
   }
}