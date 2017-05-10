FOR /F "tokens=*" %%G IN ('DIR /B /S *.wmv') DO (
IF NOT EXIST "%%~dG\wmv%%~pG" (mkdir "%%~dG\wmv%%~pG")
move /Y "%%G" "%%~dG\wmv%%~pG"
IF NOT EXIST "%%~dG%%~pnG.mp4" (
ffmpeg -i "%%~dG\wmv%%~pnG.wmv" -c:v libx264 -c:a aac -b:a 128k "%%~dG%%~pnG.mp4"
)
)