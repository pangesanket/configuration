SHOPPING APPLICATION
pipeline {
    agent any
    
    tools{
        jdk 'jdk'
        maven 'maven3'
    }

    stages {
        stage('SCM checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/jaiswaladi246/Ekart.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests=true'
            }
        }
        stage('Docker push') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                    sh 'docker build -t shopping:latest -f docker/Dockerfile .'
                    sh 'docker tag shopping:latest pangesanket55/shopping:${BUILD_NUMBER}'
                    sh 'docker push pangesanket55/shopping:${BUILD_NUMBER}'
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker run -d --name shopping -p 8070:8070 pangesanket55/shopping:${BUILD_NUMBER}'
                    }
                }
            }
        }
    }
}


#############################################################################################################################################3

DEVOPS LEARNING
pipeline {
    agent any
    
    tools{
        jdk 'jdk'
        maven 'maven3'
    }

    stages {
        stage('SCM checkout') {
            steps {
                git credentialsId: 'git_cred', url: 'https://github.com/pangesanket/devops.learning.01.git'
            }
        }
         stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
         stage('deploy') {
            steps {
                script{
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'tomcat', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: 'target/', sourceFiles: 'target/DevOps-Learning02.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                }
            }
        }
    }
}
########################################################################################################################################################

NODEJS
pipeline {
    agent any
    
    tools{
        nodejs 'nodejs'
    }

    stages {
        stage('SCM checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/pangesanket/NodeJS.git'
            }
        }
        stage('build') {
            steps {
                sh 'npm install -g serve'
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t demonodejs  . "
                        sh "docker tag demonodejs pangesanket55/nodejs:${BUILD_NUMBER} "
                        sh "docker push pangesanket55/nodejs:${BUILD_NUMBER} "
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker run -d --name nodejs -p 3000:3000 pangesanket55/nodejs:latest'
                    }
                }
            }
        }
    }
}

#################################################################################################################################

DEMO CI-CD

pipeline {
    agent any
    
    tools{
        jdk 'jdk'
        maven 'maven3'
    }

    stages {
        stage('SCM checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/pangesanket/jenkins-cicd-pipeline.git'
            }
        }
         stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
         stage('deploy') {
            steps {
                script{
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'tomcat', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: 'target/', sourceFiles: 'target/spring-boot-jenkins-pipeline.jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                }
            }
        }
    }
}
###########################################################################################################################################################

TRIGGER PIPELINE FOR DEPLOYMENT 

pipeline {
    agent any
    stages {
        stage('Deploy Application') {
            steps {
                script {
                    sh '''
                        #!/bin/bash
                        DOCKER_IMAGE="yourdockerhubusername/yourimagename:latest"
                        CONTAINER_NAME="your_container_name"
                        PORT=80
                        
                        echo "Pulling latest image from Docker Hub..."
                        docker pull $DOCKER_IMAGE
                        
                        if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
                            echo "Stopping existing container..."
                            docker stop $CONTAINER_NAME
                            echo "Removing existing container..."
                            docker rm $CONTAINER_NAME
                        fi
                        
                        echo "Running new container..."
                        docker run -d --name $CONTAINER_NAME -p $PORT:80 $DOCKER_IMAGE
                        
                        echo "Deployment complete!"
                    '''
                }
            }
        }
    }
}

##################################################################################################################3

BANKAPP PROJECT

pipeline {
    agent any
    
    tools{
        jdk 'jdk17'
        maven 'maven3'
    }

    stages {
        stage('SCM checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/jaiswaladi246/Multi-Tier-With-Database.git'
            }
        }
        stage('compile') {
            steps {
                sh "mvn compile"
            }
        }
        stage('test') {
            steps {
                sh 'mvn test -DskipTests=true'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package -DskipTests=true'
            }
        }
        stage('build docker image') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh 'docker build -t pangesanket55/bankapp:${BUILD_NUMBER} .'
                        sh 'docker tag pangesanket55/bankapp:${BUILD_NUMBER} pangesanket55/bankapp:latest'
                    }
                }
            }
        }    
        stage('build push image') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh 'docker push pangesanket55/bankapp:latest'
                    }
                }
                
            }
        }
        stage('k8s-deploy') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://EDAAE6146B7D210666010687B167683D.gr7.ap-south-1.eks.amazonaws.com') {
                    sh 'kubectl apply -f ds.yml -n webapps'
                    sleep 30
                }
            }
        }
        stage('verify-deploy') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://EDAAE6146B7D210666010687B167683D.gr7.ap-south-1.eks.amazonaws.com') {
                    sh 'kubectl get pods -n webapps'
                    sh 'kubectl get svc -n webapps'
                }
            }
        }
    }
}


