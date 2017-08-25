FOR /F "tokens=*" %%G IN ('DIR /B /S *.wmv') DO (
IF NOT EXIST "%%~dG\wmv%%~pG" (mkdir "%%~dG\wmv%%~pG")
move /Y "%%G" "%%~dG\wmv%%~pG"
IF NOT EXIST "%%~dG%%~pnG.mp4" (
REM ffmpeg -i "%%~dG\wmv%%~pnG.wmv" -c:v libx264 -c:a aac -b:a 128k "%%~dG%%~pnG.mp4"
ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid -i "%%~dG\wmv%%~pnG.wmv" -c:a copy -c:v h264_nvenc -b:v 3M  -b:a 128k "%%~dG%%~pnG.mp4"
)
)