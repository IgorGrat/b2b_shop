<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<!DOCTYPE html>

<html>
<head>
	<title>�������</title>
	<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="wrapper">
	<h1>���� � ������ �������</h1>
	<hr>
	<ul class="dropdown">
		<li class="dropdown-top">
			<a class="dropdown-top" href="/"> ������ </a>
			<ul class="dropdown-inside">
				<li><a href="/analis/rest"> ������� </a></li>
                <li><a href="/analis/order"> ������ </a></li>
            </ul>
        </li>
		<li class="dropdown-top">
			<a class="dropdown-top" href="/">������� ������</a>
			<ul class="dropdown-inside">
				<li><a href="/analis/monitorWindow">��������� ����������</a></li>
			</ul>
		</li>
		
		<li class="dropdown-top">
			<a class="dropdown-top" href="/">�������������</a>
			<ul class="dropdown-inside">
				<li><a href="/debt">�����</a></li>
				<li><a href="/cash">������</a></li>
			</ul>
		</li>
	</ul>
	<div class="clear"></div>
	<hr>
</div>

</body>
</html>