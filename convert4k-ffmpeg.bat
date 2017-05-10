@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
ffmpeg -i "%%G"> "%%~dG%%~pnG.txt" 2>&1
find "3840x2160" "%%~dG%%~pnG.txt" >nul && (
IF NOT EXIST "%%~dG\4K%%~pG" (mkdir "%%~dG\4K%%~pG")
move /Y "%%G" "%%~dG\4K%%~pG"
IF NOT EXIST "%%~dG%%~pnG.mp4" (
ffmpeg -i "%%~dG\4K%%~pnG.MP4" -s 1920x1080 -c:v libx264 -c:a copy "%%~dG%%~pnG_1080p.mp4"
)
)
del "%%~dG%%~pnG.txt"
)