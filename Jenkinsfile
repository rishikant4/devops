pipeline {
	agent any
	environment {
	def git_branch = 'main'
	def git_url = 'https://github.com/avidere/helloworldtest.git'
	
	def mvntest = 'mvn test '
	def mvnpackage = 'mvn clean install'
	}
	stages {
	stage('Git Checkout') {
	steps {
	script {
	git branch: "${git_branch}", url: "${git_url}"
	echo 'Git Checkout Completed'
	}
	}
	} 
	stage('Maven Build') {
	steps {
	sh "${env.mvnpackage}"
	echo 'Maven Build Completed'
	}
	}
