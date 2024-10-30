pipeline {
    agent any

    stages {
        // Stage for checking out the code from the Git repository
        stage("Checkout code") {
            steps {
                script {
                    // Check if the 'nodejs.org' directory exists; if not, clone the repository
                    if (!fileExists('nodejs.org')) {
                        sh 'git clone https://github.com/AmiiRa84/FinalProject'
                    }
                    // Navigate into the 'nodejs.org' directory
                    dir('nodejs.org') {
                        // Fetch the latest changes from the remote repository
                        sh 'git fetch origin'
                        // Checkout the 'main' branch
                        sh 'git checkout main'
                        // Pull the latest changes
                        sh 'git pull'
                    }
                }
            }
        }
        // Stage for installing project dependencies using npm
        stage("Install dependencies") {
            steps {
                // Navigate into the 'nodejs.org' directory
                dir('nodejs.org') {
                    // Install dependencies defined in package-lock.json
                    sh 'npm ci'
                }
            }
        }
        // Stage for running unit tests
        stage("Run unit testing") {
            steps {
                // Navigate into the 'nodejs.org' directory
                dir('nodejs.org') {
                    // Execute the test script defined in package.json
                    sh 'npm run test'
                }
            }
        }
        // Stage for building a Docker image
        stage("Dockerize") {
            steps {
                // Navigate into the 'nodejs.org' directory
                dir('nodejs.org') {
                    // Build the Docker image with the specified tag
                    sh 'docker build -t amiira84/nodejs.org .'
                }
            }
        }
        // Stage for pushing the Docker image to a registry
        stage("Push Docker image") {
            steps {
                // Navigate into the 'nodejs.org' directory
                dir('nodejs.org') {
                    // Use credentials for Docker login
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Login to Docker using the provided credentials
                        sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                        // Push the Docker image to the repository
                        sh 'docker push amiira84/nodejs.org'
                    }
                }
            }
        }
    }
}
