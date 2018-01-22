<?php
namespace app\index\model;

use think\Model;
use traits\model\SoftDelete;

class Log extends Model{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    public function getcolumnname(){
        return ($this->column("name"));
    }
}
