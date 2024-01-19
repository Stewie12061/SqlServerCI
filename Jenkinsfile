pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }


    environment {
        SQL_PASSWORD = credentials('sa-password-creds')
    }

    stages {
        stage('Update Databases') {
            steps {
                script {

                    // Define the path to your CSV file
                    def csvFilePath = 'DatabaseInfo.csv'

                    // Read the CSV file
                    def csvData = readFile(file: csvFilePath).trim()

                    // Split the CSV data into lines
                    def lines = csvData.readLines()

                    def parallelBranches = [:]
                    
                    // Iterate through each line
                    for (line in lines) {
                        // Split each line by comma
                        def values = line.split(',')

                        // Extract Server and Database values
                        def server = values[0].trim()
                        def database = values[1].trim()

                        def branchLabel = "${server}_${database}"

                        parallelBranches[branchLabel] = {
                            echo "Updating database ${database} on server ${server}"
                            echo "${env.SQL_PASSWORD} - ${env.WORKSPACE}"
                            // powershell script: """
                            //     .\\UpdateDatabases.ps1 -server ${server} -database ${database} -scriptFolder ${env.WORKSPACE} -sqlPassword ${env.SQL_PASSWORD}
                            // """
                        }

                        // Now you can use 'server' and 'database' variables as needed in your Jenkins pipeline
                        // For example, you might want to perform some actions based on these values
                    }
                    

                    parallel parallelBranches
                }
            }
        }
    }
}
