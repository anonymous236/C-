# Java程序设计
---
* Java三种核心机制：Java虚拟机、代码安全性检查、垃圾收集机制
* Java程序的编译和运行：源程序(Source.java)经过编译(javac)生成字节码文件(Source.class)，它是平台无关的。字节码文件使用Java命令来运行，Java命令实际调用虚拟机(虚拟机在实际的机器之上，如win、Linux等，来运行代码)
* Java运行环境(JRE) <br>JRE = JVM + API(Lib)
* Java开发工具包JDK = JRE + Tools(包括运行、检查、打包等工具)
* Java自动垃圾回收：(虚拟机的)系统级线程跟踪存储空间的分配情况；在JVM空闲时，检查并释放那些可被释放的存储空间；程序员无需也无法精确控制和干预该回收过程。
# JSP
---
* tomcat服务器中的目录结构：

| 目录 | 说明 |
| ------ | ------ |
| /bin | 存放各种平台下用于启动和停止tomcat的命令文件 |
| /conf | 存放各种配置文件 |
| /lib | 存放tomcat服务器所需的各种JAR文件 |
| /logs | 存放日志文件 |
| /temp | tomcat运行时用于存放临时文件 |
| /webapps | 当发布Web应用时，默认会将Web应用的文件发布到此目录 |
| /work | 把有JSP生成的Servlet放于此目录下 |

* 手动编写Web程序步骤：在WebApps创建项目目录 -> 编写index.jsp -> 创建WEB-INF目录 -> 测试运行
* WEB-INF目录包含：web.xml、classes目录、lib目录
* WEB-INF目录中的结构:
  * WEB-INF目录时Java的WEB应用的安全目录。所谓安全目录就是客户端无法访问，只有服务器端可以访问的目录。
  * web.xml时项目的部署文件。<br>
    比如可以配置项目的欢迎页面:
    ```html
    <welcome-file-list>
      <welcome-file>/welcome.jsp</welcome-file>
    </welcome-file-list>
    ```
  * classes目录用来放置编译生成的字节码文件: *.class文件。
  * lib目录用来存放需要的jar包。

---
* JSP页面元素构成: 指令、表达式、小脚本、声明、注释、静态内容。
  * __1. JSP指令元素：__
    * page指令: 通常位于jsp页面的顶端，同一个页面可以有多个page指令<br>
      page指令语法: 
      ```
      <%@ page 属性1="属性值" 属性2="属性值1, 属性值2" ... 属性n="属性值n"%>
      ```
      | 属性 | 描述 | 默认值 |
      | ------ | ------ | ------ |
      | language | 指定jsp页面使用的脚本语言 | Java |
      | import | 通过该属性来引用脚本语言中使用的类文件 | 无 |
      | contentType | 用来指定jsp页面所采用的编码方式 | text/html, ISO-8859-1 |
    * include指令: 将一个外部文件嵌入到当前jsp文件中，同时解析这个页面中的jsp语句
    * taglib指令: 使用标签库定义新的自定义标签，在jsp页面中启用定制行为
  * __2. JSP页面注释:__ <br>
    html的注释: \<!-- html注释--> //客户端可见 <br>
    JSP注释: <%-- html注释 --%> //客户端不可见 <br>
    JSP脚本注释: //单行注释  /* 多行注释*/
  * __3. JSP脚本:__ <br>
    是指在JSP页面中执行的Java代码，语法格式: __<%  Java代码  %>__
  * __4. JSP页面中定义变量或方法:__ <br>
    语法: __<%! Java代码%>__ 这句话表示感叹号以后是声明语句
  * __5. JSP表达式:__ <br>
    是指在JSP页面中执行的表达式 <br>
    语法: __<% =表达式 %>  //注意： 表达式不以分号结束__
  ```jsp
  <body>
    <!-- html注释,客户端可见-->
    <%-- html注释,客户端不可见 --%>
    <%!
      String str = "Tom";
      int add(int x, int y) {
          return x+y;
      }
    %>
    <%
      // 这里是jsp脚本
      /* jsp内置对象: out*/
      out.println("jsp内置对象: out, 向浏览器输出\n");
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
      String date = sdf.format(new Date());
    %>
    你好, <%= str %><br>
    x+y = <%= add(1, 2) %>
    今天是: <%= date%>
  </body>
  ```

* JSP页生命周期<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以用户访问index.jsp为例：<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户发出请求index.jsp, 判断是否是第一次请求。如果是，JSP引擎把该jsp文件转换成一个servlet，生成字节码文件，并执行jspInit()。如果不是，则直接访问生成的字节码文件。再解析执行jspService()方法，用来处理用户的请求。<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jspService()方法被用来处理客户端的请求。对于每一个请求，JSP引擎会创建一个新的线程来处理该请求。如果有多个客户端同时请求该jsp文件，则JSP引擎会创建多个线程，每个客户端请求对应一个线程。以多线程方式执行可大大降低对系统的资源需求，提高系统的并发量及响应时间。由于该Servlet常驻内存，故响应速度非常快。

* JSP内置对象
  * JSP内置对象是Web容器创建的一组对象，不使用new关键字就可以使用
  * 9大内置对象：out, request, response, session, application, (不太常用的: Page, pageContent, exception, config)
  * out对象:
    * out对象是**JspWriter类**的实例，是向客户端输出内容常用的对象
    * 常用的方法有：
    
      | 方法 | 说明 |
      | ------ | ------ |
      | void println() | 向客户端打印字符串 |
      | void flush() | 将缓冲区内容输出到客户端 |
      | void clear() | 清除缓冲区内容，如果在flush之后调用会抛出异常 |
      | void clearBuffer() | 清除缓冲区内容，如果在flush之后调用不会抛出异常 |
      | int getBufferSize() | 返回缓冲区以字节数的大小，如果不设缓冲区则为0 |
      | int getRemaining() | 返回缓冲区还剩余多少可用 |
      | boolean isAutoFlush() | 返回缓冲区满时，是自动清空还是抛出异常 |
      | void close() | 关闭输出流 |
  * request对象:
    * 表单常用的提交方式:
      ```html
      <form name="regForm" action="动作" method="提交方式"> </form>
      ```
      * get: 多以明文的方式通过URL提交数据，数据在URL中可以看到。提交的数据最多不超过2KB.安全性较低但效率比post高。适合提交数据量不大，安全性不高的数据。比如：搜索、查询等功能。
      * post: 将用户提交的信息封装在HTML HTADER中。适合提交数据量大、安全性高的用户信息。如：注册、修改、上传等功能。
      ```html
      <h1>用户登录</h1>
      <hr>
      <form action="index.jsp" name="loginForm" method="post">
          <table>
              <tr>
                  <td>用户名：</td>
                  <td><input type="text" name="username" /></td>
              </tr>
              <tr>
                  <td>密码：</td>
                  <td><input type="password" name="password" /></td>
              </tr>
              <tr>
                  <td colspan="2"><input type="submit" value="登录" /></td>
              </tr>
          </table>
      </form>
      ```
    * request对象: **客户端的请求信息都被封装在request对象中**，它是HttpServletRequest类的实例。request对象具有请求域，完成客户端的请求之前，该对象一直有效。<br>
      常用的方法有:
      
      | 方法 | 说明 |
      | ------ | ------ |
      | String getParameter(String name) | 返回name指定参数的参数值 |
      | String[] getParameterValues(String name) | 返回包含参数name的所有值的数组 |
      | void setAttribute(String, Object) | 存储此请求中的属性 |
      | object getAttribute(String name) | 返回指定属性的属性值 |
      | String getContentType() | 得到请求体的MIME类型 |
      | String getProtocol() | 返回请求用的协议类型及版本号 |
      | String getServerName() | 返回接受请求的服务器主机名 |
      | int getServerPort() | 返回服务器接受此请求所用的端口号 |
      | String getCharacterEncoding() | 返回字符编码方式 |
      | void setCharacterEncoding(String s) | 设置请求的字符编码方式 |
      | int getContentLength() | 返回请求体的长度(以字节数) |
      | String getRemoteAddr() | 返回发送此请求的客户端IP地址 |
      | String getRealPath(String path) | 返回一虚拟路径的真实路径 |
      | String request.getContextPath() | 返回上下文路径 |
      
      ```html
      <h1>用户信息</h1>
      <hr>
      <form action="index.jsp" name="loginForm" method="post">
          <table>
              <tr>
                  <td>用户名：</td>
                  <td><input type="text" name="username" /></td>
              </tr>
              <tr>
                  <td>
                      <input type="checkbox" name="info" value="read">读书
                      <input type="checkbox" name="info" value="video">视频
                      <input type="checkbox" name="info" value="music">音乐
                  </td>
              </tr>
              <tr>
                  <td colspan="2"><input type="submit" value="登录" /></td>
              </tr>
          </table>
      </form>
      ```
      ```jsp
      <h1>request内置对象:</h1>
      <hr>
      <%
          // 解决中文乱码问题，但是无法解决URL中的中文乱码(需要配置tomcat的server.xml文档)
          request.setCharacterEncoding("utf-8");
      %>
      用户名: <%= request.getParameter("username")%><br>
      信息:
      <%
          String[] information = request.getParameterValues("info");
          for(int i=0; i<information.length; i++) {
              out.print(information[i] + "<br>");
          }
      %>
      ```
      ```html
      <%-- 使用URL传递参数 --%>
      <a href="index.jsp?username=李四">测试使用URL传递参数</a>
      <%-- 
        需要修改tomcat服务器配置文件: server.xml
        <Connector port="8080" protocol="HTTP/1.1"
            connectionTimeout="20000"
            redirectPort="8443"
		          URIEncoding="utf-8" />
      --%>
      ```
      ```html
      <%
        request.setAttribute("password", "123456");
      %>
      得到密码: <%= request.getAttribute("password")%><br>
      请求体的MIME类型: <%= request.getContentType()%><br>
      请求用的协议类型及版本号: <%= request.getProtocol()%><br>
      请求的服务器主机名: <%= request.getServerName()%><br>
      服务器接受此请求所用的端口号: <%= request.getServerPort()%><br>
      请求体的长度: <%= request.getContentLength()%><br>
      请求的客户端IP地址: <%= request.getRemoteAddr()%>
      ```

  * response对象:<br>
    response对象包含了响应客户请求的有关信息，是HttpServletResponse类的实例。<br>
    response对象具有**页面作用域**，即访问一个页面时，该页面内的response对象只能对这次访问有效，其它页面的response对象对当前页面无效。<br>
    常用的方法:
    
    | 方法 | 说明 |
    | ------ | ------ |
    | String getCharacterEncoding() | 返回响应用的时何种字符编码 |
    | void setContentType(String type) | 设置响应的MIME类型 |
    | PrintWriter getWriter() | 返回可以向客户端输出字符串的一个对象 |
    | sendRedirect(java.lang.String location) | 重新定向客户端的请求 |

    * PrintWriter对象的输出总是提前于内置out对象，要想先输出out对象再输出PrintWriter对象，需要清空缓冲区(清空缓冲区时会向页面输出)
      ```jsp
      <%
        response.setContentType("text/html;charset=utf-8");
        out.print("<h1>out内置对象</h1>");
        out.print("<hr>");
        out.flush();
        PrintWriter outer = response.getWriter(); //获得输出流对象
        outer.print("flush()后，PrintWriter输出流对象输出。<br>");
      %>
      ```
    * **重定向**:
      * **请求重定向：客户端行为，response.sendRedirect()，从本质上讲等同于两次请求，前一次请求对象不会保存，地址栏的URL地址会改变。**
      * **请求转发：服务器行为，request.getRequestDispatcher().forward(req, resp); 是一次请求，转发后请求对象会保存，地址栏的URL地址不会改变。**
      ```jsp
      <%
        //在middle.jsp页面中：
	    //请求重定向
	    response.sendRedirect("dologin.jsp");
	    //请求转发
	    //request.getRequestDispatcher("dologin.jsp").forward(request, response);
	    
	    /**
	      以上语句可以分析为：首先在login.jsp页面填入form表单信息，提交到middle.jsp中。
	      在middle.jsp有重定向和转发的语句，再跳转到dologin.jsp页面。
	      若采用请求重定向，前一次请求对象不会保存，地址栏的URL地址会改变，在login.jsp中接收到的为null。
	      若采用请求转发，转发后请求对象会保存，地址栏的URL地址不会改变，login.jsp成功显示提交的信息。
	    */
      %>
      ```

  * session对象:
    * 表示客户端与服务器的一次会话。Web中的session指的是用户在浏览某个网站时，从进入网站到浏览器关闭所经过的这段时间，也就是用户浏览这个网站所花费的时间。因此，session实际上时一个特定的时间概念
    * 在服务器的内存中保存着不同用户的session
    
      | session对象的特性 |
      | ------ |
      | session对象是一个JSP内置对象 |
      | session对象在第一个JSP页面被装载时自动创建，完成会话期管理 |
      | 从一个客户打开浏览器并连接到服务器开始，到用户关闭浏览器离开服务器结束，成为一个回话 |
      | 当一个用户访问一个服务器时，可能会在服务器的几个页面之间切换，服务器通过session对象来确定这个同一个客户 |
      | session对象时HttpSession类的实例 |

    * session对象常用的方法: 
    
      | 方法 | 说明 |
      | ------ | ------ |
      | long getCreationTime() | 返回session创建时间 |
      | public String getId() | 返回session创建时JSP引擎为它设的唯一的ID号 |
      | public Object setAttribute(String name, Object value) | 使用指定名称将对象绑定到此会话 |
      | public Object getAttribute(String name) | 返回与此会话中的指定名称绑定在一起的对象，如果没有对象绑定在该名称下，则返回null |
      | String[] getValueNames() | 返回一个包含此session中所有可用属性的数组 |
      | int getMaxInactiveInterval() | 返回两次请求间隔多长时间此session被取消(单位秒) |
      
      ```jsp
      <%-- session_page1.jsp --%>
      <body>
        <%
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
          Date date = new Date(session.getCreationTime());

          session.setAttribute("username", "admin");
        %>
        <br><hr>
        session创建时间: <%= sdf.format(date)%><br>
        <hr>
        session id: <%= session.getId()%><br>
      
        <%-- 值描述 _blank 在新窗口中打开被链接文档 --%>
        <a href="session_page2.jsp" target="_blank">跳转到session_page2.jsp</a>
      </body>
      
      <%-- session_page2.jsp --%>
      从session中获取属性值: <%= session.getAttribute("username")%>
      ```
    
    * session对象的生命周期: 
      * **创建**: 当客户端*第一次*访问某个jsp或者Servlet时，服务器会为当前会话创建一个SessionId。每次客户端向服务器发送请求时，都会将此SessionId携带过去，服务端会对此SessionId进行校验(判断是否属于同一次会话)。
      * **活动**: 
        * 某次会话当中通过超链接打开的新页面属于同一次会话
        * 只要当前会话页面没有全部关闭，重新打开新的浏览器窗口访问同一项目资源时属于同义词会话
        * 本次会话的所有有关页面都关闭后，重新访问某个jsp或Servlet将会创建新的会话(**注意**: 原有会话还存在，只是这个旧的SessionId仍存在于服务端，只不过再也没有客户端会携带它然后交予服务端校验)
      * **销毁**: <br>
        session销毁的方式有三种: <br>
        * 调用session.invalidate()方法
        * Session过期（超时）
        * 服务器重新启动
    * Session对象的超时时间:
      * Tomcat默认session超时时间为30分钟
      * 设置session超时有两种方式:
        * session.setMaxInactiveInterval(时间); //单位是秒
        * 在WEB-INF/web.xml中配置:
          ```xml
          <!-- 在WEB-INF/web.xml中配置，设置会话10分钟后过期 -->
          <session-config>
          <session-timeout>
                  10
          </session-timeout>
          </session-config>
          ```
  * application对象
    * application对象实现了用户间数据的共享，可存放全局变量
    * application开始于服务器的启动，终止于服务器的关闭
    * 在用户的前后连接或不同用户之间的连接中，可以对application对象的同一属性进行操作
    * 在任何地方对application对象属性的操作，都将影响到其他用户对此的访问
    * 服务器的启动和关闭决定了application对象的生命
    * application对象是ServletContext类的实例
    * application对象常用的方法:
    
      | 方法 | 说明 |
      | ------ | ------ |
      | public void setAttribute(String name, Object value) | 使用指定名称将对象绑定到此会话 |
      | public Object getAttribute(String name) | 返回与此会话中的指定名称绑定在一起的对象，如果没有对象绑定在该名称下，则返回null |
      | Enumeration getAttributeNames() | 返回所有可用属性名的枚举 |
      | String getServerInfo() | 返回JSP(SERVLET)引擎名及版本号 |
      
      ```jsp
      <%
        application.setAttribute("city", "北京");
        application.setAttribute("university", "BIT");
      %>
      city属性值：<%= application.getAttribute("city")%><hr>
      属性有：
      <%
        Enumeration enumeration = application.getAttributeNames();
        while (enumeration.hasMoreElements()) {
            out.print(enumeration.nextElement() + "&nbsp;&nbsp;");
        }
      %>
      ```




