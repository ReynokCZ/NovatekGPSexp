@echo off
:: -- Batch title --
echo _____-----=====*********************************************=====-----_____

echo         +++ NovatekGPSexp v1 (BATCH SCRIPT by Reynok Flegmatyk) +++
echo                          reynok@greenmail.net
echo                               24.04.2019
echo.   
echo   ### Use Python script nvtk_mp42gpx.py by Sergei (https://sergei.nz) ###
echo.   
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

setlocal enabledelayedexpansion

:: -- File types definitions --
set filetypes=*.mp4 *.mov *.avi
if not exist "nvtk_mp42gpx.py" (
    echo Script nvtk_mp42gpx.py file not found^!
    echo.
    goto endprog
  )

:: -- Program body --

:bodyprog

for %%G in (%filetypes%) do (
  
  set nGPXfile=%%G
  set nGPXfile=!nGPXfile:~0,-4!
  if exist !nGPXfile!.gpx (
    echo.
    echo The !nGPXfile!.gpx already exist^!
    choice /c YN /n /m "Do you want to overwrite or not to skip it? [Y]/[N]"
    echo.
    if "!errorlevel!"=="1" (
    echo.
    echo ^>^>^>^> Generating GPX for video file %%G ^<^<^<^<
    python nvtk_mp42gpx.py -i "%%G" -o !nGPXfile!.gpx -f
    )
    if "!errorlevel!"=="2" (echo !nGPXfile!.gpx skipped.)
  ) else (
    echo.
    echo ^>^>^>^> Generating GPX for video file %%G ^<^<^<^<
    python nvtk_mp42gpx.py -i "%%G" -o !nGPXfile!.gpx
    )
)

:: -- End of application --

:endprog
echo ^^! ^^! ^^! END OF PROGRAM ^^! ^^! ^^!
echo.&PAUSE&GOTO:EOF

:: -- Python script description --
:: This script will attempt to extract GPS data from Novatek MP4 file and output it in GPX format.
:: Usage: ./nvtk_mp42gpx.py -i<inputfile> -o<outfile> [-f]
::        -i input file (will quit if does not exist)
::        -o output file (will quit if exists unless overriden)
::        -f force (optional, will overwrite output file)