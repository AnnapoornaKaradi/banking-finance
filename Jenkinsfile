pipeline {
	agent any 
	tools {
		maven 'M2_HOME'
		terraform 'Terraform-1.4.2'

	      }
		
	environment{
			AWS_ACCESS_KEY_ID= '$(access_key)'
			AWS_SECRET_KEY_ID= '$(secret_key)'
		  }
	stages {

		stage("Pull the Project from GitHub"){
		steps{
			git 'https://github.com/AnnapoornaKaradi/banking-finance.git'
		     }
		  }

		stage('Build the application'){
		steps{
			echo 'cleaning..compiling..testing..packaging..'
			sh 'mvn -X clean install'
		     }
		  }	
   	
		stage('Containerize the application'){
		steps{
			echo 'Creating a docker image'
			sh 'docker build -t annapoornakaradi/banking_finance .'
		    }
		} 
		stage('Pushing the image to dockerhub'){
		steps{
			 withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
			 sh 'docker push annapoornakaradi/banking_finance'

             }
	    } 
	  }
		stage('Terraform init'){
		steps{
			sh 'terraform init'
			}
		}

		stage('Terraform fmt'){
		steps{
			sh 'terraform fmt'
			}
		}

		stage('Terraform validate'){
		steps{
			sh 'terraform validate'
			}
		}
		

		stage('Terraform apply'){
		steps{
			sh 'terraform apply -auto-approve'
			sleep 20
			}
		}
		
		stage('deploy to ansible server'){
		steps{
		ansiblePlaybook become: true, credentialsId: 'ansible-key',  installation: 'ansible', disableHostKeyChecking: true, inventory: 'deployserver.inv', playbook:'ansible-playbook.yml'
	}
	}
	}
}
