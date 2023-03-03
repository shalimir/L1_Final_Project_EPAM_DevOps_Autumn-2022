pipeline {
    agent any
    stages {
        stage('build/push docker image') {
            when {
                branch pattern: "PR-.*|develop|master", comparator: "REGEXP"
            }
            steps {
                ansiblePlaybook(
                playbook: 'ansible/ci-dev-build-push.yml',
                extras: '-e tag=$GIT_COMMIT')
            }
        }

        stage('CI env deploy') {
            when {
                branch pattern: "develop|master", comparator: "REGEXP"
            }
            steps {
                ansiblePlaybook(
                playbook: 'ansible/ci-dev-deploy.yml',
                inventory: 'ansible/inventory.txt',
                disableHostKeyChecking: true,
                credentialsId: '097c41ec-1f22-49bf-8245-f22e3c88e014',
                extras: '-e tag=$GIT_COMMIT -e host_port=81 -e env=ci')
            }
        }

    }
}