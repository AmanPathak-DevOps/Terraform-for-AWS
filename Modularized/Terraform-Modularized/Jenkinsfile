properties([parameters([choice(choices: ['Lambda-Function', 'Cloudwatch-Monitoring', 'IAM-Roles', 'EC2-Instance', 'S3-Bucket', 'Glue-Jobs', 'DynamoDB', 'SNS-Topic', 'VPC-Networking'], name: 'Module_Name'), string(defaultValue: 'dev.tfvars', name: 'File_Name'), string(defaultValue: 'Terraform-Module-Deployment', name: 'Pipeline'), choice(choices: ['plan', 'apply', 'destroy'], name: 'Terraform_Action')])])
pipeline {
    agent any
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'master', url: 'https://github.com/AmanPathak-DevOps/Terraform-for-AWS.git'
            }
        }
        stage('Init') {
            steps {
                echo "Enter File Name ${params.Module_Name}"
                echo "Pipeline Name ${params.Pipeline}"
                withAWS(credentials: 'jenkins-environment', region: 'us-east-1') {
                sh 'terraform -chdir=Modularized/Terraform-Modularized/${Module_Name}/ init --lock=false'
                }
            }
        }
        stage('Action') {
            steps {
                echo "${params.Terraform_Action}"
                withAWS(credentials: 'jenkins-environment', region: 'us-east-1') {
                sh 'terraform get -update'   
                sh 'cp Modularized/Terraform-Modularized/variables.tf Modularized/Terraform-Modularized/${Module_Name}/'
                script {    
                        if (params.Terraform_Action == 'plan') {
                            sh 'terraform -chdir=Modularized/Terraform-Modularized/${Module_Name}/ plan -var-file=/var/lib/jenkins/jobs/${Pipeline}/workspace/Modularized/Terraform-Modularized/${File_Name} --lock=false'
                        }   else if (params.Terraform_Action == 'apply') {
                            sh 'terraform -chdir=Modularized/Terraform-Modularized/${Module_Name}/ apply -auto-approve -var-file=/var/lib/jenkins/jobs/${Pipeline}/workspace/Modularized/Terraform-Modularized/${File_Name} --lock=false'
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh 'terraform -chdir=Modularized/Terraform-Modularized/${Module_Name}/ destroy -auto-approve -var-file=/var/lib/jenkins/jobs/${Pipeline}/workspace/Modularized/Terraform-Modularized/${File_Name} --lock=false'
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
            }
        }
    }
}
