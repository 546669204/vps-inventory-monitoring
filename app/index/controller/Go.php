<?php
namespace app\index\controller;
use think\Controller;

class Go extends Controller{
    public function buy(){
        $request = request()->param("");
        $data = Model("Index")->where(["id"=>$request["id"]])->find();
        if ($data != null){
            if ($data["buy"] == ""){
                return $this->error("不存在该地址！");
            }
            return $this->redirect($data["buy"],302);
        }
        return $this->error("不存在该地址！");
    }
    public function ceping(){
        $request = request()->param("");
        $data = Model("Index")->where(["id"=>$request["id"]])->find();
        if ($data != null){
            if ($data["ceping"] == ""){
                return $this->error("不存在该地址！");
            }
            return $this->redirect($data["ceping"],302);
        }
        return $this->error("不存在该地址！");
    }
    public function company(){
        $request = request()->param("");
        $data = Model("Company")->where(["id"=>$request["id"]])->find();
        if ($data != null){
            if ($data["url"] == ""){
                return $this->error("不存在该地址！");
            }
            return $this->redirect($data["url"],302);
        }
        return $this->error("不存在该地址！");
    }
}