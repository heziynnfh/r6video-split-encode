::����޸�
::2020��3��29��22��23��

::����·�������ͻ�������
@echo ��ʼʱ�䣺��
@set /p SPLIT_START=
@echo ����ʱ�䣺��
@set /p SPLIT_END=
@set SOURCE_FILE=%~1
@set SOURCE_FILE_NAME=%~n1
@set FFMPEG_SOURCE=C:\Tools\MeGUI\tools\ffmpeg\ffmpeg.exe

::����Դ�ļ�
"%FFMPEG_SOURCE%" -ss %SPLIT_START% -t %SPLIT_END% -y -i "%SOURCE_FILE%" -c copy "%SOURCE_FILE_NAME%_split.mp4"
