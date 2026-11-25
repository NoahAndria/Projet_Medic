#!/bin/bash

set -e

cd "$(dirname "$0")"

# Create compilation directories
mkdir -p classes
mkdir -p build/WEB-INF/classes
mkdir -p build/WEB-INF/lib

# Find all Java source files
find src/main/java -name "*.java" > sources.txt

# Compile Java classes
javac -cp "lib/*:lib/jpa/*" \
      -d classes \
      @sources.txt

# Copy compiled classes
cp -R classes/. build/WEB-INF/classes/

# Copy JPA configuration
mkdir -p build/WEB-INF/classes/META-INF

cp src/main/resources/META-INF/persistence.xml \
   build/WEB-INF/classes/META-INF/

# Copy required libraries
cp lib/my-framework.jar build/WEB-INF/lib/
cp lib/mysql-connector-j-9.5.0.jar build/WEB-INF/lib/
cp lib/jpa/*.jar build/WEB-INF/lib/

echo "Compilation completed successfully!"