<#
Function Get-Pi
---------------
Author: slws
Description: This function calculates the value of Pi (using the Gregory-Leibniz Series) upto a set number of decimal places.
Usage: Get-Pi <decimal places>
#>
Function Get-Pi {
[cmdletbinding()]
Param (
    [int]$dpReq
)
    If($PSBoundParameters.ContainsKey("dpReq")){
        Write-Output "Calculating Pi to $dpReq decimal places (DP)...`r`n"
    } Else {
        Write-Output "Number of decimal places (DP) required. e.g.: Get-Pi 6"
    }
    $piCharList = New-Object System.Collections.Generic.List[System.Object]
    $piChar = 0
    $divisor = 3
    $qtrPiINT = 1
    $piCount = 1
    [String]$piString = 0
    $1stStamp = Get-Date
    While($piCharList.count -lt $($dpReq+2)){
        $lastPiString = $piString
        If(($piCount % 2) -eq 1){
            $qtrPiINT = $qtrPiINT - (1/$divisor)
        } Else {
            $qtrPiINT = $qtrPiINT + (1/$divisor)
        }
        $piString = $($qtrPiINT * 4).ToString()
        #Write-Output "$piString"
        If($piString.ToCharArray()[$piChar] -eq $lastPiString.ToCharArray()[$piChar]){
            $piCharList.add($piString.ToCharArray()[$piChar])
            If($piCharList.count -gt 2){
                $dp = $piChar - 1
                If($dp -eq $dpReq){
                    Write-Output "`r`nPi to $dp DP is: `r`n$piCharList`r`n"
                #} Else {
                #    Write-Output "Found $dp DP: $piCharList"
                }
            }
            $piChar++
        }
        $divisor = $divisor + 2
        $piCount++
    }
    $2ndStamp = Get-Date
    If ($dpReq -gt 14){
        $aPiLength = 16
    } Else {
        $aPiLength = $dpReq + 2
    }
    [String]$actualPi = [Math]::pi
    Write-Output "$($actualPi.ToCharArray(0,$aPiLength)) (MathPi for comparison, max 14 DP)"
    $runtime = '{0:hh\:mm\:ss\.fff}' -f ($2ndStamp - $1stStamp)
    Write-Output "`r`nFinding $dp DP took $runtime!"
}
