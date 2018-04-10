package main

// 一个简单的http服务器

import (
        "io"
        "net/http"
        "fmt"
        "strconv"
)

func helloHandler(w http.ResponseWriter, req *http.Request) {
        fmt.Println("helloHandler req here")
        io.WriteString(w, "Hello, world hahahah!\n")
}

func testGetParamHandler(w http.ResponseWriter, req * http.Request) {
        // curl "http://127.0.0.1:12345/get_param?a=3&b=4"
        req.ParseForm()
        a, err := strconv.Atoi(string(req.Form.Get("a")[0]))
        if  err != nil {
                io.WriteString(w, "invalid a\n")
                return
        }
        b, err := strconv.Atoi(string(req.Form.Get("b")[0]))
        if  err != nil {
                io.WriteString(w, "invalid b\n")
                return
        }
        io.WriteString(w, fmt.Sprintf("a=%d, b=%d a+b=%d\n", a, b, a+b))
}

func testPostParamHandler(w http.ResponseWriter, req * http.Request) {
        // curl -X POST --data 'a=1;b=2' "http://127.0.0.1:12345/post_param"
        req.ParseForm()
        a, err := strconv.Atoi(string(req.PostFormValue("a")))
        if  err != nil {
                io.WriteString(w, "invalid a\n")
                return
        }
        b, err := strconv.Atoi(string(req.PostFormValue("b")))
        if  err != nil {
                io.WriteString(w, "invalid b\n")
                return
        }
        io.WriteString(w, fmt.Sprintf("post a=%d, b=%d, a+b=%d\n", a, b, a+b))
}

func main() {
        fmt.Println("start http server")
        mux := http.NewServeMux()
        mux.HandleFunc("/hello", helloHandler)
        mux.HandleFunc("/get_param", testGetParamHandler)
        mux.HandleFunc("/post_param", testPostParamHandler)
        http.ListenAndServe(":12345", mux)
}

