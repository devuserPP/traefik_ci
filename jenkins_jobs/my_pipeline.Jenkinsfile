// source
// https://https://gist.github.com/HarshadRanganathan/97feed7f91b7ae542c994393447f3db4
pipeline {
    // agent section specifies where the entire Pipeline will execute in the Jenkins environment
    // in my case I will use different agents on different stages
    agent none
    options {
        skipStagesAfterUnstable()
    }
   /**
     * stages contain one or more stage directives
     */
    stages {
        /**
         * the stage directive should contain a steps section, an optional agent section, or other stage-specific directives
         * all of the real work done by a Pipeline will be wrapped in one or more stage directives
         */
        stage("build and test the project") {
            agent {
        docker { 
            image 'maven:3-alpine'            
            }
        }
        stages {
            stage('Checkout') {
                steps {
                    //credentialsId:=go first to jenkins/credentials/ and create user and password for github
                    git branch: 'master', credentialsId: '62fef030-ae88-41f0-b02f-d7bbf8cabfa0', url: 'https://github.com/devuserPP/simple-java-maven-app.git'
                    }
            }

            stage('Build') {    
                steps {
                    sh 'mvn -B -DskipTests clean package'
                    // stash includes: 'target/*,jar', name: 'builtSources'
                    }
            post {
                always {
                    archiveArtifacts artifacts: 'target/*,jar', fingerprint: true
                    }
                }
            }
            stage('Test') {
                steps {
                sh 'mvn test'
                }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
                cleanup{
                    deleteDir()
               }
                }
            }
            }
        }




stage('Deploy') {
    agent {
        docker { 
            image 'openjdk:8-jre-alpine'         
            }
        }   
            steps {
                // unstash 'builtSources'
                sh 'java -jar target/*.jar'
            }
        }






            }


}        
