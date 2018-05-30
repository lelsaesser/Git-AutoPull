# Git-AutoPull

$d_user = $env:UserName
$log_dir = $PSScriptRoot
git config --global --unset http.proxy
git config --global --unset https.proxy

while(1){
    try { 
        Set-Location -Path C:\Users\$d_user\git
    }  
    catch {
        Write-Host "Expected path C:\Users\" + $d_user + "\git not found"
        exit -1
    }

    Write-Output(Get-Date) | Tee-Object $log_dir\autopull_logfile.txt
    Write-Host "starting automated pull..."
    $repos = Get-ChildItem
    $repos | ForEach-Object {Set-Location -Path C:\Users\$d_user\git\$_ | git pull 2>&1 | Tee-Object -Append $log_dir\autopull_logfile.txt}
    Write-Host "Script finished. Logfile saved in"$log_dir"\autopull_logfile.txt"

    Start-Sleep -Seconds 300
}
