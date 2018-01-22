<?php
namespace app\index\controller;
use think\Controller;

class Index extends Controller
{
    public function index(){
        return $this->fetch();
    }
    public function getlist(){
        $request = request()->param("");
        return Model("Index")->getlist($request);
    }
    public function edit(){
        $this->assign("companyarr",str_replace(["\t"," "],"",join(Model("Company")->getcolumnname(),'","')));
        $this->assign("placearr",str_replace(["\t"," "],"",join(Model("Place")->getcolumnname(),'","')));
        
        return $this->fetch();
    }
    public function savedata(){
        $data = input('post.');
        return model('Index')->saveData( $data );
    }
    public function test(){
        return Model("Index")->test();
    }
}
