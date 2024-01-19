param(
    [string]$server,
    [string]$database,
    [string]$scriptFolder,
    [string]$sqlPassword
)

$sqlServer = "Server=$server;Database=$database;User Id=sa;Password=$sqlPassword;Trusted_Connection=False;"

Get-ChildItem -Path $scriptFolder -Filter *.sql -Recurse | ForEach-Object {
    sqlcmd -S $sqlServer -U sa -P $sqlPassword -d $database -i $_.FullName
}
