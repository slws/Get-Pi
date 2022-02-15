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
    Clear-Host
    If($PSBoundParameters.ContainsKey("dpReq")){
        Write-Output "Calculating Pi to $dpReq decimal places...`r`n"
    } Else {
        Write-Output "Number of decimal places required. e.g.: Get-Pi 6"
    }
    $1stStamp = Get-Date
    $piCharList = New-Object System.Collections.Generic.List[System.Object]
    $piChar = 0
    $divisor = 3
    $qtrPi = 1
    $piCount = 1
    [String]$pi = 0
    While($piCharList.count -lt $($dpReq+2)){
        $last1 = $pi
        If(($piCount % 2) -eq 1){
            $qtrPi = $qtrPi - 1/$divisor
        } Else {
            $qtrPi = $qtrPi + 1/$divisor
        }
        $pi = $($qtrPi*4).ToString()
        #Write-Output "$pi"
        If($pi.ToCharArray()[$piChar] -eq $last1.ToCharArray()[$piChar]){
            $piCharList.add($pi.ToCharArray()[$piChar])
            If($piCharList.count -gt 2){
                $dp = $piChar - 1
                If($dp -lt $dpReq){
                    Write-Output "Found $dp decimal places: $piCharList"
                } Else {
                    Write-Output "`r`nPi to $dp decimal places is: `r`n$piCharList"
                }
            }
            $piChar++
        }
        $divisor = $divisor + 2
        $piCount++
    }
    $2ndStamp = Get-Date
    If ($dpReq -gt 14){
        $aPiDPReq = 14
    } Else {
        $aPiDPReq = $dpReq
    }
    [String]$actualPi = [Math]::pi
    Write-Output "$($actualPi.ToCharArray(0,$aPiDPReq+2)) (MathPi for comparison, max 16 DP)"
    $runtime = '{0:hh\:mm\:ss\.fff}' -f ($2ndStamp - $1stStamp)
    Write-Output "`r`nFinding $dp decimal places took $runtime!"
}
