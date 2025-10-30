@echo off
title Disable Windows Screenshot Tools
echo ========================================
echo    DISABLE Windows Screenshot Tools
echo ========================================
echo.
echo This will disable:
echo - Print Screen key
echo - Win+Shift+S shortcut
echo - Snipping Tool activation
echo.
echo Press Ctrl+C to cancel or...
pause

echo.
echo Disabling Print Screen key...
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /t REG_DWORD /d 0 /f

echo Disabling Win+Shift+S shortcut...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisabledHotkeys" /t REG_SZ /d "S" /f

echo Disabling Snipping Tool via policies...
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "DisableSnippingTool" /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo Applying changes...
echo (This will temporarily restart your desktop...)
timeout /t 2 >nul
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 3 >nul
start explorer.exe

echo.
echo ========================================
echo    SUCCESS: Screenshot tools DISABLED!
echo ========================================
echo.
echo Test it now:
echo - Press Print Screen key - nothing should happen
echo - Press Win+Shift+S - nothing should happen
echo.
echo To re-enable, run the "enable_screenshots.bat" file
echo.
pause