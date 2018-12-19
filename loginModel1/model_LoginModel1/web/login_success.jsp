<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/12/2018
  Time: 下午4:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link type="text/css" href="css/login.css" rel="stylesheet" />
    <script language='javascript' type='text/javascript'>
        var secs = 5; //倒计时的秒数
        var URL ;
        function Load(url) {
            URL = url;
            for(var i=secs; i>0; i--) {
                window.setTimeout('doUpdate(' + i + ')', (secs-i) * 1000);
            }
        }
        function doUpdate(num) {
            document.getElementById('ShowDiv').innerHTML = '将在'+num+'秒后自动跳转' ;
            if(num == 1) {

                window.location = URL;
            }
        }
    </script>

</head>
<body>
<div id="container">
    <div class="logo">
        <a href="#"><img src="assets/logo.png" alt="" /></a>
    </div>
    <div id="box">
        <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
        欢迎<font color="red">
            <%= userInfo.getUsername()%>
            <%= session.getAttribute("username")%>
        </font>
        登录成功！&nbsp;
        <div id="ShowDiv"></div>
        <script language="JavaScript">
            Load("javaBean_page.jsp");
        </script>
    </div>
</div>
</body>
</html>
