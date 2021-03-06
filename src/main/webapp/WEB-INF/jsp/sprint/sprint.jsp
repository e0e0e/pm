
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<c:set var="now" value="<%= new java.util.Date()%>" />



<div class="container bg-info" style="border-style: dotted;">

    <c:if test="${errorMessage!=null}">

        <div style="background-color: red;">${errorMessage}</div>

    </c:if>
    <form method="post" action="/sprint" >


    <label>From:</label>
        <input type="date" class="p-2" name="from" value="<fmt:formatDate type="date" value="${now}" pattern="yyyy-MM-dd"/>">
    <label>To:</label>
    <input type="date" class="p-2" name="to" value="<fmt:formatDate type="date" value="${now}" pattern="yyyy-MM-dd"/>"><br/>
    <label>Story points:</label>
   <input type="number" name="storyPoints" class="text-dark p-2" min="1" max="500" VALUE="10"><br/>
    <input type="submit" value="Dodaj">


</form>
</div>
