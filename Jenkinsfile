
pipeline{
    agent any

    environment{
        PATH ="/opt/maven/bin:$PATH"
        Docker_tag = getDockerTag()
    }
    stages{
        stage("Git Checkout"){
            steps{
                git 'https://github.com/pranavraj27/sample-web.git'
            }
           
        }
        stage("Maven Build"){
          
            steps{
                sh "mvn clean package"
                
            }
           
        }
        stage("Docker"){
            steps{
                script{
                    sh "docker build . -t pranav27/devops-image:${Docker_tag}"
                    withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
                        sh "docker login -u pranav27 -p ${docker_password}"
                        sh "docker push pranav27/devops-image:${Docker_tag}'
                   }


                    }
            }
        }
    }
}
def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout:true
    return tag
}
