# Git-AutoPull
# Author D071137

$d_user = $env:UserName
$log_dir = $PSScriptRoot
git config --global --unset http.proxy
git config --global --unset https.proxy
Write-Host "Guten Morgen Nikolas :)"

while(1){
    Write-Output(Get-Date) | Tee-Object $log_dir\autopull_logfile.txt
    try { 
        Set-Location -Path C:\Users\$d_user\git
    }  
    catch {
        Write-Output("Expected path C:\Users\" + $d_user + "\git not found") | Tee-Object -Append $log_dir\autopull_logfile.txt
        exit -1
    }

    Write-Host "starting automated pull..."
    $repos = Get-ChildItem
    $repos | ForEach-Object { Write-Output($_.Name) | Tee-Object -Append $log_dir\autopull_logfile.txt; 
                            Set-Location -Path C:\Users\$d_user\git\$_ | git pull 2>&1 | Tee-Object -Append $log_dir\autopull_logfile.txt; 
                            Write-Output("`n") | Tee-Object -Append $log_dir\autopull_logfile.txt}
    Write-Host "Script finished. Logfile saved in"$log_dir"\autopull_logfile.txt"

    Start-Sleep -Seconds 300
}
