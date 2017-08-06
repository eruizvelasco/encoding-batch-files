@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
	ECHO Processing %%G > CON
	ffmpeg -i "%%G"> "%%~dG%%~pnG.txt" 2>&1
	find "x2160" "%%~dG%%~pnG.txt" >nul && (
		IF NOT EXIST "%%~dG\4K%%~pG" (mkdir "%%~dG\4K%%~pG")
		IF NOT EXIST "%%~dG%%~pnG_1080p.mp4" (
			ECHO Re-encoding %%G > CON
			ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid -i "%%G" -c:a copy -vf scale_npp=1920:1080 -c:v h264_nvenc -b:v 5M "%%~dG%%~pnG_1080p.mp4"
			IF NOT errorlevel 1 (
				ECHO Moving file "%%G" to "%%~dG\4K%%~pG" > CON
				move /Y "%%G" "%%~dG\4K%%~pG"
			)
		)		
	)
	del "%%~dG%%~pnG.txt"
)
