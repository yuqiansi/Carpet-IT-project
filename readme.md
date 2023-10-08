
### 需要的工具

1. vscode (前端代码编写) 
2. node (前端运行时需要)
3. idea (后端)
4. mysql (数据库)
5. navicat / mysqlworkbench (数据库可视化工具)
6. maven (后端依赖)

### 后端步骤

1. 先装好mysql，打开navicat 或者 mysqlworkbench， 先创建数据库a_mall，再导入a_mall.sql文件 
2. 打开idea，导入后端源码（Api那个文件夹） ，让idea加载依赖
3. 配置applicaiton.yml文件的数据库配置：

   spring.datasource.url=jdbc:mysql://localhost:3306/你的数据库名字?
   serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8
   spring.datasource.username=root
   spring.datasource.password=你的数据库密码 
4. 进入 main / java 右键application文件， 点run

### 前端步骤

1. vscode导入Vue那个文件夹
2. terminal里输入npm run serve