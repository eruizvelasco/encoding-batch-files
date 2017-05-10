@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mov') DO (
ECHO Processing file %%G > CON
IF NOT EXIST "%%~dG\MOV%%~pG" (mkdir "%%~dG\MOV%%~pG")
ECHO DirectShowSource^("%%G"^) > "%%~dG\MOV%%~pnG.avs"
ECHO Encoding file "%%~dG\MOV%%~pnG.avs" > CON
ffmpeg -y -i "%%~dG\MOV%%~pnG.avs" -filter:deint interlaced -c:v libx264 -c:a aac -b:a 160k "%%~dG%%~pnG.mp4"
IF NOT errorlevel 1 (
ECHO Moving file "%%G" to "%%~dG\MOV%%~pG" > CON
move /Y "%%G" "%%~dG\MOV%%~pG"
)
)