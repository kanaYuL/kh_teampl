/**
 * utilscript.js
 */
 
 function makeArrayFromNames(namevalue) {
 	//값들의 갯수 -> 배열 길이를 지정
 	var str = "input[name=";
 	str += namevalue;
 	str += "]";
 	
  	var grpl = $(str).length;
  			
  	// 배열 생성
  	var grparr = new Array(grpl);
  			
  	// 배열에 값 주입
  	for(var i=0; i<grpl; i++){                          
  		grparr[i] = $("input[name=namevalue]").eq(i).val();
  	}
  	
  	return grparr; 
 }
 
 function toDateString(millisecond) {
 
 	if (!millisecond) {
 		return "";
 	}
 	
 	var d = new Date(millisecond);
 	// 2023-07-18 14:50:50
 	
 	var year = d.getFullYear();
 	var month =  d.getMonth() + 1;
 	var date = d.getDate();
 	
 	var hours = d.getHours();
 	var minutes = d.getMinutes();
 	var seconds = d.getSeconds();
 	
 	var dateString = year + "-" + make2digits(month) + "-" + make2digits(date)
 		             + " " 
 		             + make2digits(hours) + ":" + make2digits(minutes) + ":" + make2digits(seconds);
 		             
 	console.log(dateString);
 	
 	return dateString;
 }
 
 
 function getFormatName(filename) {
 	var filenames = filename.split('.');
 	var formatName = filenames[filenames.length - 1];
	
	console.log(formatName);
 	
 	return formatName;
 }
 
 
 function isImage(filename) {
 	var formatName = getFormatName(filename);
 	var uName = formatName.toUpperCase();
 	
 	if(uName == "JPG" || uName == "GIF" || uName == "PNG" ) {
 		return true;
 	}
 	
 	return false;
 }
 
 function make2digits(num) {
 	if (num < 10) {
 		num = "0" + num;	
 	}
 	
 	return num;	
 }
 
function getThumbnailName(fullName) {
	var slashIndex = fullName.lastIndexOf("/");
	var front = fullName.substring(0, slashIndex + 1);
	var rear = fullName.substring(slashIndex + 1);
	var thumbnail = front + "s_" + rear;
	return thumbnail;
}
 
 function showImage(fullname) {
 	var div = $("#uploadedItem").clone();
	div.removeAttr("id");
	div.addClass("uploadedItem");
	var filename = fullname.substring(fullname.indexOf("_") + 1);
	
    div.find("span").text(filename);
	
	if (isImage(filename)) {
		var slashIndex = fullname.lastIndexOf("/");
		var front = fullname.substring(0, slashIndex + 1);
		var rear = fullname.substring(slashIndex + 1);
		var thumbnail = front + "s_" + rear;
		console.log(thumbnail);
		div.find("img")
			.attr("src", "/upload/displayImage?filePath=" + thumbnail);
	}

	$("#uploadedDiv").append(div);
	div.fadeIn(1000);
 }