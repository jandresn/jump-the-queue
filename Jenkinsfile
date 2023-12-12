pipeline {
    agent any
    
    environment {
        // Define las variables de entorno necesarias
        NODE_HOME = tool 'NodeJS'
        PATH = "$NODE_HOME/bin:$PATH"
    }
    tools {
    nodejs "NodeJs"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clona el repositorio de GitHub
                    checkout([$class: 'GitSCM', 
                        branches: [[name: '*/main']], 
                        doGenerateSubmoduleConfigurations: false, 
                        extensions: [
                            [$class: 'CleanBeforeCheckout'],
                            [$class: 'CheckoutOption', timeout: 60],
                            [$class: 'CloneOption', noTags: false, shallow: true, timeout: 2],
                            [$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: true, recursiveSubmodules: true, reference: '', trackingSubmodules: false]
                        ], 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[url: 'https://github.com/jandresn/jump-the-queue.git']]
                    ])
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Instala las dependencias del proyecto Angular
                    sh 'npm install'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Realiza la construcción del proyecto Angular
                    sh 'npm run build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Ejecuta las pruebas del proyecto Angular
                    sh 'npm run test'
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    // Ejecuta el linting para el proyecto Angular
                    sh 'npm run lint'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Ejecuta el análisis de SonarQube para Angular
                    withSonarQubeEnv('SonarQube Server') {
                        sh 'sonar-scanner'
                    }
                }
            }
        }
    }

    post {
        success {
            // Acciones a realizar después de que el pipeline sea exitoso
            echo 'Pipeline successful!'
        }
        failure {
            // Acciones a realizar en caso de fallo del pipeline
            echo 'Pipeline failed!'
        }
    }
}
