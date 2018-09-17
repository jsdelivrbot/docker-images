#!/bin/bash
source /root/.gvm/scripts/gvm
gvm use go1.11 --default
export CGO_ENABLED=0
go get github.com/astaxie/beego
go build -o hello hello.go
