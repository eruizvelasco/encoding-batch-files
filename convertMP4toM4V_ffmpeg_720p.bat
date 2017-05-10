FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
IF NOT EXIST "%%~dG\m4v%%~pG" (mkdir "%%~dG\m4v%%~pG")
IF NOT EXIST "%%~dG\m4v%%~pnG.m4v" (
ffmpeg -i "%%G" -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:v libx264 -c:a aac -b:a 128k -profile:v high -level 4.2 "%%~dG\m4v%%~pnG.m4v"
)