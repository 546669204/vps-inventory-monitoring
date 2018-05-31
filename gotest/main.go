package main

import (
	"bytes"
	"fmt"
	"html/template"
	"log"
	"regexp"
	"time"

	"github.com/546669204/golang-http-do"
	"github.com/tidwall/gjson"

	_ "github.com/go-sql-driver/mysql"
	"github.com/robertkrimen/otto"
)

var chanRow chan gjson.Result
var endflag chan bool
var writeMysql chan string
var UserJson gjson.Result
var runStatus chan string
var vm *otto.Otto

func init() {
	//JS执行库初始化
	vm = otto.New()
	vm.Run(`
		function strpos(str,tar){
			if(typeof str != "string" || typeof tar != "string"){
				return false;
			}
			return str.indexOf(tar) == -1 ?false:str.indexOf(tar);
		}
	`)
	runStatus = make(chan string, 100)
	writeMysql = make(chan string, 100)
	endflag = make(chan bool)
	//endflag := make(chan bool)
	//writeMysql := make(chan string)
}
func main() {

	//`SELECT * FROM xm_index WHERE STATUS = 1`
	//`INSERT INTO xm_log (indexid, status,create_time,update_time) VALUES (值1, 值2,....)`
	//`UPDATE xm_index SET status = 1 WHERE id = 0`
	runStr := ""
	go func() {
		for {
			fmt.Printf("\r")
			fmt.Printf("当前时间:%s  =====> 正在运行  || %s", time.Now().Format("2006-01-02 15:04:05"), runStr)
			time.Sleep(time.Second)
		}
	}()
	go func() {
		for {
			runStr, _ = <-runStatus
		}
	}()

	ThreadNumber := len(GetConfig().Proxy)

	go mysqlWriteProcess()

	for {
		chanRow = make(chan gjson.Result, 100)
		for _, v := range GetConfig().Proxy {
			go factoryProcess(v.String())
		}
		rows, err := db.Query("SELECT * FROM xm_index WHERE STATUS = 1")
		if err != nil {
			log.Fatal(err)
		}
		defer rows.Close()
		userrows, err := db.Query("SELECT * FROM xm_user")
		if err != nil {
			log.Fatal(err)
		}
		defer userrows.Close()
		RowMap := make(map[int]gjson.Result)
		UserJson = gjson.Parse(RowJsonify(userrows))

		for k, v := range gjson.Parse(RowJsonify(rows)).Array() {
			RowMap[k] = v
		}
		for _, v := range RowMap {
			chanRow <- v
		}
		close(chanRow)

		for i := 0; i < ThreadNumber; i++ {
			<-endflag
		}
		time.Sleep(1 * time.Minute)
	}
	close(endflag)
}
func factoryProcess(proxy string) {
	for {
		row, ok := <-chanRow
		if !ok {
			endflag <- true
			break
		}
		op := httpdo.Default()
		op.Url = row.Get("vurl").String()
		if proxy != "local" {
			op.Proxystr = proxy
		}
		httpbyte, err := httpdo.HttpDo(op)
		if err != nil {
			log.Println("HttpDo", err, op.Url)
		}
		vmt := vm.Copy()
		curl, err := vmt.Object(fmt.Sprintf(`({"Code":%d,"RequestHeader":"%s","ResponseHeader":"%s"})`, op.Raw.Resp.StatusCode, "", ""))
		if err != nil {
			log.Println(err.Error())
		}
		value, err := vmt.Object(fmt.Sprintf(`({"stock":%d})`, row.Get("stock").Int()))
		if err != nil {
			log.Println(err.Error())
		}
		vmt.Set("$curl", curl)
		vmt.Set("$value", value)
		vmt.Set("$str", string(httpbyte))
		ret, err := vmt.Run(row.Get("vf").String())
		stock, err := ret.ToBoolean()
		if err != nil {
			log.Println(err.Error())
		}
		runStatus <- fmt.Sprintf(`%s==>%t`, row.Get("name").String(), stock)
		if stock != (row.Get("stock").Int() == 1) {
			writeMysql <- fmt.Sprintf(`UPDATE xm_index SET status = %t WHERE id = %d`, stock, row.Get("id").Int())
			writeMysql <- fmt.Sprintf(`INSERT INTO xm_log (indexid, status,create_time,update_time) VALUES (%d,%t,%d,%d)`, row.Get("id").Int(), stock, time.Now().Unix(), time.Now().Unix())
		}
		if row.Get("stock").Int() == 0 && stock == true {
			data := make(map[string]interface{})
			data["name"] = row.Get("name").String()
			data["id"] = row.Get("id").Int()
			title := templateParse(GetConfig().Title, data)
			content := templateParse(GetConfig().Content, data)
			for _, v := range UserJson.Array() {
				reg := regexp.MustCompile(fmt.Sprintf(`^%d,|,%d,`, row.Get("id").Int(), row.Get("id").Int()))
				if reg.Match([]byte(v.Get("subscribe").String())) {
					if v.Get("ftsckey").String() != "" {
						ftPush(v.Get("ftsckey").String(), title, content)
					}
					if v.Get("tgsckey").String() != "" {
						tgPush(v.Get("tgsckey").String(), title, content)
					}
				}
			}
			if GetConfig().Tgchannelsckey != "" {
				tgPush(GetConfig().Tgchannelsckey, title, content)
			}
		}
		time.Sleep(5 * time.Second)
	}
}

func ftPush(sckey, title, content string) {
	op := httpdo.Default()
	op.Url = fmt.Sprintf(`https://sc.ftqq.com/%s.send`, sckey)
	op.Method = "POST"
	op.Data = fmt.Sprintf(`text=%s&desp=%s`, title, content)
	httpdo.HttpDo(op)
}
func tgPush(sckey, title, content string) {
	op := httpdo.Default()
	op.Url = GetConfig().Tgboturl
	op.Method = "POST"
	op.Data = fmt.Sprintf(`method=send&sckey=%s&content=%s`, sckey, content)
	httpdo.HttpDo(op)
}

func templateParse(templateText string, data interface{}) string {
	tem := template.New("fieldname example")
	tem, _ = tem.Parse(templateText)
	b := bytes.NewBuffer(make([]byte, 0))
	tem.Execute(b, data)
	return b.String()
}

func mysqlWriteProcess() {
	runSql := []string{}
	t1 := time.NewTimer(time.Second * 3)
	for {
		select {
		case sql, ok := <-writeMysql:
			if !ok {
				return
			}
			runSql = append(runSql, sql)
			if len(runSql) > 10 {
				mysqlWriteSQL(&runSql)
			}
			break
		case <-t1.C:
			mysqlWriteSQL(&runSql)
			break
		}
	}
}
func mysqlWriteSQL(runsql *[]string) {
	tx, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}
	for _, v := range *runsql {
		tx.Query(v)
	}
	tx.Commit()
	*runsql = []string{}
	return
}
