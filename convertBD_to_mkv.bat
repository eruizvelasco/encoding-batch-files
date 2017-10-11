@ECHO OFF
REM ** convert4k_MP4_to_MKV batch file **
REM
REM By Enrique Ruiz-Velasco, enrique.velasco@gmail.com, All rights reserved 2017.
REM Use it under LGPL license. 
REM
REM This file process a bluray disc title in .m2ts to .mkv with 3 audios including trueHD @ 640kbps
REM then encodes to H264 using ffmpeg and moves the m2ts file moves to <drive>:\m2ts directory.
REM the output file is left in the directory of the original file.
REM
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.m2ts') DO (
	ECHO Processing %%G > CON
	REM ffmpeg -i %1 -codec copy -b:v 50M -b:a 50M "%~d1%~pn1.mkv"
	REM 10/11/2017 - ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid -i %1 -c:a copy -vf scale_npp=1920:1080 -c:v h265 -b:v 50M -b:a 50M "%~d1%~pn1.mkv" > CON
	ffmpeg -y -vsync 0 -hwaccel cuvid -c:v vc1_cuvid -i "%GG" -c:v h264_nvenc -b:v 6M -profile:v main -preset slow -rc vbr_hq -rc-lookahead 32 -max_muxing_queue_size 1000 -c:a copy -b:a 640k -map 0:0 -map 0:1 -map 0:2 -map 0:3 "%%~dG%%~pnG.mkv"
	IF NOT errorlevel 1 (
		IF NOT EXIST "%%~dG\m2ts%%~pG" (mkdir "%%~dG\m2ts%%~pG")
		ECHO Moving file %GG to "%%~dG\m2ts%%~pG" > CON
		move /Y %1 "%%~dG\m2ts%%~pG"
	)
)
