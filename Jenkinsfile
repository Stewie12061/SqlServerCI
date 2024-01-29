pipeline {

    options {
        disableConcurrentBuilds()
    }

    parameters {
        string(description: 'Fill agent to run', name: 'build_agent')
        string(name: 'CSV_PATH', defaultValue: 'D:\\UpdateDB\\DatabaseInfo.csv', description: 'Path to database info file')
        string(name: 'FIX_PATH', defaultValue: 'D:\\UpdateDB\\Fix', description: 'Path to folder fix')
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
                    def lines = records.readLines()

                    echo "$records"

                    def folderFix = "${env.WORKSPACE}\\Fix"

                    def parallelBranches = [:]
                    
                    // Iterate through each line
                    for (line in lines) {
                        // Split each line by comma
                        def values = line.split(',')

                        // Extract Server and Database values
                        def server = values[0].trim()
                        def database = values[1].trim()
                        def username = values[2].trim()
                        def password = value[3].trim()

                        def branchLabel = "${server}_${database}"

                        def psScript = """
                            \$connectionString = "Server=${server},1433;Database=${database};User Id=${username};Password=${password};Trusted_Connection=False;"

                            Get-ChildItem -Path ${folderFix} -Filter *.sql -Recurse | ForEach-Object {
                                Try
                                {
                                    \$scriptname = \$_.Name
                                    Invoke-Sqlcmd -ConnectionString \$connectionString -InputFile \$_.FullName -ErrorAction SilentlyContinue
                                    Write-Host "[Completed] \$scriptname"

                                }
                                Catch
                                {
                                    \$ErrorMessage = \$_.Exception.Message
                                    Write-Error "[Error running \$scriptname]: \$ErrorMessage"
                                }
                            }
                        """

                        parallelBranches[branchLabel] = {
                            echo "Updating database ${database} on server ${server}"
                            powershell(script: psScript)
                        }
                    }
                    
                    parallel parallelBranches
                }
            }
        }
    }
}
