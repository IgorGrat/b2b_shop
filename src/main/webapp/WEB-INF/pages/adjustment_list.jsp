<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<c:set var="count" value='1'/>
<c:forEach items="${scope}" var="row">
    <tr id=${row[0]}>
    <td> ${count}</td>
    <td>${row[0]}</td>
    <td>${row[1]}</td>
    <td>${row[2]}</td>
    <td>${row[3]}</td>
    <td>${row[4]}</td>
    <td>${row[5]}</td>
    <td>${row[6]}</td>
    <c:set var="count" value="${count+1}"/>
</c:forEach>

