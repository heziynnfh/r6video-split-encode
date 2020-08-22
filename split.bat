::最后修改
::2020年3月29日22点23分

::设置路径变量和环境变量
@echo 起始时间：？
@set /p SPLIT_START=
@echo 持续时间：？
@set /p SPLIT_END=
@set SOURCE_FILE=%~1
@set SOURCE_FILE_NAME=%~n1
@set FFMPEG_SOURCE=C:\Tools\MeGUI\tools\ffmpeg\ffmpeg.exe

::剪辑源文件
"%FFMPEG_SOURCE%" -ss %SPLIT_START% -t %SPLIT_END% -y -i "%SOURCE_FILE%" -c copy "%SOURCE_FILE_NAME%_split.mp4"
