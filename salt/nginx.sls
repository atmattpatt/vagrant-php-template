nginx:
  pkg:
    - installed

  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-enabled/application
    - require:
      - file: nginx-application

nginx-application:
  file.managed:
    - name: /etc/nginx/sites-enabled/application
    - source: salt://etc/nginx/application.conf

nginx-vagrant-group:
  user.present:
    - name: www-data
    - groups:
      - vagrant
