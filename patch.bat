@echo off

echo.
echo Gokujou Parodius Mod by alamone.
echo This mod makes new games skip to a specific stage.
echo.

if not exist "gokuparo\321jad02.21b" goto errorout
if not exist "gokuparo\321jad04.27b" goto errorout

echo Generating Gokuparo patch...
echo.
combine-roms.exe 1 gokuparo\321jad04.27b gokuparo\321jad02.21b 321jad.bin

REM set the stage number below. 8 = special stage.

asm68k /e stage=8 /p gokuparo.asm, 321jad-p.bin
split-roms.exe 1 321jad-p.bin gokuparo-modded\321jad04.27b gokuparo-modded\321jad02.21b
echo.
echo Complete.  Results in "gokuparo-modded" folder.
goto ending

:errorout
echo Error: missing rom files.
echo.
echo Please copy Gokujou Parodius "321jad02.21b" and "321jad04.27b" into the "gokuparo" folder.

:ending
echo.
pause
