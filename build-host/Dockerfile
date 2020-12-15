FROM tomcat:8.0-alpine
LABEL maintainer="Praveen"

ADD ./target/SimpleServlet-1.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
