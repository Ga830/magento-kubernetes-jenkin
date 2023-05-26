FROM alexcheng/magento2:latest

#Setup Working Directory
WORKDIR /var/www/html
RUN rm -rf *
COPY . .

#PHP ENV
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    PHPIZE_DEPS="autoconf dpkg-dev file g++ gcc libc-dev make pkg-config re2c" \
    PHP_INI_DIR="/usr/local/etc/php" \
    APACHE_CONFDIR="/etc/apache2" \
    APACHE_ENVVARS="/etc/apache2/envvars" \
    PHP_EXTRA_BUILD_DEPS="apache2-dev" \
    PHP_EXTRA_CONFIGURE_ARGS="--with-apxs2 --disable-cgi" \
    PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    PHP_CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    PHP_LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" \
    GPG_KEYS="1729F83938DA44E27BA0F4D3DBDB397470D12172 B1B44D8F021E4E2D6021E995DC9FF8D3EE5AF27F" \
    PHP_VERSION="7.2.12" \
    PHP_URL="https://secure.php.net/get/php-7.2.12.tar.xz/from/this/mirror" \
    PHP_ASC_URL="https://secure.php.net/get/php-7.2.12.tar.xz.asc/from/this/mirror" \
    PHP_SHA256="989c04cc879ee71a5e1131db867f3c5102f1f7565f805e2bb8bde33f93147fe1" \
    PHP_MD5="" \
    MAGENTO_VERSION="2.3.1" \
    INSTALL_DIR="/var/www/html" \
    COMPOSER_HOME="/var/www/.composer/"

#Expose internet
EXPOSE 80
RUN chown -R www-data:www-data ./ && chmod -R 755 ./

#Run 
ENTRYPOINT ["/sbin/my_init"]