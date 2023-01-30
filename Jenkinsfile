pipeline {
	agent any
	environment {
	PROJECT_ID = 'calm-seeker-375715'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'My First Project'
		
	def git_branch = 'master'
	def git_url = 'https://github.com/rishikant4/devops.git'
	
	def mvntest = 'mvn test '
	def mvnpackage = 'mvn clean install'
	
	def utest_url = 'target/surefire-reports/**/*.xml'
		
	def sonar_cred = 'sonar'
        def code_analysis = 'mvn clean install sonar:sonar'
	def dcoker_cred='docker'
		
	def nex_cred = 'nexus'
        def grp_ID = 'com.example'
        def nex_url = '15.207.222.241:8081'
        def nex_ver = 'nexus3'
        def proto = 'http'
	}
	stages {
	stage('Github Checkout') {
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
	stage('Unit Test & Reports Publishing') {
            steps {
                script {
                    sh "${env.mvntest}"
                    echo 'Unit Testing Completed'
                }
            }
	post {
                success {
                        junit "$utest_url"
                        jacoco()
                }
            }
}
		/* stage('Static code scan & Quality Gate Status') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: "${sonar_cred}") {
                        sh "${code_analysis}"
                    }
                    waitForQualityGate abortPipeline: true, credentialsId: "${sonar_cred}"
                }
            }
        } 
		stage('Upload Artifact to nexus') {
            steps {
                script {
                    
                    def mavenpom = readMavenPom file: 'pom.xml'
                  
                    nexusArtifactUploader artifacts: [
                    [
                        artifactId: 'demo',
                        classifier: '',
                        file: "target/demo-${mavenpom.version}.jar",
                        type: 'jar'
                    ]
                ],
                    credentialsId: "${env.nex_cred}",
                    groupId: "${env.grp_ID}",
                    nexusUrl: "${env.nex_url}",
                    nexusVersion: "${env.nex_ver}",
                    protocol: "${env.proto}",
                    repository: 'nex_repo',
                    version: "${mavenpom.version}"
                    echo 'Artifact uploaded to nexus repository'
                }
            }
        } */
		/*stage('Pull Artifact and Deploy on tomcat server using Ansible'){
            steps{
                 sshagent(['ansible']) {
                    script{
                    sh 'ansiblePlaybook credentialsId: 'ansible', installation: 'ansible', inventory: 'inventory.yml', playbook: 'deploy.yml', sudo: true, sudoUser: 'jenkins''
                    }
                 }
            }
        } */
		stage('Docker Image Build'){
			steps{
				script{
					sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
					sh 'docker image tag $JOB_NAME:v1.$BUILD_ID rishi236/$JOB_NAME:v1.$BUILD_ID'
					sh 'docker image tag $JOB_NAME:v1.$BUILD_ID rishi236/$JOB_NAME:latest'
				}
			}
		}
		stage('Push Image to the DockerHub'){
			steps{
				script{
					withCredentials([string(credentialsId: 'docker_creds', variable: 'docker')]) {
						
						sh 'docker login -u rishi236 -p ${docker}'
					    sh 'docker image push rishi236/$JOB_NAME:v1.$BUILD_ID'
					    sh 'docker image push rishi236/$JOB_NAME:latest'
					}
				}
			}
		}
		stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', 
		      projectId: env.PROJECT_ID, 
		      clusterName: env.CLUSTER_NAME, 
		      location: env.LOCATION, 
		      manifestPattern: 'deployment.yaml', 
		      credentialsId: env.CREDENTIALS_ID, 
		      verifyDeployments: true])
            }
        }
		/*stage('Docker build'){
        steps{
            script{
                sh 'docker build -t rishi236/hello:0.1 . '
            }
        }
       }
       stage('Docker login and push'){
        steps{
            withCredentials([string(credentialsId: 'docker_creds', variable: 'docker')]) {
            sh 'docker login -u rishi236 -p ${docker}'

            sh 'docker push rishi236/hello:0.1'
        }

       }
       }
		stage('Deploy to gke'){
        steps{
            
            step([$class: 'KubernetesEngineBuilder', 
		projectId: env.PROJECT_ID, 
		clusterName: env.CLUSTER_NAME,
		 location: env.LOCATION, 
		manifestPattern: 'deployment.yaml', 
		credentialsId: env.CREDENTIALS_ID,
		 verifyDeployments: true])
		   echo "Deployment Finished ..."
        }
       }*/
		/*stage("Deploy new image to Cloud Run"){
            steps{
                sh "gcloud run deploy back-end --image  rishi236/hello:0.1 --platform=managed --region=us-central1-c --port=8000 --revision-suffix=${IMAGE_VERSION}"
            }*/
}
}
