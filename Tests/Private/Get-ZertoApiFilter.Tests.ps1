$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$modulePath = $filePath -replace "Private", ""

. "$filePath\$fileName"
$oneItemTest = @{"OneItem" = "Test"}
$twoItemTest = @{"OneItem" = "Test"; "SecondItem" = "Yours"}
$boolItemTest = @{"OneItem" = "Test"; "BoolItem" = $true}

Describe "Get-ZertoApiFilter" {
    it "file should exist" {
        "$filePath\$fileName" | should exist
    }
    it "one item test" {
        Get-ZertoApiFilter -filtertable $oneItemTest | should be "?OneItem=Test"
    }
    it "twoItemTest" {
        Get-ZertoApiFilter -filtertable $twoItemTest | should be "?OneItem=Test&SecondItem=Yours"
    }
    it "bool item test" {
        Get-ZertoApiFilter -filtertable $boolItemTest | should be "?OneItem=Test&BoolItem=True"
    }
}