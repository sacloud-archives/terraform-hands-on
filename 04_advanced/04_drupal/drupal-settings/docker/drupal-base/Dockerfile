FROM drupal:7

MAINTAINER Kazumichi Yamamoto <yamamoto.febc@gmail.com>
VOLUME ["/var/www/html/sites"]

ADD php.ini $PHP_INI_DIR/php.ini

ADD wait-for-it.sh /tmp
RUN chmod +x /tmp/wait-for-it.sh

ADD setup.sh /tmp
RUN chmod +x /tmp/setup.sh
RUN /tmp/setup.sh

ADD run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]