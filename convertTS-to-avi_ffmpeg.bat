@ECHO OFF
REM ** convertTS_to_1080 batch file **
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
FOR /F "tokens=*" %%G IN ('DIR /B /S *.ts') DO (
	ECHO Processing %%G > CON
	CALL :Encode_Video "%%G"	
)
GOTO :EOF

:Encode_Video
REM ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid -i %1 -vf scale_npp=1920:1080 -c:v h264_nvenc -b:v 12M -profile:v main -preset slow -rc vbr_hq -rc-lookahead 32 -acodec pcm_s16le -ar 48000 "%~d1%~pn1_1080p.avi" > CON
	ffmpeg -y -vsync 0 -i %1 -c:v copy -acodec pcm_s16le -ar 48000 "%~d1%~pn1_1080p.avi" > CON
EXIT /B
