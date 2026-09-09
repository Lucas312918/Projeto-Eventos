# Multi-stage Dockerfile for building and running the Spring Boot application

### Build stage
FROM gradle:8.10.2-jdk17 AS builder
WORKDIR /home/gradle/project

# The repository also contains the frontend; the Gradle project lives in backend/.
COPY --chown=gradle:gradle backend/ /home/gradle/project/
RUN chmod +x gradlew && ./gradlew bootJar --no-daemon

### Run stage
FROM eclipse-temurin:17-jre-jammy
RUN apt-get update \
    && apt-get install --no-install-recommends -y curl \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /home/gradle/project/build/libs/*.jar /app/app.jar
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
