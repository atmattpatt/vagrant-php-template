php:
  pkg.installed:
    - pkgs:
      - php5-cli
      - php5-fpm
      - php5-json
      - php5-pgsql
      - php5-readline
      - php5-redis

  service.running:
    - name: php5-fpm
    - enable: True
    - reload: True
    - watch:
      - file: /etc/php5/fpm/php.ini
    - require:
      - file: php-ini
      - file: composer

php-ini:
  file.managed:
    - name: /etc/php5/fpm/php.ini
    - source: salt://etc/php5/fpm/php.ini

php-fpm-config:
  file.managed:
    - name: /etc/php5/fpm/pool.d/www.conf
    - source: salt://etc/php5/fpm/pool.d/application.conf

composer:
  file.managed:
    - name: /usr/local/bin/composer
    - source: salt://bin/composer.phar
    - mode: 0755
