<?php
return [
    'app'                 => [
        'addpass'   => true, //公共添加 true为指定用户可添加 flase 为所有人都可以添加 不过需要审核
        'adduid'   => "1", //添加界面密码
        'testtick' => 60*60, //命令行定时执行时间 秒为单位
        'host'     => 'http://vps.hcaiyue.top' //这里修改成自己的域名
    ],
];