pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'  // Path to your docker-compose file
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -la'  // List files to verify pom.xml exists
            }
        }
        stage('Build Java Application (Maven)') {
            steps {
                script {
                    sh '''#!/bin/bash
                    mvn clean package  # Clean and build the Maven project
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''#!/bin/bash
                    docker-compose -f ${DOCKER_COMPOSE_FILE} build grandspace-java-app
                    '''
                }
            }
        }
        stage('Start Services') {
            steps {
                script {
                    sh '''#!/bin/bash
                    docker-compose -f ${DOCKER_COMPOSE_FILE} up -d
                    '''
                }
            }
        }
        stage('Test Application') {
            steps {
                script {
                    // Add a sleep to give time for the containers to fully start
                    sh '''#!/bin/bash
                    echo "Waiting for containers to start..."
                    sleep 30  # Wait for services to start
                    
                    echo "Testing Nginx Reverse Proxy..."
                    // Test for Windows/Mac using host.docker.internal
                    // Test for Linux using the Docker gateway IP
                    if [[ "$(uname)" == "Darwin" || "$(uname)" == "Linux" ]]; then
                        curl -f http://host.docker.internal:7474 || curl -f http://172.17.0.1:7474  # Linux fallback
                    else
                        curl -f http://localhost:7474  # Windows/Mac fallback
                    fi
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
