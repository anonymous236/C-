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
      | void setCharacterEncoding() | 设置请求的字符编码方式 |
      | int getContentLength() | 返回请求体的长度(以字节数) |
      | String getRemoteAddr() | 返回发送此请求的客户端IP地址 |
      | String getRealPath(String path) | 返回一虚拟路径的真实路径 |
      | String request.getContextPath() | 返回上下文路径 |



