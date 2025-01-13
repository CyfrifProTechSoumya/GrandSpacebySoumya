# Use an official Java runtime as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the .jar file from the local machine to the container
COPY target/*.jar /app/myapp.jar  # Ensure the correct .jar file is copied

# Expose the port that the application will run on (8080 is common for Spring Boot)
EXPOSE 8080

# Command to run the Java application
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
