@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
ffmpeg -i "%%G"> "%%~dG%%~pnG.txt" 2>&1
find "3840x2160" "%%~dG%%~pnG.txt" >nul && (
	ECHO "4K found - %%G")
)