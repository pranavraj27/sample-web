
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
        stage('ansible playbook'){
			steps{
		              sshagent(['kubernetes_server']) {
                                 script{
				    sh '''final_tag=$(echo $Docker_tag | tr -d ' ')
				     echo ${final_tag}test
				     sed -i "s/docker_tag/$final_tag/g"  deployment.yaml
				     '''
				    ansiblePlaybook become: true, installation: 'ansible', inventory: 'hosts', playbook: 'ansible.yaml'
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
