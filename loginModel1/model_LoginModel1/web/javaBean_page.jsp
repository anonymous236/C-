<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/12/2018
  Time: 下午4:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JavaBean</title>
</head>
<body>
    <br><hr>
    使用useBean创建JavaBean的实例
    <br><hr>
    <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
    用户名：<%= userInfo.getUsername()%>
    密码：<%= userInfo.getPassword()%>
</body>
</html>
