pipeline {
    agent any
    environment {
        TF_VAR_region         = 'ap-south-1'
    }
    stages {

        stage('AWS CLI Setup') {
            steps {
                // Accessing access key and secret key from Jenkins Credentials
              withCredentials([usernamePassword(credentialsId: 'AWS_CREDENTIALS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    				sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
    				sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
		}
            }
        }

        stage('Checkout Code') {
            steps {
                // Checkout the code from your repository (GitHub, Bitbucket, etc.)
git branch: 'main', url: 'https://github.com/its-pushpaks-world/Terraform-basics.git'
            }
        }
 
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }
 
        stage('Terraform Plan') {
            steps {
                // Plan the changes
                sh 'terraform plan -out=tfplan'
            }
        }
 
        stage('Terraform Apply') {
            steps {
                script {
                    // Try to apply changes and check if it fails
                    try {
                        sh 'terraform apply -auto-approve tfplan'
                    } catch (Exception e) {
                        // If apply fails, trigger rollback
                        currentBuild.result = 'FAILURE'
                        error("Deployment failed. Triggering rollback.")
                    }
                }
            }
        }
 
        stage('Rollback') {
            when {
                expression { currentBuild.result == 'FAILURE' }
            }
            steps {
                script {
                    // Retrieve the last stable version and apply it
                    echo "Rolling back to the previous stable state"
                    sh 'terraform state pull > previous.tfstate'
                    sh 'terraform apply -auto-approve -state=previous.tfstate'
                }
            }
        }
    }
 
    post {
        always {
            // Clean up temporary files
            cleanWs()
        }
    }
}
