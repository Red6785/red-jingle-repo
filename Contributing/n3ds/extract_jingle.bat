@echo off
setlocal disabledelayedexpansion

:: --- CONFIGURATION ---
set "TOOL_3DS=%~dp0tools\windows\3dstool.exe"
set "VGM=%~dp0tools\windows\vgmstream-cli.exe"

echo -------------------------------------------------------
echo 3DS Banner Jingle Extractor (Batch Mode)
echo -------------------------------------------------------

if not exist "%~dp0_sanitize.py" (
    echo [Error] _sanitize.py not found. Place it in the same folder as this script.
    pause
    exit /b 1
)
if not exist "%~dp0tools\windows\3dstool.exe" (
    echo [Error] 3dstool.exe not found. Expected at: tools\windows\3dstool.exe
    pause
    exit /b 1
)
if not exist "%~dp0tools\windows\vgmstream-cli.exe" (
    echo [Error] vgmstream-cli.exe not found. Expected at: tools\windows\vgmstream-cli.exe
    pause
    exit /b 1
)

:: Resolve paths relative to the script location (Contributing\n3ds\)
:: The repo root is two levels up.
pushd "%~dp0"
set "SCRIPT_DIR=%CD%"
cd ..\..
set "REPO_ROOT=%CD%"
popd

set "JINGLES_DIR=%REPO_ROOT%\jingles\n3ds"
set "INDEX_JSON=%REPO_ROOT%\index.json"
set "GAMES_DIR=%SCRIPT_DIR%\games"

if not exist "%JINGLES_DIR%" mkdir "%JINGLES_DIR%"
if not exist "%GAMES_DIR%" mkdir "%GAMES_DIR%"

for %%f in ("%GAMES_DIR%\*.3ds" "%GAMES_DIR%\*.cci" "%GAMES_DIR%\*.app" "%GAMES_DIR%\*.cia" "%GAMES_DIR%\*.z3ds" "%GAMES_DIR%\*.zcci") do (
    echo [Processing] %%~nxf...

    "%TOOL_3DS%" -xvtf cci "%%f" -0 partition0.cxi >nul 2>&1
    "%TOOL_3DS%" -xvtf cxi partition0.cxi --exefs exefs.bin --exefs-auto-key >nul 2>&1
    "%TOOL_3DS%" -xvtfu exefs exefs.bin --exefs-dir exefs_dir >nul 2>&1

    if exist exefs_dir\banner.bnr (
        copy exefs_dir\banner.bnr banner.bin >nul
        "%TOOL_3DS%" -xvtf banner banner.bin --banner-dir banner_dir >nul 2>&1

        python -c "import struct;d=open('banner_dir/banner.bcwav','rb').read();s=struct.unpack('<I',d[12:16])[0];open('banner_dir/banner.bcwav','wb').write(d[:s])"

        call :process_banner "%%~nf"

    ) else (
        echo [Error] No banner found in %%f
    )

    if exist exefs_dir rd /s /q exefs_dir
    if exist banner_dir rd /s /q banner_dir
    if exist partition0.cxi del partition0.cxi
    if exist exefs.bin del exefs.bin
    if exist banner.bin del banner.bin

    echo -------------------------------------------------------
)

echo Extraction Complete!
pause
goto :eof

:process_banner
setlocal enabledelayedexpansion

for /f "delims=" %%s in ('python "%~dp0_sanitize.py" "%~1"') do set "FINAL=%%s"
for /f "delims=" %%t in ('python "%~dp0_game_title.py" "%~1"') do set "GAME_TITLE=%%t"

"%VGM%" banner_dir\banner.bcwav -o "!JINGLES_DIR!\!FINAL!" >nul 2>&1
echo [Success] Saved as: !FINAL! (Game: !GAME_TITLE!)

python "%~dp0_update_index.py" "!INDEX_JSON!" "!GAME_TITLE!" "jingles/n3ds/!FINAL!"

endlocal
goto :eof
