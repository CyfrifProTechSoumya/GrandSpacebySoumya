pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'  // Path to your docker-compose file
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/CyfrifProTechSoumya/GrandSpacebySoumya.git'  // Replace with your repo URL
            }
        }
        stage('Build Java Application (Gradle)') {
            steps {
                script {
                    // Build the Java application and create the .jar file using Gradle
                    sh './gradlew build'  // Assuming Gradle wrapper is present
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for the Java app
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} build grandspace-java-app'  // Correct service name
                }
            }
        }
        stage('Start Services') {
            steps {
                script {
                    // Start up the services using docker-compose
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }
        stage('Test Application') {
            steps {
                script {
                    // Test if the app is running by hitting the reverse proxy via curl
                    sh 'curl -f http://88.222.241.45/:7474'  // Check if Nginx is forwarding traffic
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
