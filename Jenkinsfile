pipeline {
    agent any

    environment {
        AWS_REGION = 'us-west-2'
        EKS_CLUSTER_NAME = 'your-eks-cluster'
        DOCKER_REGISTRY = 'your-aws-account-id.dkr.ecr.us-west-2.amazonaws.com'
        DOCKER_IMAGE_VOTE = "${DOCKER_REGISTRY}/vote-app"
        DOCKER_IMAGE_RESULT = "${DOCKER_REGISTRY}/result-app"
        DOCKER_IMAGE_WORKER = "${DOCKER_REGISTRY}/worker-app"
        DOCKER_IMAGE_REDIS = "${DOCKER_REGISTRY}/redis"
        DOCKER_IMAGE_POSTGRES = "${DOCKER_REGISTRY}/postgres"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/dockersamples/example-voting-app.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker build -t vote ./vote'
                    sh 'docker build -t result ./result'
                    sh 'docker build -t worker ./worker'
                    sh 'docker build -t redis ./redis'
                    sh 'docker build -t postgres ./postgres'
                }
            }
        }

        stage('Push Docker Images to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_REGISTRY'

                    sh 'docker tag vote:latest $DOCKER_IMAGE_VOTE:latest'
                    sh 'docker tag result:latest $DOCKER_IMAGE_RESULT:latest'
                    sh 'docker tag worker:latest $DOCKER_IMAGE_WORKER:latest'
                    sh 'docker tag redis:latest $DOCKER_IMAGE_REDIS:latest'
                    sh 'docker tag postgres:latest $DOCKER_IMAGE_POSTGRES:latest'

                    sh 'docker push $DOCKER_IMAGE_VOTE:latest'
                    sh 'docker push $DOCKER_IMAGE_RESULT:latest'
                    sh 'docker push $DOCKER_IMAGE_WORKER:latest'
                    sh 'docker push $DOCKER_IMAGE_REDIS:latest'
                    sh 'docker push $DOCKER_IMAGE_POSTGRES:latest'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh 'aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER_NAME'

                    sh 'kubectl apply -f k8s-specifications/'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment to EKS was successful!'
        }
        failure {
            echo 'Deployment to EKS failed.'
        }
    }
}
