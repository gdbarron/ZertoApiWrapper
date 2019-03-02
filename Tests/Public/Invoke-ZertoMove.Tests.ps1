$moduleFileName = "ZertoApiWrapper.psm1"
$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$commandName = $fileName -replace '.ps1', ''
$modulePath = $filePath -replace "Public", ""
Import-Module $modulePath\$moduleFileName -Force

$userName = "zerto\build"
$password = ConvertTo-SecureString -String "ZertoBuild" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential($userName, $password)

# $credential = Import-Clixml -Path C:\ZertoScripts\Creds.xml
$zertoServer = "192.168.1.100"
$zertoPort = "7669"

Describe "$commandName" {
    it "file should exist" {
        "$filePath\$fileName" | should exist
    }
    it "module should have a function called $commandName" {
        get-command $commandName | should be $true
    }
}