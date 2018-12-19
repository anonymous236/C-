<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/12/2018
  Time: 下午3:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link type="text/css" href="css/login.css" rel="stylesheet" />
</head>
<body>
<div id="container">
    <div class="logo">
        <a href="#"><img src="assets/logo.png" alt="" /></a>
    </div>
    <div id="box">
        <form action="dologin.jsp?user=jeff" method="post">
            <p class="main">
                <label>用户名: </label>
                <input name="username" value="" />
                <label>密码: </label>
                <input type="password" name="password" value="">
            </p>
            <p class="space">
                <input type="submit" value="登录" class="login" style="cursor: pointer;"/>
            </p>
        </form>
    </div>
</div>
</body>
</html>