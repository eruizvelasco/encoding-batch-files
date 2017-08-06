@ECHO OFF
REM ** convert4k_to_1080 batch file **
REM
REM By Enrique Ruiz-Velasco, enrique.velasco@gmail.com, All rights reserved 2017.
REM Use it under LGPL license. 
REM
REM This file process all mp4 files in a directory and finds the files with 4096 or 3840 resolution
REM then scales to 1920x1080 and encodes the file using ffmpeg and moves the 4K file moves to <drive>:\4K directory.
REM the output file is left in the directory of the original file.
REM the ffmpeg command line uses CUDA acceleration 
REM
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mp4') DO (
	ECHO Processing %%G > CON
	ffprobe -analyzeduration 6000M -probesize 6000M -i "%%G"> "%%~dG%%~pnG.txt" 2>&1	
	find "4096x" "%%~dG%%~pnG.txt" >nul && CALL :Encode_Video "%%G" || (
		find "3840x" "%%~dG%%~pnG.txt" >nul && CALL :Encode_Video "%%G"
		)
)
GOTO :EOF

:Encode_Video
IF NOT EXIST "%~d1%~pn1.%~x1" (
	ECHO Re-encoding %1 > CON
	REM ffmpeg -i %1 -codec copy -b:v 50M -b:a 50M "%~d1%~pn1.mkv"
	ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid -i %1 -c:a copy -vf scale_npp=1920:1080 -c:v h264_nvenc -b:v 50M -b:a 50M "%~d1%~pn1_1080p.%~x1" > CON
	IF NOT errorlevel 1 (
		IF NOT EXIST "%~d1\4K%~p1" (mkdir "%~d1\4K%~p1")
		ECHO Moving file %1 to "%~d1\4K%~p1" > CON
		move /Y %1 "%~d1\4K%~p1"
	)
)
del "%~d1%~pn1.txt"
EXIT /B