<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Todo App</title>
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
    crossorigin="anonymous">
</head>
<body>
    <jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container col-md-5 col-md-offset-3 mt-4" style="overflow: auto">
        <h2>Login</h2>
        <!-- FIX: Display error message when login fails -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        <form action="<%=request.getContextPath()%>/login" method="post">
            <div class="form-group">
                <label for="username">User Name:</label>
                <input type="text" class="form-control" id="username"
                    placeholder="User Name" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password"
                    placeholder="Password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="<%=request.getContextPath()%>/register" class="btn btn-link">Register</a>
        </form>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
