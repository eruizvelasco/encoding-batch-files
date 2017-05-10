FOR /F "tokens=*" %%G IN ('DIR /B /S *.wmv') DO (
IF NOT EXIST "%%~dG\wmv%%~pG" (mkdir "%%~dG\wmv%%~pG")
move /Y "%%G" "%%~dG\wmv%%~pG"
IF NOT EXIST "%%~dG%%~pnG.mp4" (
"C:\Program Files\Handbrake\HandBrakeCLI" -i "%%~dG\wmv%%~pG" -o "%%~dG%%~pnG.mp4" --preset="Normal" --quality=20
)
)