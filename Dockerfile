# Stage 2: Run the application
FROM openjdk:17-alpine
WORKDIR /app
COPY target/*.jar ./aws-0.0.1-SNAPSHOT.jar
EXPOSE 8082
CMD ["java", "-jar", "aws-0.0.1-SNAPSHOT.jar"]
