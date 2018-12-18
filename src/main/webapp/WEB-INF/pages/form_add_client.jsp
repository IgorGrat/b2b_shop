<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Input new Client</title>
</head>

<body>
<form action="add_client" method="post" name="form" id="form">
<div align="center"><font color="#008000">Форма ввода данных клиентов.</font></div>
<br>
input Login <input type="text" name="login" id="login" size="10" maxlength="20">

input Password <input type="password" name="password" id="password" size="10" maxlength="20">

input Inner <input type="text" name="inner" size="10" maxlength="20">

<input type="submit" name="submit" value="save_value" width="20" height="10">
</form>


</body>
</html>
