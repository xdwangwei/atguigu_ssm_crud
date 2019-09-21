# SSM-CRUD（[尚硅谷视频](https://www.bilibili.com/video/av35988777)）

### 一、开发工具

- #### InteliJ IDEA 2019

- #### Maven 3.6.1


### 二、.功能介绍

- #### 1. 增删改查

- #### 2. 分页查询

- #### 3. 数据校验

  - ##### 前端校验（JS）

  - ##### 后端校验（JSR303）

- #### 4. ajax

- #### 5. Rest风格URI:

  - ##### 使用Http协议请求方式的动词，来表示对资源的操作

  - ##### GET: /emps/get/{id} 查询

  - ##### GET: /emps/get 查询
  
  - ##### POST: /emps/save增加
  
  - ##### PUT: /emps/update/{id} 修改
  
  - ##### DELETE: /emps/del/{id} 删除
  
  - ##### DELETE: /emps/dels/{ids} 删除

### 三、技术支持

- #### 1. 基础框架（SSM-Spring+SpringMVC+Mybatis）

  - ##### Spring 5.1.6

  - ##### Mybatis 3.5.1

- #### 2. 数据库-Mysql 8.0

- #### 3. 前端框架-BootStrap 3.3.1

- #### 4. 项目依赖管理-Maven 3.6.1

- #### 5. 分页插件 PageHelper

- #### 6. 逆向工程-mybatis-generator

### 四、基础环境搭建

- #### 1. 创建maven-web工程

- #### 2. 导入项目依赖的坐标

    - ##### spring core
    - ##### spring mvc
    - ##### spring jdbc
    - ##### spring test
    - ##### spring aop
    - ##### mysql-connector-jar
    - ##### jstl taglib
    - ##### serlevt jsp
    - ##### mybatis mybatis-spring
    - ##### pagehelper
    - ##### hiberate validate
    - ##### 其他
- #### 3. 引入Bootstrap前端框架
- #### 4. 编写ssm整合配置文件

    - ##### web.xml
    - ##### mybatis-config.xml
    - ##### spring-mybatis.xml
    - ##### springMVC.XML
    - ##### configGenerator.xml
	- #### 5. 测试dao层配置（TestMapper.java）
### 五、查询
- #### 1. 访问index.jsp
- #### 2. index页面发送出查询员工列表请求
- #### 3. EmployeeController接收请求，查出员工数据，返回视图页面
- #### 4. jsp解析数据并显示
### 六、使用ajax+json实现查询及后续功能
- #### 1. index.jsp页面发送ajax请求进行员工数据分页查询
- #### 2. 服务器将查询到的数据以json字符串的形式返回给浏览器
- #### 3. 浏览器收到json字符串，使用js对json进行解析并处理，jquery操作DOM对象，实现数据显示
- #### 4. ajax实现了客户端的无关性
### 七、员工新增
- #### 1. 在index.jsp页面点击“新增”按钮
- #### 2. 弹出填写信息的对话框（BootStrap模态框）
- #### 3. 去数据库查询部门列表，显示在下拉列表
- #### 4. 用户输入数据，完成前后端校验
    - ##### js+jquery前端校验数据合理性
    - ##### ajax发送请求校验用户名是否重复
    - ##### 重要数据后端（JSR303）再次校验
- #### 5. 实现保存
### 八、员工信息修改
- #### 1. 在index.jsp页面点击“编辑”按钮
- #### 2. 弹出用于修改信息的对话框（BootStrap模态框，显示已有信息）
- #### 3. 用户输入数据，进行合理性校验
- #### 4. 点击修改，完成信息更新
### 九、员工删除
- #### 1. 在index.jsp页面点击“删除”按钮
- #### 2. 弹出确认框
- #### 3. 完成删除
    - ##### 单个删除 URI: /emps/del/{id}
    
    - ##### 批量删除 URI: /emps/dels/{ids}
    
### 十、总结

![img](file:///C:\Users\王伟\AppData\Roaming\Tencent\Users\207800885\QQ\WinTemp\RichOle\{U15TPJ}JN{TEGW]M@_4U46.png)















