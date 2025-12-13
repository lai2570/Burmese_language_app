@echo off
echo ==========================================
echo 正在掃描 assets/audio 資料夾並將副檔名轉為小寫...
echo ==========================================

cd assets/audio

:: 呼叫 PowerShell 執行更名動作
powershell -Command "Get-ChildItem -Filter *.MP3 | ForEach-Object { Rename-Item $_.FullName -NewName ($_.Name.Replace('.MP3','.mp3')) }"

echo.
echo 完成！所有的 .MP3 都已經變成 .mp3 了。
echo 未來有新檔案放入時，請再次執行此檔案即可。
echo.
pause