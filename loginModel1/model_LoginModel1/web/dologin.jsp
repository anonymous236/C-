<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/12/2018
  Time: 下午3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

// 使用JavaBean
<jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
<jsp:useBean id="login" class="com.dao.UsersDAO" scope="page" />
// 获取指定JavaBean对象的属性值
<!-- 根据表单自动匹配所有属性 -->
<jsp:setProperty name="userInfo" property="*" />

// 判断登录
<%
    if(login.userLogin(userInfo)) {
        session.setAttribute("username", userInfo.getUsername());
        request.getRequestDispatcher("login_success.jsp").forward(request, response);
    }
    else {
        response.sendRedirect("login_failure.jsp");
    }
%>
