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
    <td>${row[5]}</td>
    <td>${row[6]}</td>
    <td>${row[7]}</td>
    <td>
        <c:choose>
            <c:when test="${row[8] eq '0'}">
                обработка
            </c:when>
            <c:when test="${row[8] eq '1'}">
                резерв
            </c:when>
            <c:when test="${row[8] eq '2'}">
                сборка
            </c:when>
            <c:when test="${row[8] eq '3'}">
                готов
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
    </td>
    <td><c:if test="${row[8] lt '3'}"> <input type="image"  src="../resources/image/up.png"></c:if></td>
    </tr>
    <c:set var="count" value="${count+1}"/>
</c:forEach>
