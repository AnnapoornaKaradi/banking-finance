pipeline {
	agent any 
	tools {
		maven 'M2_HOME'

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
   	
		stage('Publish HTML Report'){
		steps{
		      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Project2_BankingFinance/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
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
			sleep 10
			}
		}
		
		stage('deploy to ansible server'){
		steps{
		ansiblePlaybook credentialsId: 'Test-Server',  installation: 'ansible', disableHostKeyChecking: true, inventory: '/var/lib/jenkins/workspace/Project2_BankingFinance/deployserver.inv', playbook:'/var/lib/jenkins/workspace/Project2_BankingFinance/ansible-playbook.yml'
	}
	}
	}
}
