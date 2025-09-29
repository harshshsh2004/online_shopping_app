pipeline {
    agent any

    environment {
        IMAGE_NAME = 'online_shop:latest'
        CONTAINER_NAME = 'online_shop-container'
    }

    stages {

        stage('Clean Workspace') {
            steps {
                echo "Cleaning workspace..."
                deleteDir() // remove all old files from workspace
            }
        }

        stage('Clone Git Repo') {
            steps {
                echo "Cloning project from GitHub..."
                git branch: 'main', url: 'https://github.com/harshshsh2004/online_shopping_app.git'
            }
        }

        stage('Configure Jenkins Server') {
            steps {
                echo "Setting permissions..."
                sh ''' chmod 666 /var/run/docker.sock
                   '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Stopping and removing existing container (if any)..."
                sh "docker rm -f $CONTAINER_NAME || true"

                echo "Running new Docker container..."
                sh "docker run -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE_NAME"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs for errors."
        }
    }
}