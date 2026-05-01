<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Todo Management Application</title>
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
    crossorigin="anonymous">
</head><!-- FIX: Removed duplicate </head> tag -->
<body>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
            <div>
                <a href="<%=request.getContextPath()%>/list" class="navbar-brand">Todo App</a>
            </div>
            <ul class="navbar-nav">
                <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Todos</a></li>
            </ul>
            <ul class="navbar-nav navbar-collapse justify-content-end">
                <li><span class="nav-link text-white">Hello, ${sessionScope.user}</span></li>
                <li><a href="<%=request.getContextPath()%>/logout" class="nav-link">Logout</a></li>
            </ul>
        </nav>
    </header>
    <div class="container col-md-5 mt-4">
        <div class="card">
            <div class="card-body">
                <c:if test="${todo != null}">
                    <form action="<%=request.getContextPath()%>/update" method="post">
                </c:if>
                <c:if test="${todo == null}">
                    <form action="<%=request.getContextPath()%>/insert" method="post">
                </c:if>
                <h2>
                    <c:if test="${todo != null}">Edit Todo</c:if>
                    <c:if test="${todo == null}">Add New Todo</c:if>
                </h2>

                <!-- FIX: Hidden id field for update -->
                <c:if test="${todo != null}">
                    <input type="hidden" name="id" value="<c:out value='${todo.id}' />" />
                </c:if>

                <fieldset class="form-group">
                    <label>Todo Title</label>
                    <input type="text" value="<c:out value='${todo.title}' />"
                        class="form-control" name="title" required minlength="2">
                </fieldset>
                <fieldset class="form-group">
                    <label>Todo Description</label><!-- FIX: corrected typo "Decription" -->
                    <input type="text" value="<c:out value='${todo.description}' />"
                        class="form-control" name="description">
                </fieldset>
                <fieldset class="form-group">
                    <label>Todo Status</label>
                    <select class="form-control" name="isDone">
                        <!-- FIX: Pre-select the correct option based on current status -->
                        <option value="false" ${todo.status == false ? 'selected' : ''}>In Progress</option>
                        <option value="true" ${todo.status == true ? 'selected' : ''}>Complete</option>
                    </select>
                </fieldset>
                <fieldset class="form-group">
                    <label>Target Date</label>
                    <input type="date" value="<c:out value='${todo.targetDate}' />"
                        class="form-control" name="targetDate" required>
                </fieldset>
                <button type="submit" class="btn btn-success">Save</button>
                <a href="<%=request.getContextPath()%>/list" class="btn btn-secondary ml-2">Cancel</a>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
