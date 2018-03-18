<?php
namespace app\index\model;

use think\Model;
use traits\model\SoftDelete;
use think\DB;
class User extends Model{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    public function saveData($data){
        $data["pass"] = md5("xiaoming".$data["pass"]);
        $id = $data["id"];
        unset($data["id"]);
        if ($id =="0"){
            if ($this->where(["user"=>$data["user"]])->find() != null){
                return false;
            }
            $this->allowField(true)->save($data);
        }else{
            $this->allowField(true)->save($data,["id"=>$id]);
        }
      	return true;
    }
    public function login($data){
        $u = $this->where(["user"=>$data["user"],"pass"=>md5("xiaoming".$data["pass"])])->find();
        if ($u != null){
            session('user',$u);
            return json(["status"=>1]);
        }
        return json(["status"=>0]);
    }
    public function subscribe($data){
        if (session('?user')){
            $user = session('user');
            $u = $this->where(["id"=>$user["id"]])->find();
            $a = explode(",",$u["subscribe"]);

            
            if (in_array($data["id"],$a)){
                foreach( $a as $k=>$v) {
                    if($data["id"] == $v) unset($a[$k]);
                }
            }else{
                array_push($a ,$data["id"]);
            }
            $user["subscribe"] = join(",",$a);
            session('user',$user);
            $u = $this->save(["subscribe"=>join(",",$a)],["id"=>$user["id"]]);
            return json(["status"=>1]);
        }else{
            return json(["status"=>0]);
        }



        $u = $this->where(["user"=>$data["user"],"pass"=>md5("xiaoming".$data["pass"])])->find();
        if ($u != null){
            session('user',$u);
            return json(["status"=>1]);
        }
        return json(["status"=>0]);
    }



}
