@echo off
title Screenshot Tools Controller
echo ========================================
echo    SCREENSHOT TOOLS CONTROLLER
echo ========================================
echo.
echo Choose an option:
echo.
echo [1] DISABLE screenshot tools
echo [2] ENABLE screenshot tools
echo [3] Exit
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto disable
if "%choice%"=="2" goto enable
if "%choice%"=="3" exit
echo Invalid choice! Press any key to exit...
pause >nul
exit

:disable
echo.
echo Disabling screenshot tools...
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisabledHotkeys" /t REG_SZ /d "S" /f
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "DisableSnippingTool" /t REG_DWORD /d 1 /f >nul 2>&1
goto restart

:enable
echo.
echo Enabling screenshot tools...
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /t REG_DWORD /d 1 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisabledHotkeys" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "DisableSnippingTool" /f >nul 2>&1

:restart
echo Applying changes...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 3 >nul
start explorer.exe
echo.
echo Operation completed successfully!
echo.
pause