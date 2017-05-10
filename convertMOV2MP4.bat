@ECHO OFF
Setlocal EnableDelayedExpansion
del "*.avs"
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mov') DO ECHO DirectShowSource("%%~dG%%~pnG.mov") > "%%~dG%%~pnG.avs"

FOR /F "tokens=*" %%G IN ('DIR /B /S *.avs') DO (
IF NOT EXIST "%%~dG\MOV%%~pG" (mkdir "%%~dG\MOV%%~pG")
move /Y "%%G" "%%~dG\MOV%%~pG"
ffmpeg -i "%%G" -c:v libx264 -c:a libvo_aacenc -b:a 128k "%%~dG%%~pnG.mp4"
del "%%~dG%%~pnG.avs"
)