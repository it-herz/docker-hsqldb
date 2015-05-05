FROM java:8

# create hsql user
RUN groupadd -r hsqldb && useradd -m -g hsqldb hsqldb
USER hsqldb

# copy hsql distribution
WORKDIR /home/hsqldb
RUN mkdir lib
COPY hsqldb.jar         lib/hsqldb.jar
COPY sqltool.jar        lib/sqltool.jar
COPY hsqldb.sh          hsqldb.sh
COPY server.properties  server.properties
COPY sqltool.rc         sqltool.rc

# expose database directory as a volume
RUN mkdir db
VOLUME db

# entry point is bash script; this allows us to do normal shutdown (SIGINT does an abrupt shutdown)
EXPOSE 9001
ENTRYPOINT ["./hsqldb.sh"]

