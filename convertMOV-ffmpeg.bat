@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mov') DO (
ECHO Processing file %%G > CON
IF NOT EXIST "%%~dG\MOV%%~pG" (mkdir "%%~dG\MOV%%~pG")
REM ffmpeg -y -i "%%G" -vf "yadif=1:-1:1" -c:v libx264 -c:a aac -b:a 128k "%%~dG%%~pnG.mp4"
ffmpeg -y -i "%%G" -vf "yadif=1:-1:1" -c:v h264_nvenc -profile:v main -b:v 3M -preset slow -rc vbr_hq -rc-lookahead 32 -c:a aac -b:a 128k "%%~dG%%~pnG.mp4"
IF NOT errorlevel 1 (
ECHO Moving file "%%G" to "%%~dG\MOV%%~pG" > CON
move /Y "%%G" "%%~dG\MOV%%~pG"
)
)