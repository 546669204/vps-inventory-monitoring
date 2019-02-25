# 欢迎使用 vps-inventory-monitoring 监控系统

------

这是一个在实际应用场景下的软件。
通过Curl 抓取网页源代码 来监控 目标字段的变化 **实时把握库存信息**   
[Demo](http://vps.hcaiyue.top)

## 安装指南

1.创建数据库导入数据库文件mysql.sql

2.修改数据库配置文件 vps-inventory-monitoring/app/database.example.php [需要重命名为database.php]

3.配置Web服务器运行目录 vps-inventory-monitoring/public  

4.修改系统配置 app/index/config.php 定时时间 域名 等  

5.SSH 进入网站目录 运行 `php think VpsTest ` 系统开始自动验证 

6.访问即可查看结果

## Docker 

1.安装docker  
2.git clone https://github.com/546669204/vps-inventory-monitoring.git  
3.cd vps-inventory-monitoring  
4.docker-compose up -d  
5.访问 :7780


如有问题 请尝试
>docker-compose down  
docker-compose build  
docker-compose up -d 

-----

## 常见问题

1.添加页面出现404错误  ==> 设置Url ReWrite  

2.添加后不会检测       ==> 修改数据库xm_index的status为1(1视为通过审核)  

3.添加权限管理         ==> app/index/config.php    

4.设置后台运行验证程序  ==> 
>screen -S vpstest  //创建screen  
cd [网站根目录]  
php think VpsTest  
CTRL A D //退出screen  
然后关闭ssh即可
重新进入查看可使用  
screen -r vpstest

5.待更新

----
## 函数说明
 - $curl["Code"] 返回状态码  
 - $curl["RequestHeader"] 请求头  
 - $curl["ResponseHeader"] 返回头  
 - $str 返回源代码
 - $value["stock"] 原库存状态
### 演示检测函数
```
if ($curl["Code"] != 200){ //首先判断状态码
    return false;
}
if (strpos($str,"MineCloud")==false){ //检测是否正常打开有无公司名字之类关键词
    return $value["stock"]; //返回原库存状态
}
if (strpos($str,"缺货中")!==false){ //检测是否含有缺货关键词
    return false; 
}
return true;
```
---
## 更新日志
2019-02-25  
新增docker安装方式

2018-08-27  
更新thinkphp内核版本为5.0.20优化php7执行效率 感谢[@Blake-Bill](https://github.com/Blake-Bill)  

2018-06-01  
增加注册验证码  
增加多线程监测 更快的速度  

2018-04-07  
更新go_curl函数返回更多可用信息
添加调试功能

2018-03-23   
更新Telegram推送支持 频道推送和私人定制推送  
频道推送需后台设置sckey和频道链接  
配置文件 app/index/config.php    

2018-03-19  
更新命令行方式验证

2018-03-18  
根据[#3](https://github.com/546669204/vps-inventory-monitoring/issues/3)进行改进

1.个性化的产品来货推送  
2.跳转链接的简化  
3.增加筛选功能  
4.增加添加权限控制
