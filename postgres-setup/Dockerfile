FROM postgres:11.5

ADD . /src
RUN chmod +x /src/*.sh

ADD init.sh /docker-entrypoint-initdb.d/init.sh
