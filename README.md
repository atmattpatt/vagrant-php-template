vagrant-php-template
====================

A template for bootstrapping PHP projects with Vagrant

What You Get
------------

* A virtual machine running Ubuntu 14.04 LTS Trusty Tahr
* A current version of PHP 5 from [Ubuntu](http://packages.ubuntu.com/trusty/), running inside of PHP-FPM
* Nginx hosting your application on Port 8000
* A PostgreSQL server
* A Redis server

Getting Started
---------------

1. Clone this repository
2. Make whatever configuration changes you need
3. Run `vagrant up` to create and provision your virtual machine

Configuration
-------------

Configration is handled by [Salt](http://docs.saltstack.com/en/latest/).  Before you get started, there are a couple of things you may need to change.

### Nginx Configuration

The default site configuration which ships with Nginx is not affected by Salt.  Instead, a configuration file for your application is added and listens on Port 8000.

You will need to change the file in `salt/etc/nginx/application.conf` to point to your application code.  You may also want to adjust the server name and rewrite rules.

#### Example: A basic PHP application

```nginx
server {
    listen 8000;

    root /home/vagrant/path/to/your/application;
    index index.php index.html;

    server_name your-application.local;

    location / {
        try_files $uri $uri/ /index.php;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
} 
```

#### Example: Symfony application

```nginx
server {
    listen 8000;

    root /home/vagrant/path/to/symfony/web;
    index app_dev.php index.html;

    server_name your-application.local;

    location / {
        try_files $uri $uri/ /app_dev.php;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
} 
```
