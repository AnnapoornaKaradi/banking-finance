pipeline {
	agent any 
	tools {
		maven 'M2_HOME'
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
		      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/banking-finance/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
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
	
	     stage('Configure and deploy to the test-server'){
		steps{
			ansiblePlaybook become: true, credentialsId: 'ansible-key',  installation: 'ansible', disableHostKeyChecking: true, inventory: '/etc/ansible/hosts', playbook:'/var/lib/jenkins/workspace/Project2_BankingFinance/ansible-playbook.yml'
		     }
		    }
	}
}
