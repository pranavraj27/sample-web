
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
            agent{
                docker{
                    image 'maven'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                sh "mvn clean package"
                
            }
           
        }
        stage("Docker"){
            steps{
                script{
                    sh "docker build . -t pranav27/devops-image:Docker_tag"
                    withCredentials([string(credentialsId: '', variable: 'docker_password')]) {
                      sh "docker login -u pranav27 -p $docker_password"
                       sh "docker push pranav27/devops-image:Docker_tag"
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
