<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project list</title>

<style><%@include file="../css/style.css"%></style>
    <%@include file="../css/boot.jsp" %>
</head>
<body>
<%@include file="../navigation.jsp" %>

<c:if test="${deleteProjectResults==true}">
    <h1>Deleted Project successfull</h1>
</c:if>


<c:if test="${addingToProjectID!=null}">
<form method="post" action="/participants">
    <h1>Adding to project ${addingToProjectID.get().projectName} User:</h1>
    <label>Project id:</label>
    <input type="text" name="projestID" value ="${addingToProjectID.get().id}" readonly>
    <select name="user">
        <option selected hidden >Choose here</option>
        <c:forEach var="user" items="${users}">
            <option value="${user.id}">
                    ${user.username}
            </option>

        </c:forEach>
    </select><br/>
    <input type="submit" value="Dodaj" name="">
</form>
</c:if>








<div class="container">

    <h3>Projects<a href="/project" class="btn btn-outline-dark btn-sm">
        <span class="glyphicon glyphicon-plus"></span></a></h3>


    <div class="row">
<c:forEach var="project" items="${projects}">
        <div class="col-sm-4">

            <div class="card text-dark bg-warning m-1">

                <div class="card-header bg-info text-left text-light">
                    <a href="/project/show?projectId=${project.id}" class="nav-link text-light font-weight-bold">
                            ${project.projectName}</a>
                </div>

                <div class="card-body ">

<%--                    <h5 class="card-title">Services Title 1</h5>--%>

                    <p class="card-text text-left">${project.description}  </p>

                </div>

                <div class="card-footer bg-info text-right text-danger">

                    <a href="/project/delete?projectId=${project.id}" class="btn btn-outline-light btn-sm">
                        <span class="glyphicon glyphicon-trash"></span></a>
                    <a href="/participant?projectId=${project.id}" class="btn btn-outline-light btn-sm">
                        <span class="glyphicon glyphicon-plus"></span></a>
                    <a href="/project/edit?projectId=${project.id}" class="btn btn-outline-light btn-sm">
                        <span class="glyphicon glyphicon-edit"></span></a>
                    <div class="btn btn-outline-light btn-sm">
                            ${project.showUsersInProject()}</div>

                </div>

            </div>

        </div>
</c:forEach>



    </div>

</div>
</body>
</html>
