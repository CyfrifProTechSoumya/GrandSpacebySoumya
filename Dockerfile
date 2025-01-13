# Use an OpenJDK base image
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY . /app

# Build the application using Maven
RUN mvn clean package

# Copy the built .jar file
COPY target/*.jar /app/myapp.jar

# Expose the port that the application will run on
EXPOSE 7171

# Command to run the Java application
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
