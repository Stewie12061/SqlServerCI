pipeline {

    options {
        disableConcurrentBuilds()
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
                    def excelFormat = CSVFormat.EXCEL
                    def records = readCSV file: "${params.CSV_PATH}", format: CSVFormat.DEFAULT.withHeader()

                    echo "$records"

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
