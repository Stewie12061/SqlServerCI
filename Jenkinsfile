pipeline {
    
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
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

                    def folderFix = "${params.FIX_PATH}"

                    def parallelBranches = [:]
                    
                    // Iterate through each line
                    for (record in records) {
                        def server = record['Server'].trim()
                        def database = record['Database'].trim()
                        def username = record['Username'].trim()
                        def password = record['Password'].trim()

                        def branchLabel = "${server}_${database}"
                        echo "$server - $database - $username -$password"

                        def psScript = """
                            \$connectionString = "Server=${server};Database=${database};User Id=${username};Password=${password};Trusted_Connection=False;"

                            Get-ChildItem -Path "${folderFix}" -Filter *.sql -Recurse | ForEach-Object {
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
