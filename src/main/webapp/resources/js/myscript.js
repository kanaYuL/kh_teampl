/**
 *  mysrcipt.js
 */

function toDataString(millisecond) {
	if (!millisecond) {
		return "";
	}
	
	var d = new Date(millisecond);
	
	// 2023-07-18 14:50:50
	
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var date = d.getDate();
	var hour = d.getHours();
	var minute = d.getMinutes();
	var second = d.getSeconds();
	
	var dateString = year + "-" + make2digits(month) + "-" + make2digits(date) + " ";
	dateString += make2digits(hour) + ":" + make2digits(minute) + ":" + make2digits(second);  
	console.log(dateString);
	return dateString;
} 

function make2digits(num) {
	if (num < 10) {
		num = "0" + num;
	}
	return num;
}


function isImage(fileName) {
	var formatName = getFormatName(fileName);
	var uName = formatName.toUpperCase();
	if (uName == "JPG" || uName == "GIF" || uName == "PNG") {
		return true;
	} 
	return false;
}


function getFormatName(fileName) {
	var dotIndex = fileName.lastIndexOf(".");
	var formatName = fileName.substring(dotIndex + 1); // 확장자 
	return formatName;
}


function getThumbnailName(fullName) {
	var slashIndex = fullName.lastIndexOf("/");
	var front = fullName.substring(0, slashIndex + 1);
	var rear = fullName.substring(slashIndex + 1);
	var thumbnail = front + "s_" + rear;
	return thumbnail;
}


