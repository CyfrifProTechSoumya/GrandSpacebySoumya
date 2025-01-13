# Use an official OpenJDK runtime as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Install Maven and other dependencies
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://downloads.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz && \
    tar -xvzf apache-maven-3.8.4-bin.tar.gz && \
    mv apache-maven-3.8.4 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin/mvn && \
    apt-get clean

# Set MAVEN_HOME environment variable
ENV MAVEN_HOME=/opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Copy the pom.xml and source code to the container
COPY . /app

# Run Maven to build the project and create the .jar file
RUN mvn clean package

# Copy the .jar file from the target directory to the container
COPY target/*.jar /app/myapp.jar  # Ensure the correct .jar file is copied

# Expose the port that the application will run on (8080 is common for Spring Boot)
EXPOSE 7171

# Command to run the Java application
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
