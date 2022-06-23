
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
                    sh "scp -o StrictHostKeyChecking=no services.yml sample-web-pod.yml ec2-user@18.206.56.139:/home/ec2-user/"  
                    script{
                        try{
                            ssh "ec2-user@18.206.56.139 kubectl apply -f ."
                        }
                        catch(error){
                            ssh "ec2-user@18.206.56.139 kubectl create -f ."
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
