pipeline {
    agent any
    environment {
        REPO = 'https://github.com/ukrsite/kbot'
        BRANCH = 'main'
    }
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS', defaultValue: 'linux')
        choice(name: 'ARCH', choices: ['amd64', 'arm', 'arm64'], description: 'Pick Architecture', defaultValue: 'amd64')
    }
    stages {
        stage('clone') {
            steps {
                echo 'clone the repository'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage('buid') {
            steps {
                echo "Build for platform ${params.OS} ${params.ARCH}"
                sh 'make build TARGETOS=${params.OS} TARGETARCH=${params.ARCH}'
            }
        }
    }
}
