make console

https://github.com/mattn/go-sqlite3
go get github.com/mattn/go-sqlite3

Sync all files:
scp -r . pi@192.168.0.17:/home/pi/wol


Winmdows: set GOPATH=%cd%
Linux: export GOPATH=$(pwd)


sudo apt-get install etherwake
sudo etherwake -i eth0 4C:CC:6A:B5:C7:72
