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

                        def branchLabel = "Update database parallel"

                        parallelBranches[branchLabel] = {
                            def sourceFolder = "${env.WORKSPACE}\\Fix"
                            def targetFolder = "${env.WORKSPACE}\\Fix_${server}_${database}"

                            echo "Copying content from ${sourceFolder} to ${targetFolder}"
                            bat "robocopy \"${sourceFolder}\" \"${targetFolder}\" /E /MIR & EXIT /B 0"

                            echo "Updating database ${database} on server ${server}"

                            powershell script: """
                                .\\UpdateDatabases.ps1 -server ${server} -database ${database} -scriptFolder ${targetFolder} -sqlPassword ${env.SQL_PASSWORD}
                            """
                        }
                    }
                    

                    parallel parallelBranches
                }
            }
        }
    }
}
