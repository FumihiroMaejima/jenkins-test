pipeline {
  agent {
    docker {
      image 'node:16.14-alpine'
    }
  }

  triggers { pollSCM('H/2 * * * *') }

  stages {
    stage('Yarn Build') {
      steps {
        sh 'yarn install && yarn run build'
      }
    }
  }

  post {
    success {
        echo 'I succeeeded!'
    }
    unstable {
        echo 'I am unstable :/'
    }
    failure {
        echo 'I failed :('
    }
  }
}
