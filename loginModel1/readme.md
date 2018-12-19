## 这是这个小项目的说明

* 本项目是实现了用户登录、跳转、显示用户名的功能
* 使用JavaBean来使代码分离:
  <br>在src目录下创建包:
  * **com.po** 表示跟用户有关的实体类的包: com.po.Users.java
  * **com.dao** 表示业务逻辑类有关的包: com.dao.UserDAO.java
* 使用JavaBean时需要注意:
  * scope="作用域"必须都为 application
  * id="标识符" 必须都相同
  ```jsp
  <!-- dologin.jsp -->
  // 使用JavaBean
  <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
  // 获取指定JavaBean对象的属性值
  <!-- 根据表单自动匹配所有属性 -->
  <jsp:setProperty name="userInfo" property="*" />
  ```
  ```jsp
  <!-- login_success.jsp -->
  <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
  用户名：<%= userInfo.getUsername()%>
  ```
  ```jsp
  <!-- javaBean_page.jsp -->
  <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
  用户名：<%= userInfo.getUsername()%>
  ```
  
  * 对于id="标识符" ，此标识符类似一个对象，可调用类中的方法
  ```java
  //com.dao.UsersDAO.java
  public class UsersDAO {
    public boolean userLogin(Users user) {
        // ...
    }
  }
  ```
  ```jsp
  <!-- dologin.jsp -->
  <jsp:useBean id="userInfo" class="com.po.Users" scope="application" />
  <jsp:useBean id="login" class="com.dao.UsersDAO" scope="page" />
  <%
    if(login.userLogin(userInfo)) {
        session.setAttribute("username", userInfo.getUsername());
        request.getRequestDispatcher("login_success.jsp").forward(request, response);
    }
  %>
  ```
