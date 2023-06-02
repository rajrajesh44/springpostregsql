FROM maven:3.8.3-openjdk-17 as builder
WORKDIR /spring-boot-jpa-postgresql
COPY pom.xml .
COPY src ./src
RUN mvn -f /spring-boot-jpa-postgresql/pom.xml clean package



FROM openjdk:17.0-jdk-slim
COPY --from=builder /spring-boot-jpa-postgresql/*.jar app.jar
ENTRYPOINT ["java" , "-Djava.security.egd=file:/dev/./urandom", "-jar" /app.jar" ]