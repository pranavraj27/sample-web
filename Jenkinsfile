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
                sh "mv target/*.jar  target/Mywebapp.jar"
            }
           
        }
    }
}
