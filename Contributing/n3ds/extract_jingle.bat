@echo off
setlocal enabledelayedexpansion

:: --- CONFIGURATION ---
:: Define paths to your tools (adjust if folder names differ)
set TOOL_3DS="3DS Tool\3dstool.exe"
set VGM="vgmstream\vgmstream-cli.exe"

echo -------------------------------------------------------
echo 3DS Banner Jingle Extractor (Batch Mode)
echo -------------------------------------------------------

:: Loop through all .cci files in the current directory
:: Note: Rename your files to .cci before running this!
for %%f in (*.cci) do (
    echo [Processing] %%f...
    
    :: 1. Extract Partition 0 (CXI) from the 3DS ROM
    %TOOL_3DS% -xvtf cci "%%f" -0 partition0.cxi
    
    :: 2. Extract ExeFS from Partition 0
    %TOOL_3DS% -xvtf cxi partition0.cxi --exefs exefs.bin --exefs-auto-key
    %TOOL_3DS% -xvtfu exefs exefs.bin --exefs-dir exefs_dir
    
    :: 3. Extract the Banner file from ExeFS
    if exist exefs_dir\banner.bnr (
        copy exefs_dir\banner.bnr banner.bin >nul
        %TOOL_3DS% -xvtf banner banner.bin --banner-dir banner_dir
        
        :: 4. Fix BCWAV Header via Python (Trims garbage data based on declared size)
        python -c "import struct; f=open('banner_dir/banner.bcwav','rb'); data=f.read(); f.close(); size=struct.unpack('<I', data[12:16])[0]; f=open('banner_dir/banner.bcwav','wb'); f.write(data[:size]); f.close()"
        
        :: 5. Convert fixed BCWAV to WAV using vgmstream
        %VGM% banner_dir\banner.bcwav -o "%%~nf.wav"
        
        echo [Success] Jingle saved as: %%~nf.wav
    ) else (
        echo [Error] No banner found in %%f
    )
    
    :: --- CLEANUP ---
    :: Remove temporary files and directories to keep the folder clean
    if exist exefs_dir rd /s /q exefs_dir
    if exist banner_dir rd /s /q banner_dir
    if exist partition0.cxi del partition0.cxi
    if exist exefs.bin del exefs.bin
    if exist banner.bin del banner.bin
    
    echo -------------------------------------------------------
)

echo Extraction Complete!

pause
