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


        
		$this->allowField(true)->save($data);
		if($this->id > 0){
            return $this->success("添加成功",url("/"));
        }else{
            return $this->fail("添加失败",url("/"));
        }
    }
    public function test(){
        $list = $this->where(["status"=>1])->select();
        $r = [];
        foreach ($list as $value){
            $str = $this->go_curl($value["vurl"],"get");
            $a = eval($value["vf"]);
            $r[] = "{$value['name']} --- " . (($a) ? 'true' : 'false');
            if ($a != $value["stock"]){
                Model('Index')->save(["stock"=>$a],["id"=>$value["id"]]);
                Model('Log')->isUpdate(false)->save(["status"=>$a,"indexid"=>$value["id"]]);
            }
        }
        return "<pre>" . join($r,"\n") . "\nOK" . "</pre>";
    }
    /**
     * curl 函数
     * @param string $url 请求的地址
     * @param string $type POST/GET/post/get
     * @param array $data 要传输的数据
     * @param string $err_msg 可选的错误信息（引用传递）
     * @param int $timeout 超时时间
     * @param array 证书信息
     * @author liw@alltosun.com
     */
    function go_curl($url, $type, $data = false, &$err_msg = null, $timeout = 20, $cert_info = array())
    {
        $type = strtoupper($type);
        if ($type == 'GET' && is_array($data)) {
            $data = http_build_query($data);
        }
        $option = array();
        if ( $type == 'POST' ) {
            $option[CURLOPT_POST] = 1;
        }
        if ($data) {
            if ($type == 'POST') {
                $option[CURLOPT_POSTFIELDS] = $data;
            } elseif ($type == 'GET') {
                $url = strpos($url, '?') !== false ? $url.'&'.$data :  $url.'?'.$data;
            }
        }
        $option[CURLOPT_URL]            = $url;
        $option[CURLOPT_FOLLOWLOCATION] = TRUE;
        $option[CURLOPT_MAXREDIRS]      = 4;
        $option[CURLOPT_RETURNTRANSFER] = TRUE;
        $option[CURLOPT_TIMEOUT]        = $timeout;
        //设置证书信息
        if(!empty($cert_info) && !empty($cert_info['cert_file'])) {
            $option[CURLOPT_SSLCERT]       = $cert_info['cert_file'];
            $option[CURLOPT_SSLCERTPASSWD] = $cert_info['cert_pass'];
            $option[CURLOPT_SSLCERTTYPE]   = $cert_info['cert_type'];
        }
        //设置CA
        if(!empty($cert_info['ca_file'])) {
            // 对认证证书来源的检查，0表示阻止对证书的合法性的检查。1需要设置CURLOPT_CAINFO
            $option[CURLOPT_SSL_VERIFYPEER] = 1;
            $option[CURLOPT_CAINFO] = $cert_info['ca_file'];
        } else {
            // 对认证证书来源的检查，0表示阻止对证书的合法性的检查。1需要设置CURLOPT_CAINFO
            $option[CURLOPT_SSL_VERIFYPEER] = 0;
        }
        $ch = curl_init();
        curl_setopt_array($ch, $option);
        $response = curl_exec($ch);
        $curl_no  = curl_errno($ch);
        $curl_err = curl_error($ch);
        curl_close($ch);
        // error_log
        if($curl_no > 0) {
            if($err_msg !== null) {
                $err_msg = '('.$curl_no.')'.$curl_err;
            }
        }
        return $response;
    }
}
