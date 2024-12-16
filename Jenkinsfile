pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('docker') // Replace 'docker' with your Jenkins credentials ID
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

        // stage('Deploy') {
        //     steps {
        //         sshagent(['jenkins-k8s-ssh-key']) { // Replace 'jenkins-k8s-ssh-key' with your SSH credentials ID
        //             sh '''
        //                 echo "Deployment step via SSH"
        //                 # Add your deployment commands here, e.g., kubectl apply -f deployment.yml
        //             '''
        //         }
        //     }
        // }
    }
}
