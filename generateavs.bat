@ECHO OFF
Setlocal EnableDelayedExpansion
FOR /F "tokens=*" %%G IN ('DIR /B /S *.mov') DO ECHO DirectShowSource("%%~dG%%~pnG.mov") > "%%~dG%%~pnG.avs"
