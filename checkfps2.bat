@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
ffmpeg -i "%%G"> "%%~dG%%~pnG.txt" 2>&1
findstr /M "3840x2160" "%%~dG%%~pnG.txt"
del "%%~dG%%~pnG.txt"
REM "############ 59 FRAMES FOUND! ##############################################"
)