@echo off
title Enable Windows Screenshot Tools
echo ========================================
echo    ENABLE Windows Screenshot Tools
echo ========================================
echo.
echo This will re-enable:
echo - Print Screen key
echo - Win+Shift+S shortcut
echo - Snipping Tool activation
echo.
echo Press Ctrl+C to cancel or...
pause

echo.
echo Enabling Print Screen key...
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /t REG_DWORD /d 1 /f

echo Enabling Win+Shift+S shortcut...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisabledHotkeys" /f >nul 2>&1

echo Enabling Snipping Tool via policies...
reg delete "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "DisableSnippingTool" /f >nul 2>&1

echo.
echo Applying changes...
echo (This will temporarily restart your desktop...)
timeout /t 2 >nul
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 3 >nul
start explorer.exe

echo.
echo ========================================
echo    SUCCESS: Screenshot tools ENABLED!
echo ========================================
echo.
echo Test it now:
echo - Press Print Screen key - should open Snipping Tool
echo - Press Win+Shift+S - should open snipping bar
echo.
pause