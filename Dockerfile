FROM httpd:latest

RUN apt-get update
RUN apt-get install -y openssl

COPY openssl.cnf /etc/ssl/
COPY httpd.conf /usr/local/apache2/conf
COPY httpd-ssl.conf /usr/local/apache2/conf/extra

USER root

# Create SSL
RUN openssl req \
  -newkey rsa:4096 \
  -days 3650 \
  -nodes \
  -x509 \
  -subj "/C=JP/ST=Distributed/L=Cloud/O=Cluster/CN=localhost" \
  -extensions SAN \
  -config /etc/ssl/openssl.cnf \
  -keyout /usr/local/apache2/conf/server.key \
  -out /usr/local/apache2/conf/server.crt;

# Open https
EXPOSE 443

# restart apache
RUN httpd -k restart