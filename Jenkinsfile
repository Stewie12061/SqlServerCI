pipeline {
    agent any

    environment {
        SQL_PASSWORD = credentials('sa-password-creds')
    }

    stages {
        stage('Update Databases') {
            steps {
                script {
                    def databaseInfo = readCSV file: 'DatabaseInfo.csv'

                    echo "Contents of databaseInfo:"

                    // Iterate through CSVRecords and print values
                    databaseInfo.each { csvRecord ->
                        csvRecord.each { key, value ->
                            echo "${key}: ${value}"
                        }
                    }
                    // def parallelBranches = [:]

                    // for (row in databaseInfo) {
                    //     def server = row.Server
                    //     def database = row.Database

                    //     def branchLabel = "${server}_${database}"

                    //     parallelBranches[branchLabel] = {
                    //         echo "Updating database ${database} on server ${server}"
                    //         powershell script: """
                    //             UpdateDatabases.ps1 -server ${server} -database ${database} -scriptFolder ${env.WORKSPACE} -sqlPassword ${env.SQL_PASSWORD}
                    //         """
                    //     }
                    // }

                    // parallel parallelBranches
                }
            }
        }
    }
}
