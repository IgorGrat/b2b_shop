<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<!DOCTYPE html>

<html>
<head>
	<title>Кабинет</title>
	<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="wrapper">
	<h1>Вход в личный кабинет</h1>
	<hr>
	<ul class="dropdown">
		<li class="dropdown-top">
			<a class="dropdown-top" href="/"> Товары </a>
			<ul class="dropdown-inside">
				<li><a href="/analis/rest"> Остатки </a></li>
                <li><a href="/analis/order"> Заказы </a></li>
            </ul>
        </li>
		<li class="dropdown-top">
			<a class="dropdown-top" href="/">Текущие заказы</a>
			<ul class="dropdown-inside">
				<li><a href="/analis/monitorWindow">Состояния готовности</a></li>
			</ul>
		</li>
		
		<li class="dropdown-top">
			<a class="dropdown-top" href="/">Взаиморасчёты</a>
			<ul class="dropdown-inside">
				<li><a href="/debt">Долги</a></li>
				<li><a href="/cash">Оплата</a></li>
			</ul>
		</li>
	</ul>
	<div class="clear"></div>
	<hr>
</div>

</body>
</html>