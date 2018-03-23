<?php
namespace app\index\model;

use think\Model;
use traits\model\SoftDelete;
use think\DB;
class Index extends Model{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    protected function fmtRequest( $request = [] )
    {
        if( empty($request) ) {
            return $request;
        }
        $offset = 0;
        if (isset($request['offset']) && is_numeric($request['offset']) ) {
            $offset = $request['offset'];
            unset($request['offset']);
        }
        $limit = 5;
        if (isset($request['limit']) && is_numeric($request['limit']) ) {
            $limit = $request['limit'];
            unset($request['limit']);
        }
		$order = "";
		if (isset($request['order']) && !empty($request['order']) ) {
            $order = $request['order'];
            unset($request['order']);
        }
		$sort = '';
		if (isset($request['sort']) && !empty($request['sort']) ) {
            $sort = $request['sort'];
            unset($request['sort']);
        }
		$ordera = [];
		if ( !empty($order) && !empty($sort) ){
			$ordera = [$sort=>$order];
		}
        $ret = [
            'offset'=>$offset,
            'limit'=>$limit,
            'map'=>$request,
			'order'=>$ordera
        ];
        return $ret;
    }
    public function getlist($request){
        $request = $this->fmtRequest( $request );
        if (isset($request["map"]["search"])){
			$request["map"][join(Db::getTableInfo('xm_index', 'fields')," | ")] = ["LIKE","%" . $request["map"]["search"] . "%"];
		}
		unset($request["map"]["search"]);
        $data = $this->order(array_merge($request["order"],["create_time"=>"desc"]))->where( $request['map'] )->limit($request['offset'], $request['limit'])->select();
        $company = Model("Company")->column("name","id");
        $place = Model("Place")->column("name","id");
        foreach($data as &$value){
            $value["companyname"]=$company[$value["companyid"]];
            $value["placename"]=$place[$value["placeid"]];
        }
		$total=$this->where( $request['map'] )->count();
        $returnarr= array("rows"=>$data,"total"=>$total);
        
		return json($returnarr);
    }
    public function saveData($data){
        $company = Model("Company")->where(["name"=>$data["companyname"]])->find();
		if (is_null($company)){
			$company = Model("Company");
			$company->save(["name"=>$data["companyname"]]);
			$data["companyid"]=$company->id;
		}else{
			$data["companyid"]=$company["id"];
        }



        $place = Model("Place")->where(["name"=>$data["placename"]])->find();
		if (is_null($place)){
			$place = Model("Place");
			$place->save(["name"=>$data["placename"]]);
			$data["placeid"]=$place->id;
		}else{
			$data["placeid"]=$place["id"];
        }

        if (config("app.addpass")){
            $data["status"] = 1;
        }
        
		$this->allowField(true)->save($data);
      	return $this->id;
    }
    public function test(){
        $list = $this->where(["status"=>1])->select();
        $r = [];
      	$log = Model('Log');
      	$index =  Model('Index');
        $user = Model("User");
        $request = request();
        $host = $request->domain();
        foreach ($list as $value){
            $str = go_curl($value["vurl"],"get");
            $a = eval($value["vf"]);
            $r[] = "{$value['name']} --- " . (($a) ? 'true' : 'false');
            if ($a != $value["stock"]){
                $index->save(["stock"=>$a],["id"=>$value["id"]]);
                $log->data(["status"=>$a,"indexid"=>$value["id"]])->isUpdate(false)->save();
            }
            if ($value["stock"] == false && $a == true){
                $p = $user->where("find_in_set({$value['id']},subscribe)")->select();
                $title = "您关注的{$value['name']}有货啦。";
                $content = "您关注的{$value['name']}有货啦。\n快来大肆抢购呀。\n测评地址：$host/ceping/{$value['id']}\n购买地址：$host/buy/{$value['id']}";
                foreach ($p as $k => $v) {
                    if ($v["ftsckey"] != ""){
                        go_curl("https://sc.ftqq.com/{$v['ftsckey']}.send","post", ["text"=>$title,"desp"=>$content]);
                    }
                    if ($v["tgsckey"] != ""){
                        go_curl("https://cloud.hcaiyue.top/tgbot.php","post", ["method"=>"send","content"=>$content,"sckey"=>$v["tgsckey"]]);
                    }
                }
                if (config("app.tgchannelsckey") != ""){
                    go_curl("https://cloud.hcaiyue.top/tgbot.php","post", ["method"=>"send","content"=>$content,"sckey"=>config("app.tgchannelsckey")]);
                }

            }
        }
        return "<pre>" . join($r,"\n") . "\nOK" . "</pre>";
    }
}
