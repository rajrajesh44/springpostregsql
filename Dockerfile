FROM maven:3.8.2-jdk-8-slim AS build
WORKDIR \spring-boot-jpa-postgresql
COPY . \spring-boot-jpa-postgresql
RUN mvn -f \spring-boot-jpa-postgresql/pom.xml clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8100
COPY --from=build \spring-boot-jpa-postgresql/*.jar app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]