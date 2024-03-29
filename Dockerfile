FROM alpine:3.10

# Install packages
RUN apk --no-cache add php7 php7-fpm nginx supervisor curl php-curl composer bash git

# Configure nginx
COPY configs/nginx.conf /etc/nginx/nginx.conf
# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY configs/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY configs/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Setup document root
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY /html /var/www/html

# Switch to use a non-root user from here on

# Add application

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/tmp/nginx && \
  chown -R nobody.nobody /var/log/nginx && \
  chown -R nobody.nobody /var/www/html
USER nobody
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
# CMD /bin/bash
# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-pingFROM trafex/alpine-nginx-php7
