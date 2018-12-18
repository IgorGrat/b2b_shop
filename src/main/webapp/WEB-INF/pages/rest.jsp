<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Остатки товаров</title>
<link href="resources/css/table.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="resources/css/inner.css" type="text/css" />
</head>

<body>
	<script type="text/javascript">
		var index;
        var url;
        function show(state){
			document.getElementById('window').style.display = state;			
			document.getElementById('wrap').style.display = state; 			
            url = 'advance/' + index;
            var elem=document.getElementById('window');
            elem.innerHTML='';
            elem.innerHTML=url;
        }

	</script>

	<div onclick="show('none')" id="wrap"></div>
    <div id="window"></div>
	
	
	<font size="+2" color="#808080">Ожидаемые позиции в течении месяца</font>
	<br>
	<font size="+2" color="#800000">Ожидаемые позиции в течении недели</font>
	<br>
	<font size="+2" color="#FF0000">на складе, количество до 5 штук</font>
	<br>
	<font size="+2" color="#000000">на складе, много</font>
	 
	<table>
    	<tr>
        	<td>Индекс</td>
	        <td>Бренд</td>
    	    <td>Артикул</td>
        	<td>Найменование</td>
	        <td>Оф. название</td>
    	    <td>уп.</td>
       		<td>гарантия</td>
	        <td>заказ</td>
    	</tr>
	    <c:forEach items="${scope}" var="row">

    	    <tr>
            <td>${row[0]}</td>
            <td>${row[1]}</td>
            <td>${row[2]}</td>
            <td>${row[3]}</td>
            <td>
                <center><button onclick="show('block', ${row[0]})">Расширенное найменование</button></center>
		  	</td>
			<td>${row[6]}</td>
            <td>${row[7]}</td>
            <td>${row[8]}</td>

    </c:forEach>
</table>

</body>
</html>
