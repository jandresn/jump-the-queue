pipeline {
    agent any
    environment {
        PROJECT_ROOT = 'angular'
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
                        branches: [[name: '*/master']], 
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

        // stage('Install Dependencies') {
        //     steps {
        //         script {
        //             // Instala las dependencias del proyecto Angular
        //             sh "cd ${PROJECT_ROOT}; npm install --force"
        //         }
        //     }
        // }

        // stage('Build') {
        //     steps {
        //         script {
        //             // Realiza la construcción del proyecto Angular
        //             sh "cd ${PROJECT_ROOT};npm run build"
        //         }
        //     }
        // }

        // stage('Test') {
        //     steps {
        //         script {
        //             // Ejecuta las pruebas del proyecto Angular
        //             sh " cd ${PROJECT_ROOT};npm run test"
        //         }
        //     }
        // }

        // stage('Lint') {
        //     steps {
        //         script {
        //             // Ejecuta el linting para el proyecto Angular
        //             sh "cd ${PROJECT_ROOT};npm run lint"
        //         }
        //     }
        // }

        stage('SonarQube Analysis') {
            steps {
                script {
                   // Configura la herramienta de SonarQube Scanner
                    def scannerHome = tool name: 'sonarqube', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                     withCredentials([string(credentialsId: 'sonartoken', variable: 'SONAR_TOKEN')]) {
                        withSonarQubeEnv('sonarqube') {
                            // Utiliza el escáner de SonarQube con el token de acceso
                            sh "cd ${PROJECT_ROOT};${scannerHome}/bin/sonar-scanner -Dsonar.login=${SONAR_TOKEN}"
                        }
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
