# 欢迎使用 vps-inventory-monitoring 监控系统

------

这是一个在实际应用场景下的软件。
通过Curl 抓取网页源代码 来监控 目标字段的变化 **实时把握库存信息**   
[Demo](http://vps.hcaiyue.top)

## 安装指南

1.创建数据库导入数据库文件mysql.sql

2.修改数据库配置文件 vps-inventory-monitoring/app/database.example.php  

3.配置Web服务器运行目录 vps-inventory-monitoring/public  

4.修改系统配置 app/index/config.php 定时时间 域名 等  

5.SSH 进入网站目录 运行 `php think VpsTest ` 系统开始自动验证 

6.访问即可查看结果

-----

## 常见问题

1.添加页面出现404错误  ==> 设置Url ReWrite  

2.添加后不会检测       ==> 修改数据库xm_index的status为1(1视为通过审核)  

3.添加权限管理         ==> app/index/config.php    

4.设置后台运行验证程序  ==> 
>screen vpstest  //创建screen  
cd [网站根目录]  
php think VpsTest  
CTRL  D //退出screen  
然后关闭ssh即可
重新进入查看可使用  
screen -r vpstest

5.待更新

----

## 更新日志

2018-03-19
更新命令行方式验证

2018-03-18  
根据[#3](https://github.com/546669204/vps-inventory-monitoring/issues/3)进行改进

1.个性化的产品来货推送  
2.跳转链接的简化  
3.增加筛选功能  
4.增加添加权限控制
