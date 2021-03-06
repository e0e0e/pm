<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="loggedUser" property="principal"/>
<div class="card text-dark bg-warning m-1">

    <div class="card-header bg-info text-left text-light"><h4>User name: ${user.username}</h4>
<div>
    <img class="img-circle bg-dark p-1 m-1" src="${resourcePath}${user.avatar}" height="100" width="100"/>
</div>
        <c:if test="${loggedUser.username==user.username}">
        <div>
            <a class="nav-link text-light font-weight-bold" href="/avatars?userId=${user.id}">Edit Avatar</a>
        </div>
        </c:if>
    </div>

    <div class="card-body ">

        <%--                    <h5 class="card-title">Services Title 1</h5>--%>

        <p class="card-text text-left">email: ${user.email}  </p>
        <br/>
        <p class="card-text text-left">In projects: ${user.toString()}  </p>

    </div>

    <%--    <div class="card-footer bg-info text-right text-danger">--%>

    <%--        <a href="/project/user?projectId=${user.id}" class="btn btn-outline-light btn-sm">--%>
    <%--            <span class="glyphicon glyphicon-trash"></span></a>--%>

    <%--        <a href="/project/edit?projectId=${user.id}" class="btn btn-outline-light btn-sm">--%>
    <%--            <span class="glyphicon glyphicon-edit"></span></a>--%>

    <%--    </div>--%>

</div>