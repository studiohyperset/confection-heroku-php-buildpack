# Heroku Buildpack PHP with Snowflake Driver

This is the official [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for PHP applications with adjustments to build [Snowflake PDO](https://github.com/snowflakedb/pdo_snowflake) driver.

It uses Composer for dependency management, supports PHP or HHVM (experimental) as runtimes, and offers a choice of Apache2 or Nginx web servers.

## Usage

1. On your `app.json` you will need to add this repo git address as a buildpack
2. You may need to edit the file `bin/snowflake.sh` and adjust the extension folder address of your setup. `phpinfo()` will tell you the correct folder address.