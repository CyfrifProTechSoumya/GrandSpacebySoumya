pipeline {
    agent any

    environment {
        IMAGE_NAME = "abcgrand"            // Name of your Docker image
        IMAGE_TAG = "latest"                 // Tag the image with the Git commit hash
        // DOCKER_REGISTRY = "docker.io"              // Docker registry (Docker Hub in this case)
        // DOCKER_REPO = "your-username"              // Docker Hub username (not used now)
        DOCKER_IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}" // Full Docker image name
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository from Git
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    // Build your Java application with Maven
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using Dockerfile
                    sh '''
                        docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                script {
                    // If you're using Docker Compose, you can deploy the app like this:
                    sh '''
                        docker-compose -f docker-compose.yml up -d
                    '''

                    // Alternatively, you can deploy using a simple docker run command:
                    // sh 'docker run -d -p 8080:8080 --name your-container-name ${DOCKER_IMAGE}'
                }
            }
        }
    }
}
