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
  * __2. JSP页面注释: __ <br>
    html的注释: \<!-- html注释--> //客户端可见 <br>
    JSP注释: <%-- html注释 --> //客户端不可见
    JSP脚本注释: //单行注释  /* 多行注释*/
  * __3. JSP脚本: __ <br>
    是指在JSP页面中执行的Java代码，语法格式: __<%  Java代码  %>__
  * __4. JSP页面中定义变量或方法: __ <br>
    语法: __<%! Java代码%>__ 这句话表示感叹号以后是声明语句
  * __5. JSP表达式: __ <br>
    是指在JSP页面中执行的表达式
    语法: __<% =表达式 %>  //注意： 表达式不以分号结束__
  



