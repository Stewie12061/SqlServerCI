param(
    [string]$server,
    [string]$database,
    [string]$sourceFolder,
    [string]$targetFolder,
    [string]$sqlPassword
)

$connectionString = "Server=$server,1433;Database=$database;User Id=sa;Password=$sqlPassword;Trusted_Connection=False;"
robocopy \"$sourceFolder\" \"$targetFolder\" /E /MIR /MT:4 /NP /NDL /NFL /NC /NS

Get-ChildItem -Path $scriptFolder -Filter *.sql -Recurse | ForEach-Object {
    Try
    {
        $scriptname = $_.Name
        Invoke-Sqlcmd -ConnectionString $connectionString -InputFile $_.FullName -ErrorAction SilentlyContinue
        Write-Host "[Completed] $scriptname"

    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        Write-Error "[Error running $scriptname]: $ErrorMessage"
    }
}
