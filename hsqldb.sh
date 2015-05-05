#!/bin/bash
set -e

trap 'shut_down' HUP INT QUIT TERM
function shut_down() {
	java -jar lib/sqltool.jar --sql 'shutdown;' db0
}

java -cp lib/hsqldb.jar org.hsqldb.server.Server &
wait $!

