<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:80:"C:\Users\wzzw\Desktop\git\VPS-IN~1\php\public/../app/index\view\index\index.html";i:1512699314;}*/ ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>vps库存监控</title>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
    <link href="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.css" rel="stylesheet">
</head>
<body>

    
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                    <h1 class="inline-block">VPS库存监控系统</h1><span>实时把握库存信息</span>
                    <a href="/index/index/edit">点击添加</a>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <table id="table"
                    data-toolbar="#toolbar"
                    data-search="true"
                    data-show-refresh="true"
                    data-show-toggle="true"
                    data-show-columns="true"
                    data-show-export="true"
                    data-detail-view="false"
                    data-detail-formatter="detailFormatter"
                    data-minimum-count-columns="2"
                    data-show-pagination-switch="true"
                    data-pagination="true"
                    data-id-field="id"
                    data-page-list="[10, 25, 50, 100, ALL]"
                    data-show-footer="false"
                    data-side-pagination="server"
                    data-url="<?php echo url('index/index/getList?'); ?>"
                    
                >
                    <thead>
                        <tr>
                            <th data-width="50" data-field="companyname" >服务商</th>
                            <th data-width="50" data-field="placename" >位置</th>
                            <th data-width="50" data-field="ram" data-sortable="true">内存</th>
                            <th data-width="50" data-field="disk" data-sortable="true">硬盘</th>
                            <th data-width="50" data-field="cpu" data-sortable="true">cpu</th>
                            <th data-width="50" data-field="ip4" data-sortable="true">IP4</th>
                            <th data-width="50" data-field="ip6" data-sortable="true">IP6</th>
                            <th data-width="50" data-field="frame"  data-sortable="true">虚拟化</th>
                            <th data-width="50" data-field="flow" data-sortable="true">流量</th>
                            <th data-width="50" data-field="bandwidth" data-sortable="true" data-formatter="bandwidth">带宽</th>
                            <th data-width="50" data-field="stock" data-sortable="true" data-formatter="stock">库存</th>
                            <th data-width="50" data-field="remark" data-sortable="true">备注</th>
                            <th data-width="50" data-field="yearly" data-sortable="true">年付</th>
                            <th data-width="50" data-field="monthly" data-sortable="true">月付</th>
                            <th data-width="50" data-field="buy" data-formatter="buy">购买</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <script>

        function bandwidth(value,row,index){
            return value + "M";
        }
        function stock(value,row,index){
            return value==0?'缺货':'有货';
        }
        function buy(value,row,index){
            return "<a href='"+value+"'>购买链接</a>";
        }
        
    $('#table').bootstrapTable({
        
    });
    </script>
</body>
</html>