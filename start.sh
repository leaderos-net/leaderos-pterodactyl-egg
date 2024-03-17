#!/bin/bash
rm -rf /home/container/tmp/*

mkdir -p /home/container/tmp/

echo "⟳ Starting PHP..."
/usr/sbin/php-fpm7 -c /home/container/php-fpm/php.ini --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "⟳ Starting Nginx..."
echo "✓ Successfully started"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/
