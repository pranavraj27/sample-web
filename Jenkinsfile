
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
        stage("Deploy to K8s"){
            steps{
               
                sh "chmod +x changeTag.sh" 
                sh "./changeTag.sh ${Docker_tag}"
                sshagent(['kops-machine']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml sample-web-deployment.yml ec2-user@44.205.255.26:/home/ec2-user/"  
                    script{
                        try{
                            ssh "ec2-user@54.173.153.3 kubectl apply -f ."
                        }
                        catch(error){
                            ssh "ec2-user@54.173.153.3 kubectl create -f ."
                        }
                        
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
