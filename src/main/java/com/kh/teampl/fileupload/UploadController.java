package com.kh.teampl.fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.teampl.market.MarketboardService;
import com.kh.teampl.recipe.RecipeService;
import com.kh.teampl.util.FileUploadUtil;

@Controller
@RequestMapping("/upload")
public class UploadController {
	
	@Autowired
	RecipeService recipeService;
	
	@Autowired
	MarketboardService marketboardSerivce;
	
	private static String uploadPath;
	
	@ResponseBody
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST,
			produces = "text/plain;charset=utf-8")
	
	public String uploadFile(MultipartFile file, String type) {
		FileUploadUtil.setUploadPath(type);
		uploadPath = FileUploadUtil.getUploadPath();
		
		System.out.println("[UploadController uploadFile] type: " + type);
		System.out.println("[UploadController uploadFile] uploadPath: " + uploadPath);
		
		System.out.println("originalFileName:" + file.getOriginalFilename());
		try {
			byte[] bytes = file.getBytes(); // 바이너리 데이터
			String saveFilename = FileUploadUtil.upload(
					bytes, uploadPath, file.getOriginalFilename());
			
			return saveFilename;
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	// /upload/displayImage
	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
	@ResponseBody
	public byte[] displayImage(String filePath, String type) {
		System.out.println("[UploadController displayImage] type : " + type);
		
		FileUploadUtil.setUploadPath(type);
		uploadPath = FileUploadUtil.getUploadPath();
		System.out.println("[UploadController displayImage] uploadPath : " + uploadPath);
		
		System.out.println("filePath:" + filePath);
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(uploadPath + filePath);
			// org.apache.commons.io.IOUtils
			byte[] data = IOUtils.toByteArray(fis); // 파일에 대해 스트림 개설
			return data;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	} 
	
	@RequestMapping(value = "/deleteFile", method = RequestMethod.DELETE)
	@ResponseBody
	public String deleteFile(@RequestBody String filename, String type) {
		FileUploadUtil.setUploadPath(type);
		uploadPath = FileUploadUtil.getUploadPath();
		
		System.out.println("target filename : " + filename);
		
		FileUploadUtil.deleteFile(uploadPath, filename);

		return "SUCCESS";
	}
	
	// tbl_attach의 데이터 삭제 
	@RequestMapping(value = "/deleteAttach", method = RequestMethod.DELETE)
	@ResponseBody
	public String deleteAttach(@RequestBody Map<String, String> map) {
		
		String filename = map.get("filename");
		String type = map.get("type");
		
		System.out.println("[UploadController deleteAttach] type: " + type);
		System.out.println("[UploadController deleteAttach] uploadPath: " + uploadPath);
		
		FileUploadUtil.setUploadPath(type);
		uploadPath = FileUploadUtil.getUploadPath();
		
		System.out.println("[deleteAttach] filename: " + filename);
		FileUploadUtil.deleteFile(uploadPath, filename);
		marketboardSerivce.deleteAttach(filename);
		
		return "SUCCESS"; 
	}
}
