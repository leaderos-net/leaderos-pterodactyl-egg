#!/bin/bash
rm -rf /home/container/tmp/*

echo "⟳ Starting PHP..."
php -v
/usr/sbin/php-fpm7 --fpm-config /home/container/php/php-fpm.conf --daemonize

echo "⟳ Starting Nginx..."
echo "✓ Successfully started"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/
