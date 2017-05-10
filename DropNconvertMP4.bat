IF NOT EXIST "%~d1%~pn1.mp4" (ffmpeg -i %1 -c:v libx264 -c:a aac -b:a 128k "%~d1%~pn1.mp4")
