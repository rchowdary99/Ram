pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'uat', 'prod'],
            description: 'Select Environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Terraform Action'
        )
    }

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {

                    sh """
                    terraform init \
                    -backend-config=backend-${params.ENVIRONMENT}.conf \
                    -reconfigure
                    """
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression {
                    params.ACTION == 'plan' ||
                    params.ACTION == 'apply'
                }
            }

            steps {
                dir("environments/${params.ENVIRONMENT}") {

                    sh '''
                    terraform plan \
                    -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {

            when {
                expression {
                    params.ACTION == 'apply'
                }
            }

            steps {
                dir("environments/${params.ENVIRONMENT}") {

                    input message: "Apply changes to ${params.ENVIRONMENT} ?"

                    sh '''
                    terraform apply \
                    -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Terraform Destroy') {

            when {
                expression {
                    params.ACTION == 'destroy'
                }
            }

            steps {

                dir("environments/${params.ENVIRONMENT}") {

                    input message: "Destroy ${params.ENVIRONMENT} ?"

                    sh '''
                    terraform destroy \
                    -auto-approve
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
