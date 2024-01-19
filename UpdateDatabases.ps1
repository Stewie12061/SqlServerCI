param(
    [string]$server,
    [string]$database,
    [string]$scriptFolder,
    [string]$sqlPassword
)

$sqlServer = "$server,1433"

Get-ChildItem -Path $scriptFolder -Filter *.sql -Recurse | ForEach-Object {
    sqlcmd -S $sqlServer -U sa -P $sqlPassword -d $database -i $_.FullName -C -o "C:\UpdateDBLog.txt"
}
