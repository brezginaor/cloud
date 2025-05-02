private void loadVarsFromFile(String path) {
    def file = readFile(path)
        .replaceAll("(?m)^\\s*\\r?\\n", "")  // skip empty line
        .replaceAll("(?m)^#[^\\n]*\\r?\\n", "")  // skip commented lines
    file.split('\n').each { envLine ->
        def (key, value) = envLine.tokenize('=')
        env."${key}" = "${value.trim().replaceAll('^\"|\"$', '')}"
    }
}

pipeline {
    agent { label 'brezgina' }

    stages {
        stage('Prepare CurrencyConverterBot for Deploy') {
            parallel {
                stage('Build CurrencyConverterBot') {
                    steps {
                        build(job: 'brezgia-build2')
                    }
                }
                stage('Prepare infrastructure for CurrencyConverterBot') {
                    steps {
                        build(job: 'brezgina-terraform-ansible')
                        loadVarsFromFile('/home/ubuntu/myenv')
                    }
                }
            }
        }
        stage('Deploy CurrencyConverterBot') {    
            steps {
                build(job: 'brezgina-deploy', parameters: [string(name: 'SERVER_ADDRESS', value: env.DEPLOYMENT_SERVER_IP)])
            }
        }
    }
}
