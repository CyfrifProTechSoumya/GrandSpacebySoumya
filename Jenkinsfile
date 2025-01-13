pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'  // Path to your docker-compose file
    }
    stages {
        stage('Checkout') {
            steps {
                // Ensure you're pulling from the correct branch
                git branch: 'main', url: 'https://github.com/CyfrifProTechSoumya/GrandSpacebySoumya.git'
            }
        }
        stage('Build Java Application (Gradle)') {
            steps {
                script {
                    // Ensure gradle wrapper is executable
                    sh 'chmod +x gradlew'
                    
                    // Build the Java application and create the .jar file using Gradle
                    // Ensure it creates the .jar file before proceeding
                    sh './gradlew clean build'  // Clean build to ensure latest build
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for the Java app
                    sh 'docker-compose -f "${DOCKER_COMPOSE_FILE}" build grandspace-java-app'
                }
            }
        }
        stage('Start Services') {
            steps {
                script {
                    // Start up the services using docker-compose
                    sh 'docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d'
                }
            }
        }
        stage('Test Application') {
            steps {
                script {
                    // Test if the app is running by hitting the reverse proxy via curl
                    // If Nginx forwards the request to the Java app, this should work
                    sh 'curl -f http://localhost:7474'  // Test Nginx's proxy to Java app
                }
            }
        }
    }
    post {
        always {
            // Clean up Docker resources after pipeline runs
            cleanWs()
        }
    }
}
