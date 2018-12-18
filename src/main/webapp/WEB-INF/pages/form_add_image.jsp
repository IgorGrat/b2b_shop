<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<html>
<head>
	<title>Image</title>
</head>

<body>
<div align="center"><strong>Форма ввода изображения</strong></div>
<form enctype="multipart/form-data" action="add_image" method="post" name="image" id="image">
<input type="text" name="name" id="name" size="10" maxlength="20">
<input type="file" name="photo" size="60">
<input type="submit" name="submit" width="20" height="10">
</form>

</body>
</html>
