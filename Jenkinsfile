pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('docker') // Your DockerHub credentials
    }
    stages {
        stage('Docker Image Build') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t abed218/cw2-server:1.0 .'
                echo 'Docker Image built successfully!'
            }
        }
        stage('Test Docker Image') {
            steps {
                echo 'Testing Docker Image...'
                sh '''
                docker rm -f test-container || true
                docker image inspect abed218/cw2-server:1.0
                docker run --name test-container -p 8081:8080 -d abed218/cw2-server:1.0
                docker ps
                docker stop test-container
                docker rm test-container
                '''
            }
        }
        stage('DockerHub Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
            }
        }
        stage('DockerHub Image Push') {
            steps {
                sh 'docker push abed218/cw2-server:1.0'
            }
        }
        stage('Update Kubernetes Deployment') {
            steps {
                echo 'Updating Kubernetes Deployment...'
                sshagent(['jenkins-ssh-key']) { // Use your Jenkins SSH key for connecting to the Kubernetes server
                    sh '''
                    kubectl set image deployment/cw2-server-deployment cw2-server-container=abed218/cw2-server:1.0 --record
                    kubectl rollout status deployment/cw2-server-deployment
                    '''
                }
            }
        }
    }
}

