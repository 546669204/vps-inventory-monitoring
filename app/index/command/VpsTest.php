<?php
namespace app\index\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\console\input\Argument;
use think\console\input\Option;
use app\index\model\User;
use app\index\model\Index;
use app\index\model\Log;
use think\Config;

class VpsTest extends Command{
    protected $debug = true ;
    protected function configure(){
        $this->setName("VpsTest")->setDescription("This is Vps Test Command");
    }
    protected function execute(Input $input, Output $output){
        //获取参数值
        Config::load(APP_PATH . 'index/config.php'); 
        $log = new Log;
        $index =  new Index;
        $user = new User;
        while (1) {
            $output->writeln(date("Y-m-d h:i:s"));
            $list = $index->where(["status"=>1])->select();
            $r = [];
            $host = config("app.host");
            foreach ($list as $value){
                $str = go_curl($value["vurl"],"get");
                $a = eval($value["vf"]);
                $r[] = "{$value['name']} --- " . (($a) ? 'true' : 'false');
                if ($a != $value["stock"]){
                    $index->save(["stock"=>$a],["id"=>$value["id"]]);
                    $log->isUpdate(false)->save(["status"=>$a,"indexid"=>$value["id"]]);
                }
                if ($value["stock"] == false && $a == true){
                    $p = $user->where("find_in_set({$value['id']},subscribe)")->select();
                    $title = "您关注的{$value['name']}有货啦。";
                    $content = "您关注的{$value['name']}有货啦。\n快来大肆抢购呀。\n测评地址：$host/ceping/{$value['id']}\n购买地址：$host/buy/{$value['id']}";
                    foreach ($p as $k => $v) {
                        if ($v["ftsckey"] != ""){
                            go_curl("https://sc.ftqq.com/{$v['ftsckey']}.send","post", ["text"=>$title,"desp"=>$content]);
                        }
                    }
                }
                sleep(5);
            }
            $output->writeln( join($r,"\n") . "\nOK" );

            $output->writeln("Success !" );
            $output->writeln(date("Y-m-d h:i:s"));
            sleep(config("app.testtick"));
        }
        return ;
    }
}