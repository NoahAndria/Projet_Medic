#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

# Configuration
APP_NAME="PatientManagementBak"
SRC_DIR="src/main/java"
WEB_DIR="src/main/webapp"
BUILD_DIR="build"
LIB_DIR="$BUILD_DIR/WEB-INF/lib"
TOMCAT_WEBAPPS="/home/noah/truetomcat/webapps"

echo "Downloading dependencies..."

# Download Hibernate and Spring Data dependencies
mvn -q dependency:copy-dependencies \
    -DoutputDirectory=lib/jpa \
    -DincludeScope=runtime

echo "Preparing build directory..."

# Clean previous build
rm -rf -- "$BUILD_DIR"

mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$LIB_DIR"

echo "Compiling Java sources..."

# Find all Java files
find "$SRC_DIR" -name "*.java" > sources.txt

# Compile with framework, Hibernate and Spring dependencies
javac -parameters \
    -cp "lib/*:lib/jpa/*" \
    -d "$BUILD_DIR/WEB-INF/classes" \
    @sources.txt

echo "Copying resources..."

# Copy persistence.xml and other resources
cp -R src/main/resources/. \
    "$BUILD_DIR/WEB-INF/classes/"

echo "Copying libraries..."

# Framework and MySQL
cp lib/my-framework.jar "$LIB_DIR/"
cp lib/mysql-connector-j-9.5.0.jar "$LIB_DIR/"

# Hibernate and Spring dependencies
cp lib/jpa/*.jar "$LIB_DIR/"

# Do not package servlet-api.jar
# Tomcat provides its own Servlet API

echo "Copying web resources..."

# Copy web.xml, JSPs, views, assets, etc.
cp -R "$WEB_DIR"/. "$BUILD_DIR"/

# Move web.xml
mv "$BUILD_DIR/web.xml" \
   "$BUILD_DIR/WEB-INF/web.xml"

# Move views into WEB-INF
mv "$BUILD_DIR/views" \
   "$BUILD_DIR/WEB-INF/views"

echo "Creating WAR..."

(
    cd "$BUILD_DIR"
    jar -cf "$APP_NAME.war" *
)

echo "Deploying to Tomcat..."

cp -f "$BUILD_DIR/$APP_NAME.war" \
      "$TOMCAT_WEBAPPS/"

echo ""
echo "Deployment completed successfully!"
echo "Restart Tomcat if necessary."
echo ""