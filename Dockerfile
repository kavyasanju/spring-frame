FROM jboss/wildfly:11.0.0.Final
COPY target/petclinic.war /opt/jboss/wildfly/standalone/deployments/petclinic.war
ENV JDBC_PASSWORD=petclinic \
    DB_SCRIPT=mysql \
    JDBC_DRIVER_CLASS_NAME=com.mysql.jdbc.Driver \
    JPA_DATABASE=MYSQL \
    JDBC_USERNAME=root \
    JDBC_URL=jdbc:mysql://fefewfewfewffewfew:3306/petclinic
