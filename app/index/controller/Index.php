<?php
namespace app\index\controller;
use think\Controller;

class Index extends Controller
{
    public function index(){
        if (session('?user')){
            $this->assign("islogin",true);
            $data = session('user');
            $u = Model("User")->where(["user"=>$data["user"]])->find();
            if ($u != null){
                $this->assign("user",$u);
            }
        }else{
            $this->assign("islogin",false);
        }
        
        $this->assign("tgchannel",config("app.tgchannel"));
        return $this->fetch();
    }
    public function getlist(){
        $request = request()->param("");
        return Model("Index")->getlist($request);
    }
    public function edit(){
        if (config("app.addpass")){
            if (session('?user')){
                $user = session('user');
                $a = explode(",",config("app.adduid"));
                if (!in_array($user["id"],$a)){
                    return $this->error("对不起您没有添加权限!,请联系管理员开通。");
                }
            }else{
                return $this->error("对不起您没有添加权限!,请联系管理员开通。");
            }
        }
        $this->assign("companyarr",str_replace(["\t"," "],"",join(Model("Company")->getcolumnname(),'","')));
        $this->assign("placearr",str_replace(["\t"," "],"",join(Model("Place")->getcolumnname(),'","')));
        
        return $this->fetch();
    }
    public function savedata(){
        if (config("app.addpass")){
            if (session('?user')){
                $user = session('user');
                $a = explode(",",config("app.adduid"));
                if (!in_array($user["id"],$a)){
                    return $this->error("对不起您没有添加权限!,请联系管理员开通。");
                }
            }else{
                return $this->error("对不起您没有添加权限!,请联系管理员开通。");
            }
        }
        $data = input('post.');
      	if(model('Index')->saveData( $data ) > 0){
            return $this->success("添加成功",url("/"));
        }else{
            return $this->fail("添加失败",url("/"));
        }
    }
    public function test(){
        return Model("Index")->test();
    }
    public function usersavedata(){
        $data = input('post.');
      	if(model('User')->saveData( $data )){
            return json(["status"=>1]);
        }else{
            return json(["status"=>0]);
        }
    }
    public function login(){
        $data = input('post.');
        return model('User')->login( $data );
    }
    public function loginout(){
        session('user', null);
    }
    public function subscribe(){
        $data = input('post.');
        return model('User')->subscribe( $data );
    }

    
}
