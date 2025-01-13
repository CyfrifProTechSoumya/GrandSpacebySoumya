# Use an official Java runtime as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the local machine to the container
COPY target/myapp.jar /app/myapp.jar  # Make sure the path matches where the .jar file is generated

# Expose the port that the application will run on (8080 is common for Spring Boot)
EXPOSE 8080

# Command to run the Java application
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
