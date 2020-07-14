FROM centos:latest

RUN yum -y update --setopt=tsflags=nodocs \
 && yum -y install --setopt=tsflags=nodocs createrepo nginx rpm-sign \
 && yum clean all

RUN sed -i -e "/^    server {/,/^    }/d" /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/conf.d/nginx.conf
ADD startup.sh /

EXPOSE 80
VOLUME /data
ENTRYPOINT ["/startup.sh"]
