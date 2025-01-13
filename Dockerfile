FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . /app

# Run Maven to build the project
RUN mvn clean package

# Expose the port that the application will run on
EXPOSE 7171

# Command to run the Java application
ENTRYPOINT ["java", "-jar", "/app/target/myapp.jar"]
