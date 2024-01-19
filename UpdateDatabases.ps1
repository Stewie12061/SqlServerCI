param(
    [string]$server,
    [string]$database,
    [string]$scriptFolder,
    [string]$sqlPassword
)

$connectionString = "Server=$server,1433;Database=$database;User Id=sa;Password=$sqlPassword;Trusted_Connection=False;"

Get-ChildItem -Path $scriptFolder -Filter *.sql -Recurse | ForEach-Object {
    Try
    {
        $scriptname = $_.Name
        $result = Invoke-Sqlcmd -ConnectionString $connectionString -InputFile $_.FullName -ErrorAction SilentlyContinue | Out-File -FilePath "UpdateDBLog.txt"
        Write-Host "[Completed] $scriptname"

    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        Write-Error "[Error running $scriptname]: $ErrorMessage"
    }
}
