FROM postgres:11.5

ADD . /src
RUN chmod +x /src/*.sh

EXPOSE 5432

ADD init.sh /docker-entrypoint-initdb.d/init.sh
