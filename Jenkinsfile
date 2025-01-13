pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'  // Path to your docker-compose file
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                // List files to verify pom.xml exists
                sh 'ls -la'
            }
        }
        stage('Build Java Application (Maven)') {
            steps {
                script {
                    // Build the Java application and create the .jar file using Maven
                    // Ensure it creates the .jar file before proceeding
                    sh '''#!/bin/bash
                    mvn clean package  # Clean and build the Maven project
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for the Java app
                    sh '''#!/bin/bash
                    docker-compose -f ${DOCKER_COMPOSE_FILE} build grandspace-java-app
                    '''
                }
            }
        }
        stage('Start Services') {
            steps {
                script {
                    // Start up the services using docker-compose
                    sh '''#!/bin/bash
                    docker-compose -f ${DOCKER_COMPOSE_FILE} up -d
                    '''
                }
            }
        }
        stage('Test Application') {
            steps {
                script {
                    // Test if the app is running by hitting the reverse proxy via curl
                    // If Nginx forwards the request to the Java app, this should work
                    sh '''#!/bin/bash
                    curl -f http://88.222.241.45:7474  # Test Nginx's proxy to Java app
                    '''
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
