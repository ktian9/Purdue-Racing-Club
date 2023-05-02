@echo off
setlocal
set /p file_location= Please Type the Location of Downloaded Zip File (Example: C:\Users\Kevin\Desktop\files.zip): 
set /p ac_location= Please Type the Location of Assetto Corsa's Content Folder (Example: C:\Program Files (x86)\Steam\steamapps\common\assettocorsa\content): 

echo/
echo "Are these two paths correct?"
echo Assetto Corsa 'content' folder: "%ac_location%" 
echo Downloaded Zip File (files.zip): "%file_location%"
echo/


echo "Files will temporarily be unzipped to a folder on your desktop titled 'Purdue Racing Club'."
echo "(match capitalization)"
set /p AREYOUSURE=Are you sure (y/[n])?
IF /I "%AREYOUSURE%" NEQ "y" GOTO END




cd /d %~dp0
Call :UnZipFile "%USERPROFILE%\Desktop\Purdue Racing Club" "%file_location%"
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%

:: moving all cars to cars folder in ac
xcopy "%USERPROFILE%\Desktop\Purdue Racing Club\cars\*" "%ac_location%\cars\*" /s /e /i /Y
:: move "%USERPROFILE%\Desktop\Purdue Racing Club\cars\*.*" "%ac_location%\cars\"

:: moving all driver to driver folder in ac
move "%USERPROFILE%\Desktop\Purdue Racing Club\driver\*" "%ac_location%\driver\"

:: moving all fonts to fonts folder in ac
move "%USERPROFILE%\Desktop\Purdue Racing Club\fonts\*" "%ac_location%\fonts\"

:: moving all crew_band and driver_gloves to respective folders in ac
xcopy "%USERPROFILE%\Desktop\Purdue Racing Club\texture\crew_band\*" "%ac_location%\texture\crew_brand\*" /s /e /i /Y
::move "%USERPROFILE%\Desktop\Purdue Racing Club\texture\crew_band\*.*" "%ac_location%\texture\crew_brand\"
xcopy "%USERPROFILE%\Desktop\Purdue Racing Club\texture\driver_gloves\*" "%ac_location%\texture\driver_gloves\*" /s /e /i /Y
::move "%USERPROFILE%\Desktop\Purdue Racing Club\texture\driver_gloves\*.*" "%ac_location%\texture\driver_gloves\"


pause

echo "Files have been moved to Asseto Corsa Content Folder. Would you like to delete the contents of the temporary folder 'Purdue Racing Club' on your desktop?"
set /p AREYOUSURE=Are you sure (y/[n])?
IF /I "%AREYOUSURE%" NEQ "y" GOTO END

rmdir /s "%USERPROFILE%\Desktop\Purdue Racing Club\"




