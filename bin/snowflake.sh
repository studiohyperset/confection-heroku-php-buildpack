#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=git://github.com/snowflakedb/pdo_snowflake.git
snowflake_dir=pdo_snowflake
echo "-----> Building Snowflake..."

### Phalcon
echo "[LOG] Downloading Snowflake"
git clone $dep_url -q
if [ ! -d "$snowflake_dir" ]; then
  echo "[ERROR] Failed to find snowflake directory $snowflake_dir"
  exit
fi
echo "[LOG] Setting PHP_HOME"
export PHP_HOME=$1

echo "[LOG] Building Snowflake"
bash $snowflake_dir/scripts/build_pdo_snowflake.sh

echo "[DEBUG] PHP_HOME=$PHP_HOME"
echo "[DEBUG] SNOWFLAKE DIR=$snowflake_dir"
echo "[DEBUG] PATH=$PATH"
echo "[LOG] Copying PDO Snowflake to Extensions Folder"
cp $PHP_HOME/pdo_snowflake/modules/pdo_snowflake.so /app/.heroku/php/etc/php/ext

echo "[LOG] Copying cacert to PATH"
cp $snowflake_dir/libsnowflakeclient/cacert.pem $PATH

echo "[LOG] Inserting extension and certificate on php.ini"
echo "extension=pdo_snowflake.so" >> /app/.heroku/php/etc/php/php.ini 
echo "pdo_snowflake.cacert=$PATH/cacert.pem" >> /app/.heroku/php/etc/php/php.ini 

echo "[LOG] Finished Snowflake Setup"