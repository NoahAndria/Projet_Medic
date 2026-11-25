#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

# 1. Build the Java project
cd demo
mvn clean package 

# 2. Start the Java server in the background
nohup java -jar target/demo-0.0.1-SNAPSHOT.jar > server.log 2>&1 &
SERVER_PID=$!

cd ..

# 3. Wait until the server responds
echo "Waiting for Spring Boot on port 8090..."

READY=false

for i in {1..30}; do

    if curl -s -o /dev/null --max-time 1 http://127.0.0.1:8090/; then
        READY=true
        break
    fi

    # Check if the Java process has crashed
    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
        echo "Java server stopped unexpectedly!"
        tail -n 30 demo/server.log
        exit 1
    fi

    sleep 1
done

if [ "$READY" = false ]; then
    echo "Server did not become ready within 30 seconds."
    tail -n 30 demo/server.log
    exit 1
fi

echo "Spring Boot is responding!"

# 4. Start the automation
./run-automated.sh