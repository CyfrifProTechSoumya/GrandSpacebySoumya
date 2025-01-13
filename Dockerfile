# Stage 1: Build the application using Maven
FROM maven:3.8.4-jdk-11 as builder

# Set working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src/ ./src/

# Build the application using Maven
RUN mvn clean install

# Stage 2: Run the application with OpenJDK
FROM openjdk:11-jre-slim

# Set working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=builder /app/target/your-application.jar /app/your-application.jar

# Expose port 8080 for the app
EXPOSE 5050

# Run the application
CMD ["java", "-jar", "/app/your-application.jar"]
