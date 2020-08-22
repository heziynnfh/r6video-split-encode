::0.9.1
::2020��3��29��22��22��
::2020��3��30��10��25��
::���û����ļ���������һ���ļ���
::2020��4��1��12��31��
::�������ļ���������Ϊ����ִ��ʱ��

::�ر���Ϣ��ʾ
@echo off

::����·������
set SOURCE_FILE=%~1
set SOURCE_FILE_NAME=%~n1
set SOURCE_FILE_PATH=%~dp1
set TEMP_PATH_NAME=temp%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,3%
set TEMP_PATH=%SOURCE_FILE_PATH%%TEMP_PATH_NAME%
set AVS_VIDEO_FILE=%TEMP_PATH%\video.avs
set AVS_AUDIO_FILE=%TEMP_PATH%\audio.avs

::���û�������
set ENVIRONMENT_MAIN_PATH=C:\Tools\MeGUI\tools
set MP4BOX_SOURCE=%ENVIRONMENT_MAIN_PATH%\mp4box\mp4box.exe
set FFMPEG_SOURCE=%ENVIRONMENT_MAIN_PATH%\ffmpeg\ffmpeg.exe
set LSMASH_LIB_SOURCE=%ENVIRONMENT_MAIN_PATH%\lsmash\LSMASHSource.dll
set X264_SOURCE=%ENVIRONMENT_MAIN_PATH%\x264\x264.exe

::����Դ�ļ�
echo ��Ƶ��ʼʱ�䣺��
set /p SPLIT_START=
echo ��Ƶ����ʱ�䣺��
set /p SPLIT_END=
md "%TEMP_PATH%"
"%FFMPEG_SOURCE%" -ss %SPLIT_START% -t %SPLIT_END% -y -i "%SOURCE_FILE%" -c copy "%TEMP_PATH%\%SOURCE_FILE_NAME%_split.mp4"
set SOURCE_FILE=%TEMP_PATH%\%SOURCE_FILE_NAME%_split.mp4

::������ƵAVS�ű�
echo LoadPlugin("%LSMASH_LIB_SOURCE%")>"%AVS_VIDEO_FILE%"
echo LSMASHVideoSource("%SOURCE_FILE%")>>"%AVS_VIDEO_FILE%"
echo #deinterlace>>"%AVS_VIDEO_FILE%"
echo #crop(320,0,-320,0)>>"%AVS_VIDEO_FILE%"
echo #LanczosResize(1706,720) # Lanczos (Sharp)>>"%AVS_VIDEO_FILE%"
echo LanczosResize(1280,720) # Lanczos (Sharp)>>"%AVS_VIDEO_FILE%"
echo #denoise>>"%AVS_VIDEO_FILE%"

::������ƵAVS�ű�
echo LoadPlugin("%LSMASH_LIB_SOURCE%")>"%AVS_AUDIO_FILE%"
echo LSMASHAudioSource("%SOURCE_FILE%", track=0)>>"%AVS_AUDIO_FILE%"

::���������Ƶ
"%FFMPEG_SOURCE%" -i "%SOURCE_FILE%" -y -vn -acodec copy "%TEMP_PATH%\%SOURCE_FILE_NAME%.aac"

::ѹ����Ƶ
::�е�������ͬ������ʱ����
::@"%FFMPEG_SOURCE%" -i "%AVS_AUDIO_FILE%" -y -acodec ac3 -ab 384k "%TEMP_PATH%\%SOURCE_FILE_NAME%.ac3"

::ѹ����Ƶ
"%FFMPEG_SOURCE%" -loglevel level+error -i "%AVS_VIDEO_FILE%" -strict -1 -f yuv4mpegpipe - | "%X264_SOURCE%" --keyint 600 --sar 1:1 --output "%TEMP_PATH%\%SOURCE_FILE_NAME%.264" --stdin y4m -"

::�ϲ�����Ƶ�ļ�
"%MP4BOX_SOURCE%" -add "%TEMP_PATH%\%SOURCE_FILE_NAME%.264#trackID=1:fps=60.0:par=1:1:name=" -add "%TEMP_PATH%\%SOURCE_FILE_NAME%.aac#trackID=1:name=" -tmp "%SOURCE_FILE_PATH:\=\\%" -new "%SOURCE_FILE_PATH%��ʽ����%SOURCE_FILE_NAME%.mp4"

::ɾ�������ļ�
RMDIR /S /Q "%TEMP_PATH%"

::�˳�
::pause
