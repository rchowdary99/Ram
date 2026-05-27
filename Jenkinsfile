pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev','uat','prod'],
            description: 'Select Environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan','apply','destroy'],
            description: 'Terraform Action'
        )
    }

    environment {
        AWS_REGION='us-east-1'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Version') {
            steps {
                bat 'terraform --version'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {

                    bat """
                    terraform init ^
                    -backend-config=backend-${params.ENVIRONMENT}.conf ^
                    -reconfigure
                    """
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    bat 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }
    }
}
