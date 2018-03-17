# 欢迎使用 vps-inventory-monitoring 监控系统

------

这是一个在实际应用场景下的软件。
通过Curl 抓取网页源代码 来监控 目标字段的变化 **实时把握库存信息**

## 安装指南

1.创建数据库导入数据库文件mysql.sql

2.修改数据库配置文件vps-inventory-monitoring\app\database.example.php

3.配置Web服务器运行目录vps-inventory-monitoring\public

4.设置定时任务 http://localhost/index/index/test

4.访问即可查看结果

-----

## 常见问题

1.添加页面出现404错误  ==> 设置Url ReWrite  

2.添加后不会检测 ==> 修改数据库xm_index的status为1(1视为通过审核)  

3.待更新
