pipeline {

    options {
        disableConcurrentBuilds()
    }

    environment {
        SQL_PASSWORD = credentials('sa-password-creds')
    }

    parameters {
        string(description: 'Fill agent to run', name: 'build_agent')
        string(name: 'CSV_PATH', defaultValue: 'D:\\UpdateDB\\DatabaseInfo.csv', description: 'Path to database info file')
    }

    agent {
        label params['build_agent']
    }

    stages {
        stage('Update Databases') {
            steps {
                script {

                    // Define the path to CSV file
                    def csvFilePath = "${params.CSV_PATH}"

                    def csvFile = new File(csvFilePath)

                    // Read the CSV file
                    def csvData = file.readLines().tail()*.split(',')
                    echo "$csvData"

                    // def folderFix = "${env.WORKSPACE}\\Fix"

                    // def parallelBranches = [:]
                    
                    // // Iterate through each line
                    // for (line in lines) {
                    //     // Split each line by comma
                    //     def values = line.split(',')

                    //     // Extract Server and Database values
                    //     def server = values[0].trim()
                    //     def database = values[1].trim()

                    //     def branchLabel = "${server}_${database}"

                    //     parallelBranches[branchLabel] = {
                    //         echo "Updating database ${database} on server ${server}"

                    //         powershell script: """
                    //             .\\UpdateDatabases.ps1 -server ${server} -database ${database} -scriptFolder ${folderFix} -sqlPassword ${env.SQL_PASSWORD}
                    //         """
                    //     }
                    // }
                    
                    // parallel parallelBranches
                }
            }
        }
    }
}
