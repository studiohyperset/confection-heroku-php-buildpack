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
source $snowflake_dir/scripts/build_pdo_snowflake.sh

# /app/php/bin/phpize
# ./configure --enable-phalcon --with-php-config=$PHP_ROOT/bin/php-config
# make
# make install
BUILD_DIR=$1
ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH
bash ./install
cp $snowflake_dir/scripts/pdo_snowflake.so $PATH/extensions
cp $snowflake_dir/libsnowflakeclient/cacert.pem $PATH
cd
echo "Insert extension and cacert on php.ini"
echo "extension=pdo_snowflake.so" >> /app/.heroku/php/etc/php/php.ini 
echo "pdo_snowflake.cacert=$PATH/cacert.pem" >> /app/.heroku/php/etc/php/php.ini 