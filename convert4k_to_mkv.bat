@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
	ECHO Processing %%G > CON
	ffprobe -analyzeduration 6000M -probesize 6000M -i "%%G"> "%%~dG%%~pnG.txt" 2>&1
	find "3840x" "%%~dG%%~pnG.txt" >nul && (
		IF NOT EXIST "%%~dG\4K%%~pG" (mkdir "%%~dG\4K%%~pG")
		IF NOT EXIST "%%~dG%%~pnG.mkv" (
			ECHO Re-encoding %%G > CON
			ffmpeg -i "%%G" -codec copy -b:v 50M -b:a 50M "%%~dG%%~pnG.mkv"
			IF NOT errorlevel 1 (
				ECHO Moving file "%%G" to "%%~dG\4K%%~pG" > CON
				move /Y "%%G" "%%~dG\4K%%~pG"
			)
		)		
	)
	del "%%~dG%%~pnG.txt"
)