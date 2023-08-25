package com.kh.teampl.util;

import java.io.File;

import java.io.IOException;
import java.util.Calendar;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;

@Component
public class FileUploadUtil {
	
	@Resource(name = "recipeUploadPath")
	private String recipeUploadPath; // C:/teampl/recipe
		
	@Resource(name = "fleamarketUploadPath")
	private String fleamarketUploadPath; // C:/teampl/fleamarket
	
	private static String uploadPath = "";
	private static String rUploadPath;
	private static String fUploadPath;
	
	@PostConstruct
	private void initUploadPath() {
		rUploadPath = recipeUploadPath;
		fUploadPath = fleamarketUploadPath;
	}
	
	public static void setUploadPath(String type) {
		
		if("market".equals(type)) {
			uploadPath = fUploadPath;
		} else if ("recipe".equals(type)){
			uploadPath = rUploadPath;
		} 
	}
	
	public static String getUploadPath() {
		return uploadPath;
	}
	
	// C:/zzz/upload/<uuid>_smile.png
	public static String upload (
			byte[] bytes,
			String uploadPath,
			String originalFilename) {
		
		UUID uuid = UUID.randomUUID();
		String dirPath = makeDir(uploadPath);
		String filename = uuid + "_" + originalFilename;
		String saveFilename = uploadPath + "/" + dirPath + "/" + filename;
		File target = new File(saveFilename);
		
		try {
			FileCopyUtils.copy(bytes, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 이미지파일이라면 썸네일 이미지 생성(ImageScalr 라이브러리)
		if(isImage(filename)) {
			makeThumbnail(uploadPath, dirPath, filename);
		}
		 
		String filePath = saveFilename.substring(uploadPath.length());
		return filePath;
		
	}
	
	public static boolean isImage(String filename) {
		String formatName = getFormatName(filename);
		String uName = formatName.toUpperCase();
		if (uName.equals("JPG") ||
				uName.equals("GIF") ||
				uName.equals("PNG")) { 
			return true;
		} 
		return false;
	}
	
	private static String getFormatName(String filename) {
		int dotIndex = filename.lastIndexOf(".");
		String formatName = filename.substring(dotIndex + 1); // 확장자 
		return formatName;
	}
	
	private static void makeThumbnail(
		String uploadPath, String dirPath, String filename) {
		String sourcePath = uploadPath + "/" + dirPath + "/" + filename;
		String thumbnailPath = uploadPath + "/" + dirPath + "/s_" + filename;
		
		try {
			// 원본 이미지를 메모리에 로딩
			BufferedImage sourceImage = ImageIO.read(new File(sourcePath));
			
			// 저장할 쎔네일 - 높이 50픽셀로 너비를 자동 맞춤
			BufferedImage destImage = Scalr.resize(
					sourceImage, Scalr.Method.AUTOMATIC, 
					Scalr.Mode.FIT_TO_HEIGHT, 50);
			
			File f = new File(thumbnailPath);
			String formatName = getFormatName(filename);
			ImageIO.write(destImage, formatName.toUpperCase(), f);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static String makeDir(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DAY_OF_MONTH);
		String dirPath = year + "/" + month + "/" + date;
		// -> 2023/7/21
		 
		File f = new File(uploadPath + "/" + dirPath);
		if (!f.exists()) {
			f.mkdirs();
		}
		
		return dirPath;
		
	}
	
	public static void deleteFile(String uploadPath, String filename) {
		
		System.out.println("target Filename :" + filename);
		
		boolean isImage = FileUploadUtil.isImage(filename);
		System.out.println(isImage);
		// /2023/7/24/86bf8755-9410-4304-8e03-3fb415916e52_mov01.jpg
		
		// 이미지 파일이라면 Thumbnail 이미지 삭제 
		if (isImage) {
			int slashIndex = filename.lastIndexOf("/");
			String front = filename.substring(0, slashIndex + 1);
			String rear = filename.substring(slashIndex + 1);
			String thumbnail = front + "s_" + rear;
			
			File f = new File(uploadPath + thumbnail);
			
			if(f.exists()) {
				f.delete();
			}
		}
		
		// 원본 파일 삭제
		File f = new File(uploadPath + filename);
		
		if(f.exists()) {
			f.delete();
		}
		
	} // deleteFile
}
