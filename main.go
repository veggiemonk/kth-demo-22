package main

import (
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"os"
	"time"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

func main() {
	log.Print("starting...")
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}
	mux := http.NewServeMux()

	info := getEnvInfo()
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "requested: %s %s\n%s", r.Method, r.URL.Path, info)
	})
	log.Print("using port ", port)
	s := &http.Server{
		Addr:    fmt.Sprintf(":%s", port),
		Handler: mux,
	}
	log.Fatal(s.ListenAndServe())
}

func getEnvInfo() string {
	nodeName := os.Getenv("MY_NODE_NAME")
	podName := os.Getenv("MY_POD_NAME")
	namespace := os.Getenv("MY_POD_NAMESPACE")
	ip := os.Getenv("MY_POD_IP")
	svc := os.Getenv("MY_POD_SERVICE_ACCOUNT")
	tmpl := " node: %s\n pod: %s\n namespace: %s\n IP: %s\n service account: %s\n"
	return fmt.Sprintf(tmpl, nodeName, podName, namespace, ip, svc)
}
