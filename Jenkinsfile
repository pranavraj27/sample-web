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
         stage("Deploy dev"){
          steps{
           sshagent(['tomcat']) {
                sh """
                     scp -o StrictHostKeyChecking=no target/myweb.war ec2-user@13.126.198.176:/opt/tomcat8/webapps/
                     ssh  ec2-user@13.126.198.176 /opt/tomcat8/bin/shutdown.sh
                     ssh  ec2-user@13.126.198.176 /opt/tomcat8/bin/startup.sh
                """
            }
           
          }
    
      }
   }
}
