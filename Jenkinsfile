pipeline{
    agent any

    environment{
        PATH ="/opt/maven/bin:$PATH"
       
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
                sh "mv target/*.war target/myweb.war"
                
            }
           
        }
        stage("Docker Build"){
            steps{
                
                sh "docker build . -t pranav27/devops-image:${Docker_tag} "
            
            }
        }
        stage("DockerHub Push"){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u pranav27 -p ${dockerHubPwd}"
                   }
                 sh "docker push pranav27/devops-image:${Docker_tag} "
            
            }
        }
   }
}
def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout:true
    return tag
}
