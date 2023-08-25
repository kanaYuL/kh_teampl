package com.kh.teampl.recipe;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class RecipeDto {
	
	private String[] ctg_names = {"temp", "latte", "syrub", "alcohol", "fruit", "cream"};
	private	List<String> categories;
	private String recipeTitle; 
	private String recipeComment;
	private List<String> ingredients; 
	private List<String> recipe;
	private String mfilename;
	private List<String> filenames;
	
}
