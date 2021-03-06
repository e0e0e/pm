<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="now" class="java.util.Date" />
<sec:authentication var="user" property="principal" />
<div>

	<nav class="navbar navbar-expand-lg navbar-dark bg-info">
		<div class="container">
			<%--            <a class="navbar-brand" href="#">--%>
			<%--            <i class="fa d-inline fa-lg fa-circle-o"></i>--%>
			<b class="navbar-brand">PMC</b>

			<button class="navbar-toggler navbar-toggler-right border-0"
				type="button" data-toggle="collapse" data-target="#navbar11"
				aria-expanded="true">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse show" id="navbar11" style="">
				<ul class="navbar-nav mr-auto bg-info">
					<%--                    <li class="nav-item"><a class="nav-link text-light font-weight-bold" href="/users">Add User</a></li>--%>
					<%--                    <li class="nav-item"> <a class="nav-link text-light font-weight-bold" href="/project">Add Project</a> </li>--%>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold"
						href="/users/projectList?userId=${user.id}">My Projects</a></li>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold" href="/users/list">Users</a></li>
					<li class="nav-item"><a
						class="nav-link text-primary font-weight-bold"
						href="/users/allProjectList">All Projects</a></li>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold" href="/sprint">Sprint</a></li>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold" href="/sprintList">Sprint
							List</a></li>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold"
						href="/taskWall?previous=unfinished">Wall</a></li>
					<li class="nav-item"><a
						class="nav-link text-light font-weight-bold"
						href="/image/get">Images</a></li>

					<%--                 <li class="nav-item"><a class="nav-link text-light font-weight-bold" href="/avatars">avatars</a></li>--%>
					<%--                    <li class="nav-item"> <a class="nav-link text-light font-weight-bold" href="/tasks">Add Task</a> </li>--%>
					<%--                    <li class="nav-item"> <a class="nav-link text-light font-weight-bold" href="/taskList">Task List</a> </li>--%>
				</ul>
			</div>
		</div>
		<div style="display: inline-block" class="text-white">

			logged as: <a href="/userProfile?username=${user.username}"
				class="btn btn-outline-light"> ${user.username}</a> <img
				class="img-circle bg-dark p-1 m-1"
				src="${resourcePath}${user.avatar}" height="40" width="40" /> <a
				href="/logout"><span class="glyphicon glyphicon-log-out"
				style="color: white;"></span></a> <br />
		</div>
	</nav>
	<div></div>
</div>