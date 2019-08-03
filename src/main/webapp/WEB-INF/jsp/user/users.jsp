<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>Create User</h1>

<c:if test="${errorMessage!=null}">

    <div style="background-color: red;">${errorMessage}</div>

</c:if>

<form method="post" action="/users">

    <label>Login:</label>
    <input type="text" name="login"><br/>
    <label>Email:</label>
    <input type="email" name="email"><br/>
    <label>Password:</label>
    <input type="password" name="password"><br/>
    <label>User Name:</label>
    <input type="text" name="username"><br/>
    <input type="submit" value="Dodaj">


</form>