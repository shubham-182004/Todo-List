<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Todo App</title>
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
    crossorigin="anonymous">
</head><!-- FIX: Removed duplicate </head> tag -->
<body>
    <jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container mt-4">
        <h2>User Register Form</h2>
        <div class="col-md-6 col-md-offset-3">
            <% if (request.getAttribute("NOTIFICATION") != null) { %>
            <div class="alert alert-success" role="alert">
                ${NOTIFICATION}
            </div>
            <% } %>
            <form action="<%=request.getContextPath()%>/register" method="post">
                <div class="form-group">
                    <label>First Name:</label>
                    <input type="text" class="form-control" placeholder="First Name"
                        name="firstName" required>
                </div>
                <div class="form-group">
                    <label>Last Name:</label>
                    <input type="text" class="form-control" placeholder="Last Name"
                        name="lastName" required>
                </div>
                <div class="form-group">
                    <label>User Name:</label>
                    <input type="text" class="form-control" placeholder="User Name"
                        name="username" required>
                </div>
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" class="form-control" placeholder="Password"
                        name="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Register</button>
                <a href="<%=request.getContextPath()%>/login/login.jsp" class="btn btn-link">Back to Login</a>
            </form>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
