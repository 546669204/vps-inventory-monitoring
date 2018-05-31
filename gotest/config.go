package main

import (
	"bytes"
	"io/ioutil"

	"github.com/tidwall/gjson"
)

type Config struct {
	MysqlUser      string
	MysqlPass      string
	MysqlHost      string
	MysqlPort      string
	MysqlName      string
	ThreadNumber   int64
	Title          string
	Content        string
	Tgchannelsckey string
	Tgboturl       string
	Proxy          []gjson.Result
}

var C *Config = new(Config)

func init() {
	content, err := ioutil.ReadFile("config.json")
	if err != nil {
		panic(err)
	}
	C.MysqlUser = gjson.Get(string(content), "mysqluser").String()
	C.MysqlPass = gjson.Get(string(content), "mysqlpass").String()
	C.MysqlHost = gjson.Get(string(content), "mysqlhost").String()
	C.MysqlPort = gjson.Get(string(content), "mysqlport").String()
	C.MysqlName = gjson.Get(string(content), "mysqlname").String()
	C.ThreadNumber = gjson.Get(string(content), "ThreadNumber").Int()
	C.Title = gjson.Get(string(content), "title").String()
	C.Content = gjson.Get(string(content), "content").String()
	C.Tgchannelsckey = gjson.Get(string(content), "tgchannelsckey").String()
	C.Tgboturl = gjson.Get(string(content), "tgboturl").String()
	C.Proxy = gjson.Get(string(content), "proxy").Array()

}
func GetConfig() *Config {
	return C
}

func GetDsn() string {
	var buffer bytes.Buffer
	buffer.WriteString(C.MysqlUser)
	buffer.WriteString(":")
	buffer.WriteString(C.MysqlPass)
	buffer.WriteString("@(")
	buffer.WriteString(C.MysqlHost)
	buffer.WriteString(":")
	buffer.WriteString(C.MysqlPort)
	buffer.WriteString(")/")
	buffer.WriteString(C.MysqlName)
	buffer.WriteString("?charset=utf8")

	return buffer.String()
}
