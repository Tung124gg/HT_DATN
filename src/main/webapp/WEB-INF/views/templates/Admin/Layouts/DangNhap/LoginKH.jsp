<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="frm" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full bg-white shadow-lg rounded-lg p-8">
        <h2 class="text-2xl font-bold text-gray-800 text-center mb-6">Login</h2>

        <%--@elvariable id="user" type=""--%>
        <frm:form modelAttribute="user"
                  action="${pageContext.request.contextPath}/UserLog/login"
                  method="POST" class="space-y-4">

            <!-- Login Type Selection -->
            <div>
                <label for="loginType" class="block text-gray-700 font-medium mb-2">Login as:</label>
                <select id="loginType" name="loginType" class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="admin">Admin</option>
                    <option value="customer">Customer</option>
                </select>
            </div>

            <!-- Email Input -->
            <div>
                <label class="block text-gray-700 font-medium mb-2" for="email">Email</label>
                <frm:input path="email" class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" type="text" name="email" placeholder="Email"/>
            </div>

            <!-- Password Input -->
            <div>
                <label class="block text-gray-700 font-medium mb-2" for="pass">Password</label>
                <frm:input path="matKhau" class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" type="password" name="pass" placeholder="Password"/>
            </div>

            <!-- Error Messages -->
            <div class="text-red-500 text-sm mt-2">
                <span>${erLogLogin}</span>
                <span>${messageTrangThai}</span>
                <span>${messageErol}</span>
                <span>${erUserNoNull}</span>
            </div>

            <!-- Login Button -->
            <div class="text-center">
                <button type="submit" class="w-full bg-blue-500 text-white font-semibold py-2 rounded-md hover:bg-blue-600 transition duration-300">
                    Đăng nhập
                </button>
            </div>

            <!-- Forgot Password Link -->
            <div class="text-center mt-4">
                <a class="text-blue-500 hover:underline" href="/Admin/viewQuenMatKhau/2">Quên mật khẩu ?</a>
            </div>

        </frm:form>
    </div>
</div>

</body>
</html>
