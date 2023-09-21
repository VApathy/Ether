$apps = @(
    '*xbox.tcui*',
    '*xboxgameoverlay*',
    '*xboxgamingoverlay*',
    '*xboxidentityprovider*',
    '*xboxspeechtotextoverlay*',
    'MicrosoftTeams'
)

foreach ($app in $apps) {
    $package = Get-AppxPackage -Name $app
    if ($package) {
        $package | Remove-AppxPackage
    } else {
        Write-Output "App with name $app not found on the system."
    }
}