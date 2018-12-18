<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=windows-1251" language="java" %>
<option disabled selected></option>
<c:forEach items="${scope}" var="row">
    <option value = ${row[0]}>${row[1]}</option>
</c:forEach>