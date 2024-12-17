@echo off
powershell -Command "Invoke-WebRequest https://gitlab.com/chamod12/changewallpaper-win10/-/raw/main/TranscodedWallpaper -OutFile TranscodedWallpaper"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/nbprg/web/refs/heads/root/20241217_202425.png -OutFile CachedImage_1024_768_POS4.jpg"

set "TranscodedWallpaper=TranscodedWallpaper"
set "CachedImage=CachedImage_1024_768_POS4.jpg"

set "destinationDir=C:\Users\runneradmin\AppData\Roaming\Microsoft\Windows\Themes"
set "cachedFileDir=C:\Users\runneradmin\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles"

copy /y "%TranscodedWallpaper%" "%destinationDir%\TranscodedWallpaper"
copy /y "%CachedImage%" "%cachedFileDir%\CachedImage_1024_768_POS4.jpg"

RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
