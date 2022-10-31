pipeline {
    agent none
    stages{
        stage('Build image') {
            agent any
            steps {
              sh 'oc start-build petclinic-build --follow'
            }
        }
    }
}
